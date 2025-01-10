#!/bin/bash

# Repositories to check
repos=("Dimserene/Dimserenes-Modpack" "Dimserene/Fine-tuned-Pack" "Dimserene/Vanilla-Plus-Pack" "Dimserene/Cruel-Pack" "Dimserene/Experimental-Pack" "Dimserene/BetterCalc-Pack")

# Function to fetch the latest commit message from a GitHub repository
get_latest_commit_message() {
  repo=$1
  response=$(curl -s "https://api.github.com/repos/$repo/commits")

  # Check if curl request was successful
  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to fetch data for $repo"
    return
  fi

  # Check if the response is an array
  if ! echo "$response" | jq -e 'type == "array"' > /dev/null; then
    echo "Error: Expected an array but got something else for $repo"
    echo "Response: $response"
    return
  fi

  # Extract the latest commit message, committer, and date
  latest_commit=$(echo "$response" | jq -r '.[0].commit.message')
  committer=$(echo "$response" | jq -r '.[0].commit.committer.name')
  commit_date=$(echo "$response" | jq -r '.[0].commit.committer.date')

  # Convert UTC date to Taiwanese time format (YYYY/MM/DD HH:MM:SS)
  commit_date_taiwan=$(TZ=Asia/Taipei date -d "$commit_date" +"%Y/%m/%d %H:%M:%S")

  if [[ -z "$latest_commit" ]]; then
    echo "$repo: No commits found or failed to parse commit data."
  else
    echo "$repo:"
    echo "Message: $latest_commit"
    echo "Committed by: $committer"
    echo "Date: $commit_date_taiwan"
    echo -e "\n"
  fi
}

# Process each repository sequentially to ensure correct output order
for repo in "${repos[@]}"; do
  get_latest_commit_message "$repo"
done

# Pause and wait for the user to press Enter before exiting
read -p "Press Enter to continue..."