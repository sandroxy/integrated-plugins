# iOS Plugins Test

Shared iOS consumer used to validate packaged plugin XCFramework files. The app must not compile plugin source directly.

## Build

```sh
xcodebuild \
  -project IosPluginsTest.xcodeproj \
  -scheme IosPluginsTest \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

Plugin-specific test screens are added only when their final XCFramework artifacts are available.
