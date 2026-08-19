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
                "https://picsum.photos/id/1024/400/600"
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
                "https://picsum.photos/id/1050/1600/2400",
                "https://picsum.photos/id/1050/400/600"
        ));
        list.add(new LevixelMediaItem(
                "5",
                LevixelMediaItem.MediaType.VIDEO,
                "https://storage.googleapis.com/exoplayer-test-media-0/shortform_1.mp4",
                "https://picsum.photos/id/1044/400/600"
        ));
        list.add(new LevixelMediaItem(
                "6",
                LevixelMediaItem.MediaType.IMAGE,
                "https://picsum.photos/id/1015/1600/2400",
                "https://picsum.photos/id/1015/400/600"
        ));
        return list;
    }
}
