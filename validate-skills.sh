#!/bin/bash

# Validate Outline Wiki Skill format and structure

set -e

SKILL_DIR="skills/outline-wiki"
ERRORS=0

echo "🔍 Validating Outline Wiki Skill..."
echo ""

# Check main SKILL.md exists
if [ ! -f "$SKILL_DIR/SKILL.md" ]; then
  echo "❌ Missing: $SKILL_DIR/SKILL.md"
  ERRORS=$((ERRORS + 1))
else
  echo "✅ Found: $SKILL_DIR/SKILL.md"
  
  # Check file size (should be under 500 lines for main skill)
  LINES=$(wc -l < "$SKILL_DIR/SKILL.md")
  if [ "$LINES" -gt 500 ]; then
    echo "⚠️  Warning: SKILL.md has $LINES lines (recommended <500)"
  else
    echo "✅ SKILL.md size OK ($LINES lines)"
  fi
fi

# Check for frontmatter
if grep -q "^---$" "$SKILL_DIR/SKILL.md"; then
  echo "✅ SKILL.md has frontmatter"
else
  echo "⚠️  Warning: SKILL.md missing YAML frontmatter"
fi

# Check README exists
if [ ! -f "README.md" ]; then
  echo "❌ Missing: README.md"
  ERRORS=$((ERRORS + 1))
else
  echo "✅ Found: README.md"
fi

# Check LICENSE exists
if [ ! -f "LICENSE" ]; then
  echo "❌ Missing: LICENSE"
  ERRORS=$((ERRORS + 1))
else
  echo "✅ Found: LICENSE"
fi

# Check manifest exists
if [ ! -f ".claude-plugin/manifest.json" ]; then
  echo "⚠️  Missing: .claude-plugin/manifest.json (optional but recommended)"
else
  echo "✅ Found: .claude-plugin/manifest.json"
fi

echo ""
if [ $ERRORS -eq 0 ]; then
  echo "✅ All checks passed!"
  exit 0
else
  echo "❌ Found $ERRORS error(s)"
  exit 1
fi
