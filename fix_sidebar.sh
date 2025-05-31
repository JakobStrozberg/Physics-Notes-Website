#!/bin/bash

# This script fixes the remaining navigation issues in all HTML files

# List of all HTML files except index.html
HTML_FILES=$(find . -name "*.html" -not -name "index.html" -not -name "404.html")

for file in $HTML_FILES; do
  echo "Fixing navigation in $file..."
  
  # Remove empty nav-item elements
  sed -i '' '/<li class="nav-item">\s*<\/li>/d' "$file"
  
  # Fix footer height to 20%
  sed -i '' 's/footer style="height: 10%"/footer style="height: 20%"/' "$file"
  
  # Remove empty list items in breadcrumb
  sed -i '' '/<li class="nav-item">\s*<\/li>/d' "$file"
  
  echo "Done fixing $file"
done

echo "Navigation fixes complete!" 