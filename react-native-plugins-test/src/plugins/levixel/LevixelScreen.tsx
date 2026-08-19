import { Levixel, type LevixelMediaItem } from '@sandrox/levixel';
import { Image as ExpoImage } from 'expo-image';
import * as React from 'react';
import { useState } from 'react';
import {
  FlatList,
  Image as ReactNativeImage,
  Pressable,
  StyleSheet,
  Text,
  View,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';

import { palette } from '../../theme';
import { sampleMedia } from './sampleMedia';

type ImageRenderer = 'expo-image' | 'react-native-image';

export function LevixelScreen() {
  const [renderer, setRenderer] = useState<ImageRenderer>('expo-image');

  return (
    <SafeAreaView edges={['bottom']} style={styles.screen}>
      <View style={styles.rendererControl}>
        <RendererOption
          active={renderer === 'expo-image'}
          label="Expo Image"
          onPress={() => setRenderer('expo-image')}
        />
        <RendererOption
          active={renderer === 'react-native-image'}
          label="RN Image"
          onPress={() => setRenderer('react-native-image')}
        />
      </View>

      <Levixel items={sampleMedia} theme="dark">
        <FlatList
          key={renderer}
          columnWrapperStyle={styles.galleryRow}
          contentContainerStyle={styles.galleryContent}
          data={sampleMedia}
          initialNumToRender={8}
          keyExtractor={(item) => item.id}
          numColumns={2}
          renderItem={({ item, index }) => (
            <MediaTile item={item} index={index} renderer={renderer} />
          )}
          showsVerticalScrollIndicator={false}
          windowSize={7}
        />
      </Levixel>
    </SafeAreaView>
  );
}

function RendererOption({
  active,
  label,
  onPress,
}: {
  active: boolean;
  label: string;
  onPress: () => void;
}) {
  return (
    <Pressable
      accessibilityRole="button"
      onPress={onPress}
      style={[styles.rendererOption, active && styles.rendererOptionActive]}
    >
      <Text style={[styles.rendererText, active && styles.rendererTextActive]}>
        {label}
      </Text>
    </Pressable>
  );
}

function MediaTile({
  item,
  index,
  renderer,
}: {
  item: LevixelMediaItem;
  index: number;
  renderer: ImageRenderer;
}) {
  const previewUrl =
    item.type === 'video'
      ? item.posterUrl ?? item.thumbnailUrl ?? item.url
      : item.thumbnailUrl ?? item.url;

  return (
    <View style={styles.tile}>
      <Levixel.Source index={index} style={StyleSheet.absoluteFill}>
        {renderer === 'expo-image' ? (
          <ExpoImage
            cachePolicy="memory-disk"
            contentFit="cover"
            source={previewUrl}
            style={styles.image}
            transition={0}
          />
        ) : (
          <ReactNativeImage
            resizeMode="cover"
            source={{ uri: previewUrl }}
            style={styles.image}
          />
        )}
      </Levixel.Source>
      {item.type === 'video' ? (
        <View pointerEvents="none" style={styles.videoBadge}>
          <Text style={styles.videoBadgeText}>▶ VIDEO</Text>
        </View>
      ) : null}
      <View pointerEvents="none" style={styles.itemLabel}>
        <Text numberOfLines={1} style={styles.itemLabelText}>
          {item.alt ?? item.id}
        </Text>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    backgroundColor: palette.background,
  },
  rendererControl: {
    marginHorizontal: 12,
    marginTop: 12,
    padding: 3,
    flexDirection: 'row',
    borderRadius: 8,
    backgroundColor: palette.border,
  },
  rendererOption: {
    flex: 1,
    height: 34,
    alignItems: 'center',
    justifyContent: 'center',
    borderRadius: 6,
  },
  rendererOptionActive: {
    backgroundColor: palette.white,
  },
  rendererText: {
    color: '#697386',
    fontSize: 13,
    fontWeight: '600',
  },
  rendererTextActive: {
    color: palette.text,
  },
  galleryContent: {
    padding: 12,
    paddingBottom: 32,
  },
  galleryRow: {
    gap: 10,
    marginBottom: 10,
  },
  tile: {
    flex: 1,
    height: 148,
    overflow: 'hidden',
    borderRadius: 8,
    backgroundColor: '#DDE2EA',
  },
  image: {
    width: '100%',
    height: '100%',
    borderRadius: 8,
  },
  videoBadge: {
    position: 'absolute',
    top: 8,
    left: 8,
    paddingHorizontal: 7,
    paddingVertical: 4,
    borderRadius: 5,
    backgroundColor: 'rgba(0, 0, 0, 0.64)',
  },
  videoBadgeText: {
    color: palette.white,
    fontSize: 10,
    fontWeight: '700',
  },
  itemLabel: {
    position: 'absolute',
    left: 8,
    right: 8,
    bottom: 8,
    alignItems: 'flex-start',
  },
  itemLabelText: {
    maxWidth: '100%',
    paddingHorizontal: 7,
    paddingVertical: 4,
    borderRadius: 5,
    overflow: 'hidden',
    color: palette.white,
    backgroundColor: 'rgba(0, 0, 0, 0.58)',
    fontSize: 11,
    fontWeight: '600',
  },
});
