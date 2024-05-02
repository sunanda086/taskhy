

# Define input and output file names
input_file="input.csv"
output_file="output.csv"

# Create associative array to store categories and corresponding titles
declare -A categories

# Read input CSV file line by line
while IFS=',' read -r url title; do
    # Extract common prefix from URL
    prefix=$(echo "$url" | grep -o '^[^/]//[^/]')
    
    # Check if category exists in associative array
    if [[ -v "categories[$prefix]" ]]; then
        # Append title to existing category
        categories[$prefix]+=",$title"
    else
        # Create new category with title
        categories[$prefix]="$title"
    fi
done < "$input_file"

# Write categories and titles to output CSV file
for prefix in "${!categories[@]}"; do
    echo "$prefix,${categories[$prefix]}" >> "$output_file"
done

echo "Data has been sanitized and restructured. Output saved to $output_file"