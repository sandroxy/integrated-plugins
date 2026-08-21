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
          v-if="!failedItems[item.id]"
          class="levixel-source media-image"
          :src="previewUrl(item)"
          mode="aspectFill"
          @click="openViewer(index)"
          @load="handleLoad(item, $event)"
          @error="handleError(item)"
        />
        <view v-else class="levixel-source retry-surface" @click="retry(item)">
          <view class="retry-icon" />
          <text class="retry-label">Retry</text>
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
  warmupLevixelItem,
} from '@/nativeplugins/SandroxUniPlugin-Levixel/js_sdk/index.js'
import { levixelMedia, levixelPreviewUrl } from '@/data/levixelMedia.js'

export default {
  name: 'LevixelPage',
  data() {
    return {
      media: levixelMedia,
      failedItems: {},
      revisions: {},
      lastEventType: '',
      removeEventListener: null,
    }
  },
  onLoad() {
    this.removeEventListener = onLevixelEvent((event) => {
      if (event && typeof event.type === 'string')
        this.lastEventType = event.type
    })
  },
  onUnload() {
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
    previewUrl(item) {
      const baseUrl = levixelPreviewUrl(item)
      const revision = this.revisions[item.id]
      if (!revision)
        return baseUrl
      const separator = baseUrl.includes('?') ? '&' : '?'
      return `${baseUrl}${separator}retry=${revision}`
    },
    handleLoad(item, event) {
      if (this.failedItems[item.id]) {
        const nextFailedItems = { ...this.failedItems }
        delete nextFailedItems[item.id]
        this.failedItems = nextFailedItems
      }
      warmupLevixelItem(item, event)
    },
    handleError(item) {
      this.failedItems = { ...this.failedItems, [item.id]: true }
    },
    retry(item) {
      const nextFailedItems = { ...this.failedItems }
      delete nextFailedItems[item.id]
      this.failedItems = nextFailedItems
      this.revisions = { ...this.revisions, [item.id]: Date.now() }
    },
    async openViewer(index) {
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
  padding-top: env(safe-area-inset-top);
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
.retry-surface {
  width: 100%;
  height: 100%;
}

.retry-surface {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: #edf0f5;
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
