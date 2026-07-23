# AGENTS.md

## 沟通语言

- 优先使用简体中文，其次使用美式英语。
- `Factorio`、`Lua`、`API`、`prototype`、`runtime`、`data stage` 等技术词汇保持原文。

## 仓库定位

这是一个用于开发和维护多个 Factorio mod 的工作区。每个 mod 都是独立项目，修改时不要假设它们共享代码、版本或依赖。

## 目录约定

- `src/`：实际维护的 mod 源码。每个一级子目录对应一个独立 mod。
- `dist/`：打包后的发布产物，例如 `<mod-name>_<version>.zip`。不要直接编辑其中内容。
- `reference/`：仅供阅读和对照的其他 mod、文档或资料。除非任务明确要求，不要修改或打包这里的内容。
- `scripts/`：仓库级构建、校验和打包脚本。
- `temp/`：构建过程中的临时文件，可随时重建，不应提交。

## Factorio mod 约定

- 以每个 mod 的 `info.json` 为名称、版本、Factorio 版本和依赖关系的唯一来源。
- 保持 Factorio 的加载阶段边界：`settings.lua`、`data.lua`、`data-updates.lua`、`data-final-fixes.lua`、`control.lua`。
- 修改 prototype 前先确认目标 prototype 和字段存在；兼容可选依赖时要显式检查对应 mod 或数据。
- locale 文本放在 mod 自己的 `locale/<language>/` 下，并保持 locale key 与代码引用一致。
- 新增图像等资源时使用 mod 内相对路径，并确认 `__mod-name__/...` 中的名称与 `info.json.name` 一致。
- 不要把 `reference/` 中的代码直接复制进 `src/`，除非已核对其 license 和兼容版本。

## 修改原则

- 将改动限制在目标 mod 内；不要顺带调整其他 mod。
- 保持现有 Lua 风格，避免无关格式化。
- 更新用户可见行为时，同步检查 locale、`changelog.txt` 和 `info.json` version 是否需要更新。
- 不要手工修改 `dist/`；发布包必须从 `src/` 重新生成。

## 验证

- 确认修改后的 `info.json` 是合法 JSON，且必需字段完整。
- 检查 Lua 文件的语法以及 prototype、recipe、technology、item 等引用。
- 若仓库提供构建或校验脚本，优先使用 `scripts/` 中的脚本。
- 涉及游戏行为的改动应在 `info.json.factorio_version` 对应的 Factorio 版本中加载测试，并检查日志中的 error 和 warning。
- 打包时，zip 顶层目录应为 `<info.json.name>_<info.json.version>`，产物写入 `dist/`。

