#!/bin/bash

# This script updates all HTML pages with the sidebar and navigation from the index.html page

# Define the files to update
FILES=(
  "acceleration.html"
  "circular-rotational-motion.html"
  "forces-newtons-laws.html"
  "momentum.html"
  "motion-two-dimensions.html"
  "thermal-energy.html"
  "work-energy.html"
)

# Extract the sidebar and navbar code from motion-one-dimension.html
SIDEBAR_START='<!-- Sidebar Navigation -->'
SIDEBAR_END='<!-- Navigation -->'
NAV_START='<!-- Navigation -->'
NAV_END='<!-- Topic Header -->'

# Update each file
for file in "${FILES[@]}"; do
  echo "Updating $file..."
  
  # Check if file exists
  if [ ! -f "$file" ]; then
    echo "  Warning: $file not found, skipping."
    continue
  fi
  
  # Add Font Awesome if missing
  if ! grep -q "font-awesome" "$file"; then
    sed -i '' 's#<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">#<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">\n    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">#' "$file"
  fi
  
  # Extract current body content
  BODY_CONTENT=$(sed -n '/<body>/,/<\/body>/p' "$file")
  
  # Extract sidebar from motion-one-dimension.html
  SIDEBAR=$(sed -n "/$SIDEBAR_START/,/$SIDEBAR_END/p" motion-one-dimension.html)
  
  # Extract navbar from motion-one-dimension.html
  NAVBAR=$(sed -n "/$NAV_START/,/$NAV_END/p" motion-one-dimension.html)
  
  # Replace the current navbar with the new one
  UPDATED_BODY=$(echo "$BODY_CONTENT" | sed -e "/<body>/,/<section/{/<body>/b;/<section/b;d}")
  UPDATED_BODY="<body>\n    $SIDEBAR\n    $NAVBAR\n    $(echo "$UPDATED_BODY" | sed '1d')"
  
  # Replace the body content in the file
  sed -i '' "/<body>/,/<\/body>/c\\
$UPDATED_BODY" "$file"
  
  echo "  Updated $file successfully."
done

echo "All files have been updated with the sidebar and navigation."

# List of all notes pages
PAGES=(
  "motion-one-dimension.html"
  "acceleration.html"
  "forces-newtons-laws.html"
  "motion-two-dimensions.html"
  "circular-rotational-motion.html"
  "momentum.html"
  "work-energy.html"
  "thermal-energy.html"
)

for page in "${PAGES[@]}"; do
  echo "Updating $page..."
  
  # Remove the Aerospace Engineering section from the sidebar
  sed -i '' '/<hr>/,/<\/ul>/s/<h6 class="sidebar-heading">Aerospace Engineering<\/h6>/<!-- Aerospace Engineering section removed -->/g' "$page"
  sed -i '' '/<hr>/,/<\/ul>/s/<ul class="nav flex-column mb-2">/<!-- Aerospace Engineering nav removed -->/g' "$page"
  sed -i '' '/<hr>/,/<\/ul>/s/<li class="nav-item">\s*<a class="nav-link" href="#">Aerodynamics<\/a>\s*<\/li>/<!-- Aerodynamics link removed -->/g' "$page"
  sed -i '' '/<hr>/,/<\/ul>/s/<li class="nav-item">\s*<a class="nav-link" href="#">Orbital Mechanics<\/a>\s*<\/li>/<!-- Orbital Mechanics link removed -->/g' "$page"
  
  # Empty the footer content, keeping only the structure
  sed -i '' '/<footer>/,/<\/footer>/c\
    <!-- Footer -->\
    <footer style="height: 10%;">\
        <div class="container">\
            <!-- Footer content removed as requested -->\
        </div>\
    </footer>' "$page"
  
  echo "Done updating $page"
done

echo "All pages updated successfully!" 