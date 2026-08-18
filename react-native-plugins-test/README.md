# React Native Plugins Test

Shared Expo/React Native consumer used to validate packaged npm tarballs on Android and iOS. The app must not resolve plugin code from a workspace source directory.

## Install And Validate

```sh
corepack pnpm@9.12.3 install
corepack pnpm@9.12.3 typecheck
corepack pnpm@9.12.3 prebuild
```

Run a native target with `corepack pnpm@9.12.3 android` or `corepack pnpm@9.12.3 ios`.

Generated `android/` and `ios/` directories are disposable CNG output. Plugin-specific screens are added only after installing the final npm tarball.
