#!/bin/bash

REPO="$1"
GITHUB_USER="$2"
GITHUB_TOKEN="$3"
SUMMARY_FILE="$4"
ERRORS_FILE="$5"

REPO_NAME=$(basename "$REPO")

# Skip specific repository
if [ "$REPO_NAME" = "bot-automation" ]; then
    echo "Skipping $REPO_NAME..."
    exit 0
fi

echo ""
echo "Checking $REPO..."

# Clone the repository if not already cloned
if [ ! -d "$REPO_NAME" ]; then
    git clone "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$REPO.git" || {
        echo "Error: Failed to clone $REPO_NAME" >> "$ERRORS_FILE"
        exit 1
    }
fi

cd "$REPO_NAME" || exit 1

# Get the default branch
DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@') || {
    echo "Error: Failed to determine default branch for $REPO_NAME" >> "$ERRORS_FILE"
    exit 1
}

# Ensure we are on the default branch
git checkout "$DEFAULT_BRANCH" || {
    echo "Error: Failed to checkout branch $DEFAULT_BRANCH in $REPO_NAME" >> "$ERRORS_FILE"
    exit 1
}

# Ensure a clean working directory
if [ -n "$(git status --porcelain)" ]; then
    echo "Error: Uncommitted changes in $REPO_NAME" >> "$ERRORS_FILE"
    exit 1
fi

# Pull the latest changes from origin
git config pull.rebase false
git pull origin "$DEFAULT_BRANCH" || {
    echo "Error: Failed to pull from origin for $REPO_NAME" >> "$ERRORS_FILE"
    exit 1
}

# Check if upstream is set, and if not, add it
UPSTREAM_URL=$(git remote get-url upstream 2>/dev/null)
if [ -z "$UPSTREAM_URL" ]; then
    UPSTREAM_URL=$(curl -s -u "$GITHUB_USER:$GITHUB_TOKEN" \
      "https://api.github.com/repos/$REPO" | jq -r '.parent.clone_url') || {
        echo "Error: Failed to get upstream URL for $REPO_NAME" >> "$ERRORS_FILE"
        exit 1
    }
    git remote add upstream "$UPSTREAM_URL" || {
        echo "Error: Failed to add upstream remote for $REPO_NAME" >> "$ERRORS_FILE"
        exit 1
    }
fi

# Fetch and merge changes from upstream
git fetch upstream || {
    echo "Error: Failed to fetch upstream for $REPO_NAME" >> "$ERRORS_FILE"
    exit 1
}

# Check if the fork is behind upstream
BEHIND_COMMITS=$(git rev-list --right-only --count "origin/$DEFAULT_BRANCH...upstream/$DEFAULT_BRANCH") || {
    echo "Error: Failed to determine commit differences for $REPO_NAME" >> "$ERRORS_FILE"
    exit 1
}

# Update the repo only if it's behind
if [ "$BEHIND_COMMITS" -gt 0 ]; then
    echo "$REPO is behind by $BEHIND_COMMITS commits. Updating..."
    git merge "upstream/$DEFAULT_BRANCH" -m "Merge upstream changes into $DEFAULT_BRANCH" || {
        echo "Error: Merge conflict or failure in $REPO_NAME" >> "$ERRORS_FILE"
        exit 1
    }
    git push "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$REPO.git" "$DEFAULT_BRANCH" || {
        echo "Error: Failed to push updates to origin for $REPO_NAME" >> "$ERRORS_FILE"
        exit 1
    }
    echo "Updated $REPO_NAME by $BEHIND_COMMITS commits" >> "$SUMMARY_FILE"
else
    echo "$REPO is up-to-date."
fi

# Go back to parent directory
cd ..