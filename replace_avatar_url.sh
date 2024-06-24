#!/bin/bash

# Define search and replace patterns
SEARCH_PATTERN="avatar_url(current_user)"
REPLACE_PATTERN="@user.image.url()"

# Find all Ruby files (assuming .rb extension) and replace the patterns
find . -type f -name "*.rb" -exec sed -i "s/${SEARCH_PATTERN}/${REPLACE_PATTERN}/g" {} +
