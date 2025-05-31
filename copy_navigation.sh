#!/bin/bash

# This script copies the navigation and sidebar from acceleration.html to other HTML files

# Files to update
FILES=(
  "circular-rotational-motion.html"
  "forces-newtons-laws.html"
  "momentum.html"
  "motion-two-dimensions.html"
  "thermal-energy.html"
  "work-energy.html"
)

# For each file, replace all content between <body> and first <section> with content from acceleration.html
for file in "${FILES[@]}"; do
  echo "Updating $file..."
  
  # Check if file exists
  if [ ! -f "$file" ]; then
    echo "  Warning: $file not found, skipping."
    continue
  fi
  
  # Extract the navigation section from acceleration.html
  NAV_SECTION=$(sed -n '/<body>/,/<section/p' acceleration.html | head -n -1)
  
  # Replace the navigation section in the target file
  sed -i '' -e "/<body>/,/<section/c\\
$NAV_SECTION\\
<section" "$file"
  
  echo "  Updated $file successfully."
done

echo "All files have been updated with the sidebar and navigation." 