# Android Plugins Test

Shared Android consumer used to validate packaged plugin AAR files. The app must not depend on plugin source projects.

## Build

Install and verify the current Levixel AAR from the repository root:

```sh
./plugins/levixel/scripts/verify-native-android.sh
```

The verification script copies the packaged AAR into the ignored `.artifacts/` directory before building this app. The app never references the plugin source tree.

Plugin-specific test screens are added only when their final AAR artifacts are available.
