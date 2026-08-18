module.exports = {
  expo: {
    name: 'Integrated Plugins',
    slug: 'react-native-plugins-test',
    version: '1.0.0',
    orientation: 'portrait',
    scheme: 'sandrox-plugins-test',
    newArchEnabled: true,
    plugins: ['expo-dev-client'],
    ios: {
      supportsTablet: true,
      bundleIdentifier: 'com.sandrox.integratedplugins.reactnativetest',
    },
    android: {
      package: 'com.sandrox.integratedplugins.reactnativetest',
      edgeToEdgeEnabled: true,
    },
  },
};
