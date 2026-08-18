# HarmonyOS Plugins Test

Shared HarmonyOS consumer used to validate packaged plugin HAR files. The app must not compile plugin source directly.

## Build

Point `DEVECO_SDK_HOME` at DevEco Studio's SDK root, put its `hvigorw` directory on `PATH`, then run:

```sh
export DEVECO_SDK_HOME="/path/to/DevEco-Studio.app/Contents/sdk"
export PATH="/path/to/DevEco-Studio.app/Contents/tools/hvigor/bin:$PATH"
hvigorw assembleHap --mode module -p product=default
```

Plugin-specific test pages are added only when their final HAR artifacts are available.
