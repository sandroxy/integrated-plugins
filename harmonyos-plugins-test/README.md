# HarmonyOS Plugins Test

Shared HarmonyOS consumer used to validate packaged plugin HAR files. The app must not compile plugin source directly.

## Build

From the repository root, package Levixel and verify the exact release HAR in this host:

```sh
./plugins/levixel/scripts/verify-native-harmonyos.sh
```

The command copies `levixel-<version>.har` into the ignored `.artifacts/` directory, installs that packaged dependency with `ohpm`, and builds the host HAP. Open this directory in DevEco Studio afterward to run the same artifact on an emulator or signed device.
