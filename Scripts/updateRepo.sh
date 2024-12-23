#!/bin/bash

# GitHub username
GITHUB_USER="Dimserene"
GITHUB_TOKEN=""

# Load GitHub token from environment variable or prompt user securely
if [ -z "$GITHUB_TOKEN" ]; then
  echo -n 'Enter your GitHub token: '
  read -s GITHUB_TOKEN
  echo  # Move to the next line after entering the token
fi

# Get all forked repositories you own
REPOS=$(curl -s -u "$GITHUB_USER:$GITHUB_TOKEN" \
  "https://api.github.com/user/repos?per_page=100" | jq -r '.[] | select(.fork == true) | .full_name')

# Check if repos are retrieved
if [ -z "$REPOS" ]; then
  echo "No forked repositories found or failed to retrieve repositories. Please check your GitHub token and try again."
  exit 1
fi

# Initialize summary counters
TOTAL_REPOS=0
CHECKED_REPOS=0
UPDATED_REPOS=0
ERROR_COUNT=0

# Initialize a summary
SUMMARY_FILE=$(mktemp)
ERRORS_FILE=$(mktemp)

# Export variables needed for update_repo.sh
export GITHUB_USER GITHUB_TOKEN SUMMARY_FILE ERRORS_FILE

# Update the repo counting logic
TOTAL_REPOS=$(echo "$REPOS" | wc -l)

# Run the update_repo.sh script in parallel for each repository using bash explicitly
echo "$REPOS" | parallel --jobs 4 bash update_repo.sh {} "$GITHUB_USER" "$GITHUB_TOKEN" "$SUMMARY_FILE" "$ERRORS_FILE"

# Read the summary and error log into variables
SUMMARY=$(cat "$SUMMARY_FILE")
ERRORS=$(cat "$ERRORS_FILE")

# Update counters based on the summary file
CHECKED_REPOS=$(grep -c "Checked" "$SUMMARY_FILE")
UPDATED_REPOS=$(grep -c "Updated" "$SUMMARY_FILE")
ERROR_COUNT=$(grep -c "Error" "$ERRORS_FILE")

# Display summary and error counts
printf "\nSummary of Updates:\n"
printf "%s\n" "$SUMMARY"
printf "\nTotal Repositories: %d\n" "$TOTAL_REPOS"
printf "Checked Repositories: %d\n" "$CHECKED_REPOS"
printf "Updated Repositories: %d\n" "$UPDATED_REPOS"
printf "Errors Encountered: %d\n" "$ERROR_COUNT"

# Display errors if any
if [ -n "$ERRORS" ]; then
    printf "\nErrors encountered:\n"
    printf "%s\n" "$ERRORS"
fi

# Cleanup temporary files
rm "$SUMMARY_FILE" "$ERRORS_FILE"

# Prompt user to press any key to exit
echo "Press any key to exit..."
# Use a read command that works in both bash and other shells
read -r dummy