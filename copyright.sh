EXTENSIONS="*.jsp"
BASE_COPYRIGHT="Copyright IBM Corp. 2025"
for ext in "$EXTENSIONS"; do
    for file in $(find . -type f -name "$ext" ! -path "cics-java-liberty-hello-web/*"); do
        echo "Processing file: $file"  
        LAST_MODIFIED_YEAR=$(date -r "$file" +"%Y")
        
        if ! grep -q "Copyright" "$file"; then
            echo -e "/**\n * $BASE_COPYRIGHT\n */\n$(cat "$file")" > "$file"
        elif ! grep -q "$LAST_MODIFIED_YEAR" "$file"; then
            if [[ "$OSTYPE" == "darwin"* ]]; then
                sed -i "" "s/$BASE_COPYRIGHT[^0-9]*/$BASE_COPYRIGHT, $LAST_MODIFIED_YEAR/" "$file"
            else
                sed -i "s/$BASE_COPYRIGHT/$BASE_COPYRIGHT, $LAST_MODIFIED_YEAR/" "$file"
           
        fi
    done
done
