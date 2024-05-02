while IFS=, read -r url title; do
    # Extract the common prefix from the URL
    prefix=$(echo "$url" | awk -F'/' '{print $4}')

    # Remove leading and trailing whitespaces from the title
    title=$(echo "$title" | sed 's/^[ \t]//;s/[ \t]$//')

    # Append the title to the corresponding category in the associative array
    categories["$prefix"]+="$title\n"
done < "$input_file"

# Write the categories and titles to the output CSV file
echo "URL,overview,campus,courses,scholarships,admission,placements,results" > "$output_file"
for category in "${!categories[@]}"; do
    # Create a row for each category
    row="$category,${categories[$category]}"
    
    # Write the row to the output CSV file
    echo "$row" | awk 'BEGIN { FS = ","; OFS = "," } { print $1, $2, $3, $4, $5, $6, $7, $8 }' >> "$output_file"
CLOSE
done

echo "Output CSV file generated: $output_file"s