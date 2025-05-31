#!/bin/bash

# Final script to fix remaining issues

# List of all HTML files except index.html and 404.html
HTML_FILES=$(find . -name "*.html" -not -name "index.html" -not -name "404.html")

for file in $HTML_FILES; do
  echo "Final fixes for $file..."
  
  # Create a temporary file
  temp_file=$(mktemp)
  
  # Fix the table of contents by directly replacing it with a clean version
  cat > clean_toc.html << 'EOL'
                <div class="table-of-contents card mb-4">
                    <div class="card-body">
                        <h5 class="card-title">In this section:</h5>
                        <ol>
                            <li><a href="#position">Position and Displacement</a></li>
                            <li><a href="#velocity">Velocity</a></li>
                            <li><a href="#acceleration">Acceleration in One Dimension</a></li>
                            <li><a href="#equations">Kinematic Equations</a></li>
                            <li><a href="#free-fall">Free Fall Motion</a></li>
                        </ol>
                    </div>
                </div>
EOL
  
  # Fix the footer height by directly replacing it
  cat > clean_footer.html << 'EOL'
    <!-- Footer -->
    <!-- Footer -->
    <footer style="height: 20%;">
        <div class="container">
            <!-- Footer content removed as requested -->
        </div>
    </footer>
EOL
  
  # Use sed to replace the table of contents section
  sed -i '' '/<div class="table-of-contents card mb-4">/,/<\/div>/ {
    /<div class="table-of-contents card mb-4">/r clean_toc.html
    /<div class="table-of-contents card mb-4">/,/<\/div>/d
  }' "$file"
  
  # Use sed to replace the footer section
  sed -i '' '/<footer style="height: 10%">/,/<\/footer>/ {
    /<footer style="height: 10%">/r clean_footer.html
    /<footer style="height: 10%">/,/<\/footer>/d
  }' "$file"
  
  echo "Done with final fixes for $file"
done

# Clean up
rm -f clean_toc.html clean_footer.html

echo "All fixes complete!" 