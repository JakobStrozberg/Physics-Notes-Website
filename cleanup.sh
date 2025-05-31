#!/bin/bash

# Final cleanup script to fix remaining HTML issues

# List of all HTML files except index.html and 404.html
HTML_FILES=$(find . -name "*.html" -not -name "index.html" -not -name "404.html")

for file in $HTML_FILES; do
  echo "Final cleanup for $file..."
  
  # Fix footer height (force it to be 20%)
  sed -i '' 's/footer style="height: 10%"/footer style="height: 20%"/' "$file"
  
  # Fix the table of contents (remove any breadcrumb items that got inserted)
  sed -i '' '/<div class="table-of-contents card mb-4">/,/<\/div>/ s/<li class="breadcrumb-item.*<\/li>//g' "$file"
  
  echo "Done with final cleanup for $file"
done

echo "All cleanup complete!" 