import { createNativeStackNavigator } from '@react-navigation/native-stack';
import * as React from 'react';
import { StyleSheet } from 'react-native';

import { LevixelScreen } from '../plugins/levixel/LevixelScreen';
import { PluginCatalogScreen } from '../screens/PluginCatalogScreen';
import { palette } from '../theme';
import type { RootStackParamList } from './routes';

const Stack = createNativeStackNavigator<RootStackParamList>();

export function RootNavigator() {
  return (
    <Stack.Navigator
      screenOptions={{
        contentStyle: styles.screen,
        headerBackButtonDisplayMode: 'minimal',
        headerShadowVisible: false,
        headerStyle: styles.header,
        headerTintColor: palette.text,
        statusBarStyle: 'dark',
      }}
    >
      <Stack.Screen
        component={PluginCatalogScreen}
        name="Plugins"
        options={{ headerShown: false }}
      />
      <Stack.Screen
        component={LevixelScreen}
        name="Levixel"
        options={{ title: 'Levixel' }}
      />
    </Stack.Navigator>
  );
}

const styles = StyleSheet.create({
  screen: {
    backgroundColor: palette.background,
  },
  header: {
    backgroundColor: palette.background,
  },
});
