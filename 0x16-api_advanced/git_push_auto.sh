#!/bin/bash

# 0. Ask the user for an absolute path to the GitHub repository
read -p "Enter the absolute path to the GitHub repository: " repo_path

cd "$repo_path" || { echo "Error: Invalid repository path"; exit 1; }

# 1a. Check the state of the Git repo and perform necessary actions
git status

# 1b. Git pull and merge
echo "Pulling changes from remote repository..."
git pull --no-commit

# Check for merge conflicts
conflicts=$(git diff --name-only --diff-filter=U)

if [ -n "$conflicts" ]; then
  echo "Merge conflicts detected. Please resolve the conflicts in the following files:"
  echo "$conflicts"
  echo "After resolving the conflicts, stage the changes and run 'git commit'."
  exit 1
fi

# 2. Git add and commit
echo "Staging all changes..."
git add .

# Automatically generate commit messages with action items and file names
for file in $(git diff --cached --name-only); do
  filename=$(basename "$file")
  action_item="updated"
  git commit -m "$action_item $filename" -- "$file"

  # Push each file after 15 seconds
  echo "Pushing $file in 15 seconds..."
  sleep 1
  git push
done

echo "All changes have been pushed successfully."
