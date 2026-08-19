# iOS Plugins Test

Shared iOS consumer used to validate packaged plugin XCFramework files. The app must not compile plugin source directly.

## Build

From the repository root, package Levixel and verify the exact release ZIP in this host:

```sh
./plugins/levixel/scripts/verify-native-ios.sh
```

The command extracts `levixel-<version>.xcframework.zip` into the ignored `.artifacts/` directory before building. Open `IosPluginsTest.xcodeproj` afterward to run the same artifact on a signed device.
