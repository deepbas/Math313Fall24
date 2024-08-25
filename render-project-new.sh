#!/bin/bash
# chmod +x render_project-new.sh

# SPECIFIC_FILES=("index.qmd" "about.qmd" "datasets.qmd" "assignments.qmd" "github_tutorial.qmd" "posit.qmd" "software.qmd")
# 
# # Render each specific file
# for FILE in "${SPECIFIC_FILES[@]}"; do
#   if [[ -f "$FILE" ]]; then
#     echo "Rendering $FILE..."
#     quarto render "$FILE" --to html --output-dir _site
#   else
#     echo "File $FILE does not exist, skipping..."
#   fi
# done

# Function to find the highest number of existing Day or CA files
function find_last_number {
  local pattern=$1
  local max_no=0
  for file in $pattern*.qmd; do
    if [[ -f "$file" ]]; then
      number=$(basename "$file" | grep -o -E '[0-9]+')
      if ((number > max_no)); then
        max_no=$number
      fi
    fi
  done
  return $max_no
}

find_last_number "Day"
LAST_DAY=$?
DAY_START=$((LAST_DAY - 1))  
DAY_END=$((LAST_DAY ))    

for i in $(seq $DAY_START $DAY_END); do
  DAY_FILE="Day$i.qmd"
  if [[ -f "$DAY_FILE" ]]; then
    echo "Rendering $DAY_FILE..."
    quarto render "$DAY_FILE" --to html --output-dir _site
  else
    echo "File $DAY_FILE does not exist, skipping..."
  fi
done

find_last_number "class_activity_"
LAST_CA=$?
CA_START=$((LAST_CA - 1))  
CA_END=$((LAST_CA ))    

for i in $(seq $CA_START $CA_END); do
  CA_FILE="class_activity_$i.qmd"
  if [[ -f "$CA_FILE" ]]; then
    echo "Rendering $CA_FILE..."
    quarto render "$CA_FILE" --to html --output-dir _site
  else
    echo "File $CA_FILE does not exist, skipping..."
  fi
done

echo "Rendering process completed."
