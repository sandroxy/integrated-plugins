# Android Plugins Test

Shared Android consumer used to validate packaged plugin AAR files. The app must not depend on plugin source projects.

## Build

```sh
./gradlew :app:assembleDebug
```

Plugin-specific test screens are added only when their final AAR artifacts are available.
