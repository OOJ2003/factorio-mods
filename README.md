# Factorio Mods Workspace

用于开发、维护和打包多个 Factorio mod 的工作区。

## 目录

- `src/`：mod 源码，每个一级子目录是一个独立 mod。
- `dist/`：生成的发布包。
- `reference/`：参考 mod 和资料，不参与构建。
- `scripts/`：构建、校验和打包脚本。
- `temp/`：可重新生成的临时文件。

每个 mod 的名称、版本、Factorio 版本和依赖以其 `info.json` 为准。开发和打包细则见 `AGENTS.md`。

## 打包

在仓库根目录运行：

```powershell
.\scripts\package-mods.ps1
```

脚本会读取 `src/` 下每个 mod 的 `info.json`，并将发布包写入 `dist/<name>_<version>.zip`。可用 `-Mod` 仅打包指定的源码目录，或用 `-Clean` 在打包前删除已有 zip：

```powershell
.\scripts\package-mods.ps1 -Mod calcite-casting-fork
.\scripts\package-mods.ps1 -Clean
```
