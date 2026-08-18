# UniApp Plugins Test

Shared UniApp Vue 3 consumer used to validate packaged native plugins on Android and iOS. The project must not copy native implementation source from `plugins/` or a business application.

Open this directory in HBuilderX, install the final native-plugin package under `nativeplugins/`, then generate local packaging resources or run with the matching custom base.

The `appid` in `manifest.json` must be registered to the DCloud account used for packaging. Register a dedicated test-host AppID before the first App resource build; do not reuse an AppID owned by a business application.

Generated `unpackage/` output and offline SDK projects are intentionally excluded from Git.
