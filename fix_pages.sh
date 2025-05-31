#!/bin/bash

# This script manually updates all HTML pages with the sidebar and navigation

# Files to update
FILES=(
  "forces-newtons-laws.html"
  "momentum.html"
  "motion-two-dimensions.html"
  "thermal-energy.html"
  "work-energy.html"
)

# For each file, manually update with the correct sidebar and navigation
for file in "${FILES[@]}"; do
  echo "Updating $file..."
  
  # Check if file exists
  if [ ! -f "$file" ]; then
    echo "  Warning: $file not found, skipping."
    continue
  fi

  # Extract content after the first section tag
  CONTENT=$(sed -n '/<section class="py-5">/,$p' "$file")
  
  # Extract header content
  HEADER=$(sed -n '/<head>/,/<\/head>/p' "$file")
  
  # Create new file with proper structure
  cat > "${file}.new" << EOF
<!DOCTYPE html>
<html lang="en">
$HEADER
<body>
    <!-- Sidebar Navigation -->
    <div class="offcanvas offcanvas-start" tabindex="-1" id="sidebar" aria-labelledby="sidebarLabel">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title" id="sidebarLabel">Physics Topics</h5>
            <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">
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
            </ul>
            <hr>
            <h6 class="sidebar-heading">Aerospace Engineering</h6>
            <ul class="nav flex-column mb-2">
                <li class="nav-item">
                    <a class="nav-link" href="#">Aerodynamics</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Orbital Mechanics</a>
                </li>
            </ul>
        </div>
    </div>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container">
            <button class="btn btn-outline-light me-2" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebar" aria-controls="sidebar">
                <i class="fas fa-bars"></i>
            </button>
            <a class="navbar-brand" href="index.html">Jake's Physics Notes</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.html#home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="index.html#physics">Physics Notes</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="index.html#aerospace">Aerospace Engineering</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="index.html#profile">Profile</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Topic Header -->
    <section class="py-5 bg-light">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                    <li class="breadcrumb-item"><a href="index.html#physics">Physics Notes</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${file%.*}</li>
                </ol>
            </nav>
            <h1 class="section-title">${file%.*}</h1>
            <p class="lead">Understanding the physics of ${file%.*}</p>
        </div>
    </section>

$CONTENT
EOF

  # Replace the original file
  mv "${file}.new" "$file"
  
  echo "  Updated $file successfully."
done

echo "All files have been updated with the sidebar and navigation." 