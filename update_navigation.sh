#!/bin/bash

# This script updates the navigation sidebar in all HTML files
# It removes the Contact link and adds the Magnetism, Waves & Optics link if missing

# List of all HTML files except index.html (which already has the correct navigation)
HTML_FILES=$(find . -name "*.html" -not -name "index.html" -not -name "404.html")

for file in $HTML_FILES; do
  echo "Updating navigation in $file..."
  
  # Remove Contact link from sidebar
  sed -i '' '/href="contact.html">Contact<\/a>/d' "$file"
  
  # Create a temporary file with the magnetism link
  cat > temp_magnetism.txt << 'EOL'
                <li class="nav-item">
                    <a class="nav-link" href="magnetism.html">Magnetism, Waves & Optics</a>
                </li>
EOL
  
  # Check if Magnetism link already exists in the file
  if ! grep -q 'href="magnetism.html">Magnetism, Waves & Optics<\/a>' "$file"; then
    # Add Magnetism link before the closing </ul> tag in the sidebar navigation
    # Find the line number of the closing </ul> tag
    ul_line=$(grep -n '</ul>' "$file" | head -1 | cut -d':' -f1)
    
    # Use ed to insert the content at the specified line
    ed -s "$file" << EOF
${ul_line}-1r temp_magnetism.txt
w
q
EOF
  fi
  
  # Remove Contact links from breadcrumb navigation
  sed -i '' '/breadcrumb-item.*href="contact.html">Contact<\/a>/d' "$file"
  sed -i '' '/<li class="nav-item">\s*<a class="nav-link" href="contact.html">Contact<\/a>\s*<\/li>/d' "$file"
  
  # Update footer height to match index.html (20%)
  sed -i '' 's/footer style="height: 10%"/footer style="height: 20%"/' "$file"
  
  echo "Done updating $file"
done

# Clean up
rm -f temp_magnetism.txt

echo "Navigation update complete!" 