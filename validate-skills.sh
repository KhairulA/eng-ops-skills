#!/bin/bash

# Validate EngOps Agent Skills structure
# Loops through each vertical in skills/ and checks for compliance

set -e

ERRORS=0
SUCCESSES=0

echo "🔍 Validating EngOps Skills Suite..."
echo ""

# Global checks
FILES_TO_CHECK=("README.md" "LICENSE" "AGENTS.md" "CONTRIBUTING.md")

for file in "${FILES_TO_CHECK[@]}"; do
  if [ ! -f "$file" ]; then
    echo "❌ Missing Global File: $file"
    ERRORS=$((ERRORS + 1))
  else
    echo "✅ Found Global File: $file"
  fi
done

echo ""

# Vertical Skill Checks
for skill_path in skills/*/; do
  [ -e "$skill_path" ] || continue
  skill_name=$(basename "$skill_path")
  
  echo "--- Testing Vertical: $skill_name ---"
  
  # Check main SKILL.md exists
  if [ ! -f "$skill_path/SKILL.md" ]; then
    echo "❌ $skill_name: Missing SKILL.md"
    ERRORS=$((ERRORS + 1))
  else
    echo "✅ $skill_name: Found SKILL.md"
    
    # Check for frontmatter
    if ! grep -q "^---$" "$skill_path/SKILL.md"; then
      echo "⚠️  $skill_name: SKILL.md missing YAML frontmatter"
    fi
  fi

  # Check Skill README exists
  if [ ! -f "$skill_path/README.md" ]; then
    echo "❌ $skill_name: Missing README.md"
    ERRORS=$((ERRORS + 1))
  else
    echo "✅ $skill_name: Found README.md"
  fi
  
  SUCCESSES=$((SUCCESSES + 1))
done

echo ""
if [ $ERRORS -eq 0 ]; then
  echo "✅ Validated $SUCCESSES skill(s) with no critical errors!"
  exit 0
else
  echo "❌ Found $ERRORS error(s) across $SUCCESSES skill(s)"
  exit 1
fi
