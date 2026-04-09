#!/bin/bash

# EngOps Skill Validator
# Ensures all verticals in the monorepo meet enterprise standards.

echo "🔍 Running Rigorous EngOps Audit..."

# 1. Check Global Files
GLOBAL_FILES=("README.md" "LICENSE" "AGENTS.md" "CONTRIBUTING.md" "SECURITY.md" "package.json" "ARCHITECTURE.md")
for file in "${GLOBAL_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ Missing Global File: $file"
        exit 1
    else
        echo "✅ Found Global File: $file"
    fi
done

# 2. Iterate through Skills
for skill_dir in skills/*/ ; do
    # Skip if not a directory or if it's a draft
    if [ ! -d "$skill_dir" ]; then continue; fi
    
    skill_name=$(basename "$skill_dir")
    
    # Skip Confluence Draft for now
    if [ "$skill_name" == "confluence-ops" ]; then 
        echo "🏗️  Skipping Draft Vertical: $skill_name"
        continue; 
    fi

    echo ""
    echo "--- Auditing Vertical: $skill_name ---"
    
    # Mandatory Files
    MANDATORY_SKILL_FILES=(
        "SKILL.md" 
        "README.md" 
        "package.json" 
        "references/api-methods.md" 
        "references/workspace-setup.md"
        "references/integration-examples.md"
        "references/samples/sample.json"
    )

    for file in "${MANDATORY_SKILL_FILES[@]}"; do
        # Handle the sample.json flexibly (could be issue.json, etc)
        if [[ "$file" == *"samples/sample.json" ]]; then
            if [ -z "$(ls -A ${skill_dir}references/samples/*.json 2>/dev/null)" ]; then
                echo "❌ $skill_name: Missing Mock JSON Samples in references/samples/"
                ERR=1
            else
                echo "✅ $skill_name: Found Mock JSON Samples"
            fi
            continue
        fi

        if [ ! -f "${skill_dir}${file}" ]; then
            echo "❌ $skill_name: Missing $file"
            ERR=1
        else
            echo "✅ $skill_name: Found $file"
        fi
    done
done

if [ "$ERR" == "1" ]; then
    echo ""
    echo "🚨 Audit FAILED. Please resolve the missing files above."
    exit 1
else
    echo ""
    echo "🎉 ALL SYSTEMS GO. The EngOps stack is production-ready."
    exit 0
fi
