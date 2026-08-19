import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { ChevronRight, Images } from 'lucide-react-native';
import * as React from 'react';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';

import type { RootStackParamList } from '../navigation/routes';
import { palette } from '../theme';

type Props = NativeStackScreenProps<RootStackParamList, 'Plugins'>;

export function PluginCatalogScreen({ navigation }: Props) {
  return (
    <SafeAreaView edges={['top', 'bottom']} style={styles.screen}>
      <View style={styles.hero}>
        <Text style={styles.eyebrow}>NATIVE PLUGIN LAB</Text>
        <Text style={styles.title}>React Native Plugins</Text>
        <Text style={styles.description}>
          Packaged npm artifacts, isolated in focused Android and iOS checks.
        </Text>
      </View>

      <View style={styles.body}>
        <Text style={styles.sectionTitle}>Available plugins</Text>
        <Text style={styles.sectionDescription}>
          Open a plugin to verify its public package.
        </Text>
        <Pressable
          accessibilityRole="button"
          onPress={() => navigation.navigate('Levixel')}
          style={({ pressed }) => [styles.pluginRow, pressed && styles.pressed]}
        >
          <View style={styles.pluginIcon}>
            <Images color={palette.white} size={24} strokeWidth={2} />
          </View>
          <View style={styles.pluginCopy}>
            <Text style={styles.pluginTitle}>Levixel</Text>
            <Text style={styles.pluginDescription}>
              Shared-transition image and video viewer
            </Text>
          </View>
          <ChevronRight color={palette.disclosure} size={22} strokeWidth={2} />
        </Pressable>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    backgroundColor: palette.background,
  },
  hero: {
    paddingHorizontal: 24,
    paddingTop: 28,
    paddingBottom: 26,
    backgroundColor: palette.hero,
  },
  eyebrow: {
    color: '#AFC8F4',
    fontSize: 11,
    fontWeight: '700',
  },
  title: {
    marginTop: 14,
    color: palette.white,
    fontSize: 29,
    fontWeight: '700',
  },
  description: {
    marginTop: 8,
    maxWidth: 340,
    color: '#D8E2F2',
    fontSize: 14,
    lineHeight: 20,
  },
  body: {
    flex: 1,
    paddingHorizontal: 20,
    paddingTop: 24,
  },
  sectionTitle: {
    color: palette.text,
    fontSize: 18,
    fontWeight: '700',
  },
  sectionDescription: {
    marginTop: 3,
    color: palette.muted,
    fontSize: 13,
  },
  pluginRow: {
    minHeight: 88,
    marginTop: 20,
    paddingHorizontal: 14,
    flexDirection: 'row',
    alignItems: 'center',
    borderRadius: 8,
    backgroundColor: palette.white,
  },
  pluginIcon: {
    width: 48,
    height: 48,
    alignItems: 'center',
    justifyContent: 'center',
    borderRadius: 8,
    backgroundColor: palette.primary,
  },
  pluginCopy: {
    flex: 1,
    marginLeft: 14,
  },
  pluginTitle: {
    color: palette.text,
    fontSize: 16,
    fontWeight: '700',
  },
  pluginDescription: {
    marginTop: 3,
    color: palette.muted,
    fontSize: 13,
    lineHeight: 17,
  },
  pressed: {
    opacity: 0.72,
  },
});
