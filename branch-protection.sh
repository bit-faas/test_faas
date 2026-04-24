#!/bin/bash
set -e

REPO="$1"        # repo name (passed from Jenkins)
ADMIN_USER="$2"  # GitHub admin username
TOKEN="$3"       # GitHub token
ORG="$4"         # GitHub org name

STACK_FILE="stack.yml"

# --- Step 1: Update stack.yml ---
if [ -f "$STACK_FILE" ]; then
    echo "Updating function name in stack.yml..."
    sed -i "s/^[[:space:]]*need_update_w_faas_name:/${REPO}:/g" "$STACK_FILE"
    echo "stack.yml updated successfully."

    # Commit and push changes back to GitHub
    git config --global user.name "Jenkins Automation"
    git config --global user.email "jenkins@${ORG}.local"

    git add "$STACK_FILE"
    git commit -m "Update function name in stack.yml to ${REPO}"
    git push https://${ADMIN_USER}:${TOKEN}@github.com/${ORG}/${REPO}.git HEAD:main

    echo "stack.yml pushed to remote repository."
else
    echo "Warning: stack.yml not found, skipping update."
fi

# --- Step 2: Apply GitHub branch protection ---
echo "Applying branch protection rules for ${ORG}/${REPO}..."

curl -X PUT \
  -H "Authorization: token $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/repos/${ORG}/${REPO}/branches/main/protection \
  -d '{
    "required_status_checks": {
      "strict": true,
      "contexts": ["jenkins-ci"]
    },
    "enforce_admins": true,
    "required_pull_request_reviews": {
      "dismiss_stale_reviews": true,
      "require_last_push_approval": true,
      "required_approving_review_count": 1
    },
    "restrictions": {
      "users": ["'"$ADMIN_USER"'"],
      "teams": []
    },
    "allow_force_pushes": false,
    "allow_deletions": false
  }'

echo "Branch protection applied successfully."
