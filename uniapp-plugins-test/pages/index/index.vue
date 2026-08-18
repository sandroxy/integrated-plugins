<template>
  <view class="page">
    <view class="empty-state">
      <text class="title">Integrated Plugins</text>
      <text class="status">No packaged plugins installed</text>
    </view>
  </view>
</template>

<script>
export default {
  name: 'IndexPage',
}
</script>

<style scoped>
.page {
  box-sizing: border-box;
  min-height: 100vh;
  padding: env(safe-area-inset-top) 48rpx env(safe-area-inset-bottom);
  background: #f7f8fa;
}

.empty-state {
  display: flex;
  min-height: calc(100vh - env(safe-area-inset-top) - env(safe-area-inset-bottom));
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
}

.title {
  color: #111827;
  font-size: 56rpx;
  font-weight: 600;
}

.status {
  margin-top: 20rpx;
  color: #4b5563;
  font-size: 30rpx;
}
</style>
