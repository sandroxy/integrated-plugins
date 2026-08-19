import { LevixelMediaItem, LevixelMediaType } from '@sandrox/levixel';

export function createLevixelSampleData(): LevixelMediaItem[] {
  return [
    {
      id: '1',
      mediaType: LevixelMediaType.IMAGE,
      sourceUrl: 'https://picsum.photos/id/1025/1600/2400',
      thumbnailUrl: 'https://picsum.photos/id/1025/400/600',
      title: 'Portrait',
      aspectWidth: 2,
      aspectHeight: 3
    },
    {
      id: '2',
      mediaType: LevixelMediaType.VIDEO,
      sourceUrl: 'https://storage.googleapis.com/exoplayer-test-media-0/BigBuckBunny_320x180.mp4',
      thumbnailUrl: 'https://picsum.photos/id/1024/800/450',
      title: 'Big Buck Bunny',
      aspectWidth: 16,
      aspectHeight: 9
    },
    {
      id: '3',
      mediaType: LevixelMediaType.IMAGE,
      sourceUrl: 'https://picsum.photos/id/1035/1600/2400',
      thumbnailUrl: 'https://picsum.photos/id/1035/400/600',
      title: 'Mountain',
      aspectWidth: 2,
      aspectHeight: 3
    },
    {
      id: '4',
      mediaType: LevixelMediaType.IMAGE,
      sourceUrl: 'https://picsum.photos/id/1050/2400/1600',
      thumbnailUrl: 'https://picsum.photos/id/1050/600/400',
      title: 'Wide Scene',
      aspectWidth: 3,
      aspectHeight: 2
    },
    {
      id: '5',
      mediaType: LevixelMediaType.VIDEO,
      sourceUrl: 'https://storage.googleapis.com/exoplayer-test-media-0/shortform_1.mp4',
      thumbnailUrl: 'https://picsum.photos/id/1044/800/450',
      title: 'Short Form',
      aspectWidth: 16,
      aspectHeight: 9
    },
    {
      id: '6',
      mediaType: LevixelMediaType.IMAGE,
      sourceUrl: 'https://picsum.photos/id/1015/1600/2400',
      thumbnailUrl: 'https://picsum.photos/id/1015/400/600',
      title: 'River',
      aspectWidth: 2,
      aspectHeight: 3
    }
  ];
}
