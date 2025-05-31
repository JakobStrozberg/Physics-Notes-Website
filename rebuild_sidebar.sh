#!/bin/bash

# Script to completely rebuild the sidebar navigation in all HTML files

# Create a file with the correct sidebar navigation HTML
cat > correct_sidebar.html << 'EOL'
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="index.html">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="motion-one-dimension.html">Motion in One Dimension</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="acceleration.html">Acceleration</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="forces-newtons-laws.html">Forces and Newton's Laws</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="motion-two-dimensions.html">Motion in Two Dimensions</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="circular-rotational-motion.html">Circular and Rotational Motion</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="momentum.html">Momentum</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="work-energy.html">Work and Energy</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="thermal-energy.html">Thermal Energy</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="magnetism.html">Magnetism, Waves & Optics</a>
                </li>
            </ul>
EOL

# Create correct breadcrumb HTML without Contact link
cat > correct_breadcrumb.html << 'EOL'
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                    <li class="breadcrumb-item"><a href="index.html#physics">Physics Notes</a></li>
EOL

# List of all HTML files except index.html and 404.html
HTML_FILES=$(find . -name "*.html" -not -name "index.html" -not -name "404.html")

for file in $HTML_FILES; do
  echo "Rebuilding sidebar in $file..."
  
  # Extract the filename for breadcrumb
  filename=$(basename "$file")
  pagename=$(echo "$filename" | sed 's/\.html//')
  
  # Get the page title for breadcrumb
  pagetitle=$(grep -A1 "<li class=\"breadcrumb-item active\"" "$file" | tail -1 | sed 's/.*<li class="breadcrumb-item active".*>\(.*\)<\/li>.*/\1/')
  
  # Replace sidebar navigation
  sed -i '' '/<ul class="nav flex-column">/,/<\/ul>/ {
    /<ul class="nav flex-column">/r correct_sidebar.html
    /<ul class="nav flex-column">/,/<\/ul>/d
  }' "$file"
  
  # Fix breadcrumb navigation
  sed -i '' '/<nav aria-label="breadcrumb">/,/<\/ol>/ {
    /<nav aria-label="breadcrumb">/r correct_breadcrumb.html
    /<nav aria-label="breadcrumb">/,/<\/ol>/d
  }' "$file"
  
  # Add the current page to breadcrumb
  sed -i '' "/<\/ol>/i\\
                    <li class=\"breadcrumb-item active\" aria-current=\"page\">$pagetitle<\/li>" "$file"
  
  # Fix footer height
  sed -i '' 's/footer style="height: 10%"/footer style="height: 20%"/' "$file"
  
  echo "Done rebuilding sidebar in $file"
done

# Clean up
rm -f correct_sidebar.html correct_breadcrumb.html

echo "All sidebars rebuilt successfully!" 