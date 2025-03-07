EXTENSIONS="*.jsp"
BASE_COPYRIGHT="Copyright IBM Corp. 2025"
DIRECTORY="./cics-java-liberty-hello-web/"

for ext in "$EXTENSIONS"; do
    for file in $(find . -type f -name "$ext" -path "$DIRECTORY*"); do
        echo "Processing file: $file"  
        
        LAST_MODIFIED_YEAR=$(git log --follow -1 --format="%ad" --date=format:"%Y" -- "$file")

        if ! grep -q "Copyright" "$file"; then
            echo -e "/**\n * $BASE_COPYRIGHT\n */\n$(cat "$file")" > "$file"
        else
            # Extract existing copyright line
            CURRENT_COPYRIGHT=$(grep -o "Copyright IBM Corp. [0-9]\{4\}\(, [0-9]\{4\}\)\?" "$file")

            ORIGINAL_YEAR=$(echo "$CURRENT_COPYRIGHT" | grep -o "[0-9]\{4\}" | head -1)
        
            # Check if LAST_MODIFIED_YEAR is anywhere in current copyright
            if [[ "$CURRENT_COPYRIGHT" != *"$LAST_MODIFIED_YEAR"* ]]; then
                # Check if copyright has two years
                if [[ "$CURRENT_COPYRIGHT" =~ ,\ [0-9]{4}$ ]]; then
                    # If there is already a second year, replace it
                    sed -i "" "s/Copyright IBM Corp. $ORIGINAL_YEAR, [0-9]\{4\}/Copyright IBM Corp. $ORIGINAL_YEAR, $LAST_MODIFIED_YEAR/" "$file"
                else
                    # If there is no second year, add it
                    sed -i "" "s/$CURRENT_COPYRIGHT/$CURRENT_COPYRIGHT, $LAST_MODIFIED_YEAR/" "$file"
                fi
            fi
        fi
    done
done