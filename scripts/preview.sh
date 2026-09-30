#!/usr/bin/env bash
# 从 maps/ 最新导图重新生成离线预览页；不自动打开浏览器。
set -euo pipefail
cd "$(dirname "$0")/.."

map_file="$(ls -1t maps/*.md 2>/dev/null | head -1 || true)"
if [[ -z "${map_file}" ]]; then
  echo "maps/ 下没有 Markdown 导图" >&2
  exit 1
fi

mkdir -p preview
cp "${map_file}" preview/mindmap.md
npx --yes markmap-cli preview/mindmap.md -o preview/index.html --offline --no-open

python3 - <<'PY'
from pathlib import Path
p = Path("preview/index.html")
html = p.read_text(encoding="utf-8")
html = html.replace("<title>Markmap</title>", "<title>Agent 到芯片知识领域</title>", 1)
p.write_text(html, encoding="utf-8")
print(f"updated {p} from maps source")
PY

echo "预览页: preview/index.html（请手动用浏览器打开）"
