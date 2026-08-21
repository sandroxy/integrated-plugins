export const levixelMedia = [
  { id: 'portrait-dog', type: 'image', url: 'https://picsum.photos/id/1025/1600/2400', thumbnailUrl: 'https://picsum.photos/id/1025/400/600', width: 1600, height: 2400 },
  { id: 'big-buck-bunny', type: 'video', url: 'https://storage.googleapis.com/exoplayer-test-media-0/BigBuckBunny_320x180.mp4', posterUrl: 'https://picsum.photos/id/1024/800/450', width: 16, height: 9 },
  { id: 'mountain-falls', type: 'image', url: 'https://picsum.photos/id/1035/1600/2400', thumbnailUrl: 'https://picsum.photos/id/1035/400/600', width: 1600, height: 2400 },
  { id: 'wide-coast', type: 'image', url: 'https://picsum.photos/id/1050/2400/1600', thumbnailUrl: 'https://picsum.photos/id/1050/600/400', width: 2400, height: 1600 },
  { id: 'bunny-trailer', type: 'video', url: 'https://media.w3.org/2010/05/bunny/trailer.mp4', posterUrl: 'https://picsum.photos/id/1044/800/450', width: 16, height: 9 },
  { id: 'river', type: 'image', url: 'https://picsum.photos/id/1015/1600/2400', thumbnailUrl: 'https://picsum.photos/id/1015/400/600', width: 1600, height: 2400 },
  { id: 'valley', type: 'image', url: 'https://picsum.photos/id/1018/2400/1600', thumbnailUrl: 'https://picsum.photos/id/1018/600/400', width: 2400, height: 1600 },
  { id: 'portrait-rock', type: 'image', url: 'https://picsum.photos/id/1003/1600/2400', thumbnailUrl: 'https://picsum.photos/id/1003/400/600', width: 1600, height: 2400 },
  { id: 'lake', type: 'image', url: 'https://picsum.photos/id/1011/2400/1600', thumbnailUrl: 'https://picsum.photos/id/1011/600/400', width: 2400, height: 1600 },
  { id: 'portrait-woman', type: 'image', url: 'https://picsum.photos/id/1027/1600/2400', thumbnailUrl: 'https://picsum.photos/id/1027/400/600', width: 1600, height: 2400 },
  { id: 'desert', type: 'image', url: 'https://picsum.photos/id/1002/2400/1600', thumbnailUrl: 'https://picsum.photos/id/1002/600/400', width: 2400, height: 1600 },
  { id: 'flower-video', type: 'video', url: 'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4', posterUrl: 'https://picsum.photos/id/1069/800/450', width: 16, height: 9 },
  { id: 'forest', type: 'image', url: 'https://picsum.photos/id/1043/1600/2400', thumbnailUrl: 'https://picsum.photos/id/1043/400/600', width: 1600, height: 2400 },
  { id: 'city', type: 'image', url: 'https://picsum.photos/id/1049/2400/1600', thumbnailUrl: 'https://picsum.photos/id/1049/600/400', width: 2400, height: 1600 },
  { id: 'sintel-trailer', type: 'video', url: 'https://media.w3.org/2010/05/sintel/trailer.mp4', posterUrl: 'https://picsum.photos/id/1070/800/450', width: 16, height: 9 },
  { id: 'portrait-road', type: 'image', url: 'https://picsum.photos/id/1060/1600/2400', thumbnailUrl: 'https://picsum.photos/id/1060/400/600', width: 1600, height: 2400 },
  { id: 'cliffs', type: 'image', url: 'https://picsum.photos/id/1074/2400/1600', thumbnailUrl: 'https://picsum.photos/id/1074/600/400', width: 2400, height: 1600 },
  { id: 'portrait-field', type: 'image', url: 'https://picsum.photos/id/1084/1600/2400', thumbnailUrl: 'https://picsum.photos/id/1084/400/600', width: 1600, height: 2400 },
]

export function levixelPreviewUrl(item) {
  return item.type === 'video'
    ? item.posterUrl || item.thumbnailUrl || item.url
    : item.thumbnailUrl || item.url
}
