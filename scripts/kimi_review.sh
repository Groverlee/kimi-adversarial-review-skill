#!/bin/bash
# Adversarial review via Kimi Code CLI (moonshot-cn / kimi-k3.1-pro).
# Usage:
#   kimi_review.sh <file_or_dir> [review_focus]
#   kimi_review.sh /path/to/report.md "statistical methods"
# Can be called by the main Claude Code session (DeepSeek) for automated red-team review.
set -euo pipefail
export PATH="/home/groverlee/.nvm/versions/node/v22.18.0/bin:/home/groverlee/.local/bin:$PATH"

TARGET="${1:?用法: kimi_review.sh <文件或目录> [审查焦点]}"
FOCUS="${2:-}"

PROMPT="对 $TARGET 做对抗性审查。你是红队，主动找茬，不要附和，不要先说'整体不错'。逐项检查：1) 结论是否 overclaim（超出证据）；2) 统计/方法错误（设计矩阵、归一化顺序、多重检验、data leakage）；3) 隐藏假设与自相矛盾；4) 可复现性（缺 random seed/软件版本/参数）。每条给：严重度(高/中/低) + 位置证据 + 为什么是问题 + 修复建议。最后给整体可信度评级和最关键的一个风险点。"
if [ -n "$FOCUS" ]; then
  PROMPT="$PROMPT 本次审查焦点：$FOCUS。"
fi

kimi -p "$PROMPT" 2>&1
