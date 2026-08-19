package com.sandrox.integratedplugins.androidtest;

import com.sandrox.levixel.LevixelMediaItem;

import java.util.ArrayList;
import java.util.List;

public final class SampleMedia {
    private SampleMedia() {
    }

    public static List<LevixelMediaItem> create() {
        List<LevixelMediaItem> list = new ArrayList<>();
        list.add(new LevixelMediaItem(
                "1",
                LevixelMediaItem.MediaType.IMAGE,
                "https://picsum.photos/id/1025/1600/2400",
                "https://picsum.photos/id/1025/400/600"
        ));
        list.add(new LevixelMediaItem(
                "2",
                LevixelMediaItem.MediaType.VIDEO,
                "https://storage.googleapis.com/exoplayer-test-media-0/BigBuckBunny_320x180.mp4",
                "https://picsum.photos/id/1024/800/450"
        ));
        list.add(new LevixelMediaItem(
                "3",
                LevixelMediaItem.MediaType.IMAGE,
                "https://picsum.photos/id/1035/1600/2400",
                "https://picsum.photos/id/1035/400/600"
        ));
        list.add(new LevixelMediaItem(
                "4",
                LevixelMediaItem.MediaType.IMAGE,
                "https://picsum.photos/id/1050/2400/1600",
                "https://picsum.photos/id/1050/600/400"
        ));
        list.add(new LevixelMediaItem(
                "5",
                LevixelMediaItem.MediaType.VIDEO,
                "https://media.w3.org/2010/05/bunny/trailer.mp4",
                "https://picsum.photos/id/1044/800/450"
        ));
        list.add(new LevixelMediaItem(
                "6",
                LevixelMediaItem.MediaType.IMAGE,
                "https://picsum.photos/id/1015/1600/2400",
                "https://picsum.photos/id/1015/400/600"
        ));
        list.add(new LevixelMediaItem(
                "7",
                LevixelMediaItem.MediaType.IMAGE,
                "https://picsum.photos/id/1018/2400/1600",
                "https://picsum.photos/id/1018/600/400"
        ));
        list.add(new LevixelMediaItem(
                "8",
                LevixelMediaItem.MediaType.IMAGE,
                "https://picsum.photos/id/1003/1600/2400",
                "https://picsum.photos/id/1003/400/600"
        ));
        list.add(new LevixelMediaItem(
                "9",
                LevixelMediaItem.MediaType.IMAGE,
                "https://picsum.photos/id/1011/2400/1600",
                "https://picsum.photos/id/1011/600/400"
        ));
        list.add(new LevixelMediaItem(
                "10",
                LevixelMediaItem.MediaType.IMAGE,
                "https://picsum.photos/id/1027/1600/2400",
                "https://picsum.photos/id/1027/400/600"
        ));
        list.add(new LevixelMediaItem(
                "11",
                LevixelMediaItem.MediaType.IMAGE,
                "https://picsum.photos/id/1002/2400/1600",
                "https://picsum.photos/id/1002/600/400"
        ));
        list.add(new LevixelMediaItem(
                "12",
                LevixelMediaItem.MediaType.VIDEO,
                "https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4",
                "https://picsum.photos/id/1069/800/450"
        ));
        list.add(new LevixelMediaItem(
                "13",
                LevixelMediaItem.MediaType.IMAGE,
                "https://picsum.photos/id/1043/1600/2400",
                "https://picsum.photos/id/1043/400/600"
        ));
        list.add(new LevixelMediaItem(
                "14",
                LevixelMediaItem.MediaType.IMAGE,
                "https://picsum.photos/id/1049/2400/1600",
                "https://picsum.photos/id/1049/600/400"
        ));
        list.add(new LevixelMediaItem(
                "15",
                LevixelMediaItem.MediaType.VIDEO,
                "https://media.w3.org/2010/05/sintel/trailer.mp4",
                "https://picsum.photos/id/1070/800/450"
        ));
        list.add(new LevixelMediaItem(
                "16",
                LevixelMediaItem.MediaType.IMAGE,
                "https://picsum.photos/id/1060/1600/2400",
                "https://picsum.photos/id/1060/400/600"
        ));
        list.add(new LevixelMediaItem(
                "17",
                LevixelMediaItem.MediaType.IMAGE,
                "https://picsum.photos/id/1074/2400/1600",
                "https://picsum.photos/id/1074/600/400"
        ));
        list.add(new LevixelMediaItem(
                "18",
                LevixelMediaItem.MediaType.IMAGE,
                "https://picsum.photos/id/1084/1600/2400",
                "https://picsum.photos/id/1084/400/600"
        ));
        return list;
    }
}
