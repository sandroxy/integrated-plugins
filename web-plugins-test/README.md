# Web Plugins Test

Framework-free browser consumer used to validate packaged npm tarballs on desktop and mobile browsers. The app must not import plugin source from the repository workspace.

## Run

```sh
corepack pnpm@9.12.3 install
corepack pnpm@9.12.3 dev
```

Use `corepack pnpm@9.12.3 build` for the production build check. Plugin-specific test surfaces are added only after installing the final npm tarball.
