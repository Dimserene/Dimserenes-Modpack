#!/bin/bash

# Repositories to check
repos=("Dimserene/Dimserenes-Modpack" "Dimserene/Fine-tuned-Pack" "Dimserene/Vanilla-Plus-Pack" "Dimserene/Cruel-Pack" "Dimserene/Experimental-Pack")

# Function to fetch the latest commit message from a GitHub repository branch
get_latest_commit_message() {
  local repo=$1
  local branch=$2

  api_url="https://api.github.com/repos/$repo/commits?sha=$branch"
  response=$(curl -s "$api_url")

  # Check if curl request was successful
  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to fetch commit data for $repo ($branch)"
    return
  fi

  # Check if the response is a valid JSON array
  if ! echo "$response" | jq -e 'type == "array"' > /dev/null; then
    echo "Error: Unexpected response format for $repo ($branch)"
    echo "Response: $response"
    return
  fi

  # Extract the latest commit message, committer, and date
  latest_commit=$(echo "$response" | jq -r '.[0].commit.message')
  committer=$(echo "$response" | jq -r '.[0].commit.committer.name')
  commit_date=$(echo "$response" | jq -r '.[0].commit.committer.date')

  # Convert UTC date to Taiwanese time format (YYYY/MM/DD HH:MM:SS)
  commit_date_taiwan=$(TZ=Asia/Taipei date -d "$commit_date" +"%Y/%m/%d %H:%M:%S" 2>/dev/null)

  if [[ -z "$latest_commit" || "$latest_commit" == "null" ]]; then
    echo "$repo ($branch): No commits found or failed to parse commit data."
  else
    echo "$repo ($branch):"
    echo "Message: $latest_commit"
    echo "Committed by: $committer"
    echo "Date: $commit_date_taiwan"
    echo -e "\n"
  fi
}

# Function to fetch all branches of a repository
get_all_branches() {
  local repo=$1
  branch_url="https://api.github.com/repos/$repo/branches"

  branches=$(curl -s "$branch_url" | jq -r '.[].name')

  if [[ -z "$branches" || "$branches" == "null" ]]; then
    echo "Error: Failed to fetch branches for $repo"
    return
  fi

  echo "$branches"
}

# Process each repository
for repo in "${repos[@]}"; do
  
  # Fetch all branches
  branches=$(get_all_branches "$repo")

  if [[ -z "$branches" ]]; then
    echo "Skipping $repo due to missing branch data."
    continue
  fi

  # Loop through each branch and fetch the latest commit
  while read -r branch; do
    get_latest_commit_message "$repo" "$branch"
  done <<< "$branches"
done

# Pause and wait for the user to press Enter before exiting
read -p "Press Enter to continue..."