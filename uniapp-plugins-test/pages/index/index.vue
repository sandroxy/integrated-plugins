<template>
  <view class="page">
    <view class="hero">
      <text class="eyebrow">NATIVE PLUGIN LAB</text>
      <text class="title">UniApp Native Plugins</text>
      <text class="summary">Packaged plugins, isolated in focused verification screens.</text>
    </view>

    <view class="content">
      <text class="section-title">Available plugins</text>
      <text class="section-summary">Open a plugin to verify its public artifact.</text>

      <view class="plugin-row" @click="openLevixel">
        <view class="plugin-icon" aria-hidden="true">
          <view class="image-mark">
            <view class="image-sun" />
            <view class="image-mountain image-mountain-left" />
            <view class="image-mountain image-mountain-right" />
          </view>
        </view>
        <view class="plugin-copy">
          <text class="plugin-name">Levixel</text>
          <text class="plugin-summary">Shared-transition image and video viewer</text>
        </view>
        <view class="chevron" aria-hidden="true" />
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'IndexPage',
  methods: {
    openLevixel() {
      uni.navigateTo({ url: '/pages/levixel/index' })
    },
  },
}
</script>

<style scoped>
.page {
  box-sizing: border-box;
  min-height: 100vh;
  background: #f3f5f9;
}

.hero {
  box-sizing: border-box;
  display: flex;
  min-height: 420rpx;
  padding: calc(env(safe-area-inset-top) + 76rpx) 48rpx 54rpx;
  flex-direction: column;
  justify-content: flex-end;
  background: #17365f;
  color: #ffffff;
}

.eyebrow {
  align-self: flex-start;
  padding: 10rpx 18rpx;
  border-radius: 8rpx;
  background: #2a517d;
  font-size: 22rpx;
  font-weight: 700;
}

.title {
  margin-top: 30rpx;
  font-size: 54rpx;
  font-weight: 700;
  line-height: 1.12;
}

.summary {
  max-width: 600rpx;
  margin-top: 16rpx;
  color: #d6e1ef;
  font-size: 27rpx;
  line-height: 1.45;
}

.content {
  padding: 42rpx 44rpx calc(env(safe-area-inset-bottom) + 48rpx);
}

.section-title {
  display: block;
  color: #152033;
  font-size: 34rpx;
  font-weight: 700;
}

.section-summary {
  display: block;
  margin-top: 8rpx;
  color: #748096;
  font-size: 25rpx;
}

.plugin-row {
  box-sizing: border-box;
  display: flex;
  min-height: 150rpx;
  margin-top: 40rpx;
  padding: 24rpx;
  align-items: center;
  border: 1rpx solid #e3e8f0;
  border-radius: 14rpx;
  background: #ffffff;
}

.plugin-row:active {
  background: #f8faff;
}

.plugin-icon {
  display: flex;
  width: 92rpx;
  height: 92rpx;
  flex: 0 0 92rpx;
  align-items: center;
  justify-content: center;
  border-radius: 14rpx;
  background: #4169e1;
}

.image-mark {
  position: relative;
  box-sizing: border-box;
  width: 46rpx;
  height: 38rpx;
  overflow: hidden;
  border: 4rpx solid #ffffff;
  border-radius: 3rpx;
}

.image-sun {
  position: absolute;
  top: 6rpx;
  right: 7rpx;
  width: 7rpx;
  height: 7rpx;
  border-radius: 50%;
  background: #ffffff;
}

.image-mountain {
  position: absolute;
  bottom: -9rpx;
  width: 24rpx;
  height: 24rpx;
  background: #ffffff;
  transform: rotate(45deg);
}

.image-mountain-left {
  left: 4rpx;
}

.image-mountain-right {
  right: 2rpx;
  width: 19rpx;
  height: 19rpx;
}

.plugin-copy {
  display: flex;
  min-width: 0;
  margin-left: 24rpx;
  flex: 1;
  flex-direction: column;
}

.plugin-name {
  color: #152033;
  font-size: 31rpx;
  font-weight: 700;
}

.plugin-summary {
  margin-top: 7rpx;
  color: #778299;
  font-size: 25rpx;
  line-height: 1.35;
}

.chevron {
  width: 16rpx;
  height: 16rpx;
  margin: 0 9rpx 0 20rpx;
  border-right: 4rpx solid #a6b0c1;
  border-bottom: 4rpx solid #a6b0c1;
  transform: rotate(-45deg);
}
</style>
