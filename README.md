# Kimi Adversarial Review — Claude Code Skill

Use **Kimi** (Moonshot AI) as an **independent red-team reviewer** to challenge your main model's analysis conclusions, enabling cross-model validation.

## Why

A single model can be blind to its own mistakes. Kimi is a separate model from DeepSeek/Claude, so it reviews your work with fresh eyes — no contamination from the main session's reasoning. When both models agree, the conclusion is solid; when they disagree, the conflict points are exactly where you need to go back to the raw data.

## Prerequisites

- **Kimi Code CLI** (`kimi`) installed and configured with an **open-platform API key**.
  - The API key is **NOT included** in this repo — configure it yourself via `kimi` → `/login` → `Kimi Platform (API key · platform.kimi.com)`.
  - See https://platform.kimi.com for key creation.

## Installation

```bash
# 1. Copy the skill
mkdir -p ~/.claude/skills/
cp -r kimi-adversarial-review ~/.claude/skills/

# 2. Make the wrapper script executable
chmod +x ~/.claude/skills/kimi-adversarial-review/scripts/kimi_review.sh
```

## Usage

### Trigger by phrase (skill auto-loads)

Just say in Claude Code:

```
用 Kimi 对抗性审查 /path/to/report.md
Use Kimi to adversarially review this conclusion
```

### Or run the wrapper script directly

```bash
~/.claude/skills/kimi-adversarial-review/scripts/kimi_review.sh <file_or_dir> [review_focus]
```

Example:

```bash
kimi_review.sh /mnt/data/report.md "statistical methods and multiple testing"
```

## Review focus (built into the prompt)

1. Overclaim — conclusions beyond what the evidence supports
2. Statistical/method errors — design matrix, normalization order, multiple testing, data leakage
3. Hidden assumptions and self-contradiction
4. Reproducibility — missing random seed / software version / parameters

Each finding is reported with severity (high/medium/low) + location evidence + why it's a problem + fix suggestion, plus an overall confidence rating.

## Notes

- Uses the open-platform API (pay-as-you-go, ~¥1 per review).
- Review output is a **second opinion**, not a final verdict — resolve conflicts against the raw data.
