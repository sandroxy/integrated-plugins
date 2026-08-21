<template>
  <view class="page">
    <view class="navigation-bar">
      <view class="navigation-content">
        <view class="back-button" aria-label="Back" @click="goBack">
          <view class="back-icon" />
        </view>
        <text class="navigation-title">Levixel</text>
      </view>
    </view>

    <view class="gallery">
      <view
        v-for="(item, index) in media"
        :key="item.id"
        class="media-cell"
        :class="{ portrait: item.height > item.width && item.type === 'image' }"
      >
        <image
          v-if="preparedPreviewSources[item.id]"
          class="levixel-source media-image"
          :src="preparedPreviewSources[item.id]"
          mode="aspectFill"
          @click="openViewer(item, index)"
          @load="handleLoad(item, $event)"
          @error="handleError(item)"
        />
        <view v-else-if="failedItems[item.id]" class="levixel-source retry-surface" @click="retry(item)">
          <view class="retry-icon" />
          <text class="retry-label">Retry</text>
        </view>
        <view v-else class="levixel-source preview-placeholder">
          <view class="preview-spinner" />
        </view>
        <view v-if="item.type === 'video'" class="video-badge">
          <view class="play-icon" />
          <text>VIDEO</text>
        </view>
        <text class="media-label">{{ labelFor(item.id) }}</text>
      </view>
    </view>
  </view>
</template>

<script>
import {
  onLevixelEvent,
  openLevixelFromSelector,
  prepareLevixelItem,
  warmupLevixelItem,
} from '@/nativeplugins/SandroxUniPlugin-Levixel/js_sdk/index.js'
import { levixelMedia } from '@/data/levixelMedia.js'

export default {
  name: 'LevixelPage',
  data() {
    return {
      media: levixelMedia,
      preparedPreviewSources: {},
      readyItems: {},
      failedItems: {},
      previewPreparationGeneration: 0,
      lastEventType: '',
      removeEventListener: null,
    }
  },
  onLoad() {
    this.removeEventListener = onLevixelEvent((event) => {
      if (event && typeof event.type === 'string')
        this.lastEventType = event.type
    })
    this.previewPreparationGeneration += 1
    this.prepareAllPreviews(this.previewPreparationGeneration)
  },
  onUnload() {
    this.previewPreparationGeneration += 1
    if (this.removeEventListener)
      this.removeEventListener()
    this.removeEventListener = null
  },
  methods: {
    goBack() {
      uni.navigateBack()
    },
    labelFor(id) {
      return id
        .split('-')
        .map(part => part.charAt(0).toUpperCase() + part.slice(1))
        .join(' ')
    },
    async prepareAllPreviews(generation) {
      let nextIndex = 0
      const worker = async () => {
        while (generation === this.previewPreparationGeneration) {
          const index = nextIndex
          nextIndex += 1
          if (index >= this.media.length)
            return
          await this.preparePreview(this.media[index], generation)
        }
      }
      const workerCount = Math.min(3, this.media.length)
      await Promise.all(Array.from({ length: workerCount }, () => worker()))
    },
    async preparePreview(item, generation = this.previewPreparationGeneration) {
      try {
        const prepared = await prepareLevixelItem(item, { priority: true })
        if (generation !== this.previewPreparationGeneration)
          return
        if (!prepared || !prepared.src) {
          this.handleError(item)
          return
        }
        this.preparedPreviewSources = {
          ...this.preparedPreviewSources,
          [item.id]: prepared.src,
        }
      }
      catch (_) {
        if (generation === this.previewPreparationGeneration)
          this.handleError(item)
      }
    },
    handleLoad(item, event) {
      this.readyItems = { ...this.readyItems, [item.id]: true }
      if (this.failedItems[item.id]) {
        const nextFailedItems = { ...this.failedItems }
        delete nextFailedItems[item.id]
        this.failedItems = nextFailedItems
      }
      warmupLevixelItem(item, event).catch(() => {})
    },
    handleError(item) {
      const nextPreparedPreviewSources = { ...this.preparedPreviewSources }
      delete nextPreparedPreviewSources[item.id]
      this.preparedPreviewSources = nextPreparedPreviewSources
      const nextReadyItems = { ...this.readyItems }
      delete nextReadyItems[item.id]
      this.readyItems = nextReadyItems
      this.failedItems = { ...this.failedItems, [item.id]: true }
    },
    retry(item) {
      const nextFailedItems = { ...this.failedItems }
      delete nextFailedItems[item.id]
      this.failedItems = nextFailedItems
      this.preparePreview(item)
    },
    async openViewer(item, index) {
      if (!this.readyItems[item.id])
        return
      try {
        await openLevixelFromSelector({
          items: this.media,
          index,
          theme: 'dark',
          sourceVisibility: 'visible',
          sourceSelector: '.levixel-source',
          sourceStyles: this.media.map(() => ({
            objectFit: 'cover',
            cornerRadius: uni.upx2px(12),
          })),
        })
      }
      catch (error) {
        uni.showToast({
          title: error instanceof Error ? error.message : 'Unable to open Levixel',
          icon: 'none',
        })
      }
    },
  },
}
</script>

