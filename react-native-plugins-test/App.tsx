import * as React from 'react';
import { StatusBar, StyleSheet, Text, View } from 'react-native';

export default function App() {
  return (
    <View style={styles.root}>
      <StatusBar translucent backgroundColor="transparent" barStyle="dark-content" />
      <Text style={styles.title}>Integrated Plugins</Text>
      <Text style={styles.status}>No packaged plugins installed</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  root: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    paddingHorizontal: 24,
    backgroundColor: '#F7F8FA',
  },
  title: {
    color: '#111827',
    fontSize: 28,
    fontWeight: '600',
    textAlign: 'center',
  },
  status: {
    marginTop: 10,
    color: '#4B5563',
    fontSize: 15,
    textAlign: 'center',
  },
});
