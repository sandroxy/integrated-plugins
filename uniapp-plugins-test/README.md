# UniApp Plugins Test

Shared UniApp Vue 3 consumer used to validate packaged native plugins on Android and iOS. The project must not copy native implementation source from `plugins/` or a business application.

Generate and stage the exact native-plugin package before opening this directory in HBuilderX:

```sh
DCLOUD_ANDROID_UNIAPP_AAR=/absolute/path/to/uniapp-v8-release.aar \
  ../plugins/levixel/scripts/package-uniapp.sh
../plugins/levixel/scripts/verify-uniapp.sh
```

The verifier installs the exact ZIP contents under the ignored `nativeplugins/` directory. Generate local packaging resources or run with a custom base built from that staged package. The committed test pages import only its `js_sdk`; they do not resolve adapter source from `plugins/`.

The `appid` in `manifest.json` must be registered to the DCloud account used for packaging. Register a dedicated test-host AppID before the first App resource build; do not reuse an AppID owned by a business application.

Generated `unpackage/` output and offline SDK projects are intentionally excluded from Git.
