# Integrated Plugins

本仓库用于维护可上线的原生能力，以及这些能力按需提供的跨平台适配和独立发布产物。

一级归属按插件划分。Android、iOS、HarmonyOS、React Native、UniApp 以及未来新增的目标，只在某个插件确实支持并持续维护时才出现在该插件内部。

## 核心模型

- **插件**：能力与代码所有权边界。
- **交付目标**：某个平台原生实现或某个框架适配器。
- **发布产物**：面向具体生态的独立交付内容，例如原生库、框架包或插件市场包。

插件只正向声明已经支持的交付目标。不枚举不支持的平台，不创建空平台目录，也不预留没有真实需求的适配器。

源码保持模块化和唯一归属；发布时可以按照目标生态的要求，将这些规范源码组装为自包含产物。发布产物之间互不夹带无关平台内容。

## 仓库结构

```text
integrated-plugins/
├── android-plugins-test/       # Android 原生产物共享测试工程
├── ios-plugins-test/           # iOS 原生产物共享测试工程
├── harmonyos-plugins-test/     # HarmonyOS 原生产物共享测试工程
├── react-native-plugins-test/  # React Native npm 产物共享测试工程
├── uniapp-plugins-test/        # UniApp 原生插件产物共享测试工程
├── web-plugins-test/           # 浏览器 npm 产物共享测试工程
├── plugins/                    # 插件唯一事实来源
└── standards/                  # 仓库级硬标准和机器规则
```

六个共享测试工程和 `plugins/` 是相互独立的产品工作区。`standards/` 只保存对整个仓库生效的治理规则，不属于产品工程。

单个插件按需采用以下结构：

```text
plugins/<plugin-id>/
├── plugin.yaml
├── README.md              # 确有人工接入说明时提供
├── contract/
├── native/<platform>/
├── adapters/<runtime>/
├── web/
├── packaging/<target>/
├── scripts/
├── tests/
└── dist/
```

这是一种可选结构，不是目录清单。不存在的目标就不创建对应目录。`dist/` 只保存生成产物并由 Git 忽略。

插件的机器事实统一写入 `plugin.yaml`。只有无法由清单、Schema 或代码契约准确表达的稳定接入说明，才新增插件 Markdown 文档。

共享测试工程只消费插件公开接口和已生成的最终产物，提供中性的能力验证与原始诊断结果，不承载插件实现或正式业务逻辑。Android 使用 AAR、iOS 使用 XCFramework、HarmonyOS 使用 HAR、React Native 与 Web 使用 npm tarball、UniApp 使用待发布的原生插件包。测试通过后发布同一份产物，禁止验收后重新构建再发布。

真实业务仓库不是插件的开发宿主。插件在共享测试工程完成验证并发布后，真实项目只安装已发布版本进行接入冒烟；真实项目发现的问题必须先在对应共享测试工程复现，再回到插件源码修复。

本仓库自研插件的反向域名标识使用 `com.sandrox.<plugin>`。例如 Levixel 使用 `com.sandrox.levixel`。共享测试应用使用 `com.sandrox.integratedplugins.<host>`，避免与插件和其他测试应用冲突。

## 规则来源

- [工程硬标准](standards/ENGINEERING_STANDARD.md)：面向人员的稳定原则和操作边界。
- [机器策略](standards/project-policy.yaml)：机器可读的强约束。
- [插件清单 Schema](standards/plugin-manifest.schema.yaml)：每个 `plugin.yaml` 必须满足的严格结构。
- [插件清单示例](standards/plugin-manifest.example.yaml)：正向、按需声明交付目标的参考。

可机器判断的要求以 YAML 和 Schema 为准。Markdown 只保留通用、长期稳定且需要解释语义的内容。修改规则时，相关 Markdown、YAML 和 Schema 必须在同一次变更中保持一致。
