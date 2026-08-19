# React Native Plugins Test

Shared Expo/React Native consumer used to validate packaged npm tarballs on Android and iOS. The app must not resolve plugin code from a workspace source directory.

## Install And Validate

Build the exact package consumed by this host, then install it from the generated tarball:

```sh
../plugins/levixel/scripts/package-react-native.sh
corepack pnpm@9.12.3 install
corepack pnpm@9.12.3 typecheck
corepack pnpm@9.12.3 prebuild
```

Run a native target with `corepack pnpm@9.12.3 android` or `corepack pnpm@9.12.3 ios`.

The complete artifact checks are available from the repository root:

```sh
./plugins/levixel/scripts/verify-react-native.sh android
./plugins/levixel/scripts/verify-react-native.sh ios
```

Generated `android/` and `ios/` directories are disposable CNG output. The host resolves Levixel only from the packaged npm tarball, never from adapter source.