<style scoped>
.page {
  min-height: 100vh;
  background: #ffffff;
}

.navigation-bar {
  position: sticky;
  z-index: 5;
  top: 0;
  padding-top: var(--status-bar-height);
  background: #17365f;
}

.navigation-content {
  box-sizing: border-box;
  display: flex;
  height: 92rpx;
  padding: 0 24rpx;
  align-items: center;
}

.back-button {
  display: flex;
  width: 64rpx;
  height: 64rpx;
  align-items: center;
  justify-content: center;
}

.back-icon {
  width: 22rpx;
  height: 22rpx;
  border-bottom: 4rpx solid #ffffff;
  border-left: 4rpx solid #ffffff;
  transform: rotate(45deg);
}

.navigation-title {
  margin-left: 8rpx;
  color: #ffffff;
  font-size: 34rpx;
  font-weight: 700;
}

.gallery {
  display: grid;
  padding: 22rpx 24rpx calc(env(safe-area-inset-bottom) + 32rpx);
  grid-auto-flow: dense;
  grid-auto-rows: 222rpx;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 14rpx;
}

.media-cell {
  position: relative;
  min-width: 0;
  overflow: hidden;
  border-radius: 12rpx;
  background: #e8ebf1;
}

.media-cell.portrait {
  grid-row: span 2;
}

.media-image,
.retry-surface,
.preview-placeholder {
  width: 100%;
  height: 100%;
}

.retry-surface,
.preview-placeholder {
  display: flex;
  align-items: center;
  justify-content: center;
  background: #edf0f5;
}

.retry-surface {
  flex-direction: column;
}

.preview-spinner {
  width: 30rpx;
  height: 30rpx;
  border: 4rpx solid rgba(89, 101, 123, 0.25);
  border-top-color: #59657b;
  border-radius: 50%;
  animation: preview-spin 0.8s linear infinite;
}

@keyframes preview-spin {
  to {
    transform: rotate(360deg);
  }
}

.retry-icon {
  width: 28rpx;
  height: 28rpx;
  border: 4rpx solid #657086;
  border-right-color: transparent;
  border-radius: 50%;
}

.retry-label {
  margin-top: 12rpx;
  color: #59657b;
  font-size: 24rpx;
  font-weight: 600;
}

.video-badge,
.media-label {
  position: absolute;
  z-index: 2;
  left: 14rpx;
  border-radius: 7rpx;
  background: rgba(18, 24, 34, 0.7);
  color: #ffffff;
  font-weight: 700;
}

.video-badge {
  display: flex;
  top: 14rpx;
  padding: 7rpx 10rpx;
  align-items: center;
  font-size: 19rpx;
}

.play-icon {
  width: 0;
  height: 0;
  margin-right: 7rpx;
  border-top: 7rpx solid transparent;
  border-bottom: 7rpx solid transparent;
  border-left: 11rpx solid #ffffff;
}

.media-label {
  bottom: 14rpx;
  max-width: calc(100% - 28rpx);
  padding: 7rpx 10rpx;
  overflow: hidden;
  font-size: 21rpx;
  text-overflow: ellipsis;
  white-space: nowrap;
}
</style>
