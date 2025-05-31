#!/bin/bash

# Script to fix breadcrumb navigation and footer height in all HTML files

# List of all HTML files except index.html and 404.html
HTML_FILES=$(find . -name "*.html" -not -name "index.html" -not -name "404.html")

for file in $HTML_FILES; do
  echo "Fixing breadcrumb in $file..."
  
  # Get the page title from the h1 element
  pagetitle=$(grep -o '<h1 class="section-title">[^<]*</h1>' "$file" | sed 's/<h1 class="section-title">\(.*\)<\/h1>/\1/')
  
  # Create a temporary file for the fixed breadcrumb
  cat > temp_breadcrumb.html << EOF
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                    <li class="breadcrumb-item"><a href="index.html#physics">Physics Notes</a></li>
                    <li class="breadcrumb-item active" aria-current="page">$pagetitle</li>
                </ol>
            </nav>
EOF
  
  # Replace the entire breadcrumb section
  sed -i '' '/<nav aria-label="breadcrumb">/,/<\/nav>/ {
    /<nav aria-label="breadcrumb">/r temp_breadcrumb.html
    /<nav aria-label="breadcrumb">/,/<\/nav>/d
  }' "$file"
  
  # Fix footer height
  sed -i '' 's/footer style="height: 10%"/footer style="height: 20%"/' "$file"
  
  echo "Done fixing breadcrumb in $file"
done

# Clean up
rm -f temp_breadcrumb.html

echo "All breadcrumbs fixed successfully!" 