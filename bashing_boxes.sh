#!/bin/bash
#nano readme
# Bashing Boxes
#===============
array_of_things=("mal" "ben" "carlos" "evie" "Jay" "Audrey" "uma" "Hook" "Red" "Chloe")
menu_of_possibilities=("1. Print list"
"2. Print item at X Position in list"
"3. add item to list"
"4. remove last item from list"
"5. remove item from X position"
"6. exit")
echo "${menu_of_possibilities[@]}"
read -p "choose an option [1-6]:" menu
mkdir /Bashing_Boxes/Bashing_Boxes/Data
SOURCE_FILE="mytext.txt"                           
DEST_DIR="$HOME/Bashing_Boxes/Bashing_Boxes/Data"
mkdir -p "$DEST_DIR"

Save_List_after() {    
    count=$(ls "$DEST_DIR"/edited_file_* 2>/dev/null | wc -l)
    next_num=$((count + 1))
    edited_file_="$DEST_DIR/edited_file_${next_num}.txt"
    printf "%s\n" "${array_of_things[@]}" > "$edited_file_"
    echo "Saved new version: $edited_file"
}

load_previous() {
    files=("$DEST_DIR"/edited_file_*.txt)
    if [[ ${#files[@]} -eq 0 ]]; then
        echo "No saved list found"
        return
    fi
    echo "Saved List"
    for i in "${!files[@]}"; do 
        echo "$((i+1)). ${files[$i]##*/}"
    done

    read -p "Enter the number of the file to load: " file_num
    if [[ "$file_num" =~ ^[0-9]+$ ]] && (( file_num >= 1 && file_num <= ${#files[@]} )); then
        file_to_load="${files[$((file_num-1))]}"
        mapfile -t array_of_things < "$file_to_load"
        echo "Loaded list from ${file_to_load##*/}:"
        echo "${array_of_things[@]}"
    else
        echo "Invalid"
    fi
}

print_made_lists() {
    files=("$DEST_DIR"/edited_file_*.txt)
    if [[ ${#files[@]} -eq 0 ]]; then
        echo "No saved files found."
        exit 0
fi
 echo "Saved Files"
 for file in "${files[@]}"; do
    exho " - ${file##*/}"
done
}

what_to_do_after() {
    should_i=("1. save list" 
              "2. load previous list" 
              "3. list existing saved files"
              "4. exit")
    echo "${should_i[@]}"
    read -p "what next: " next
    if [[ "$next" -eq 1 ]]; then
        Save_List_after
    elif [[ "$next" -eq 2 ]]; then
        load_previous
    elif [[ "$next" -eq 3 ]]; then
        print_made_lists

    elif [[ "$next" -eq 4 ]]; then
        exit 1
    fi

}


if ! [[ "$menu" =~ ^[0-9]+$ ]]; then
    echo "That's not an integer! Exiting..."
    exit 1
fi 

if [[ $menu -lt 1 || $menu -gt 6 ]]; then
    echo "Number is out of range. Exiting"
    exit 1
fi

if [[ $menu -eq 1 ]]; then
    echo "${array_of_things[@]}"
    what_to_do_after
    exit 1
fi

if [[ $menu -eq 2 ]]; then
      read -p "Enter item position: " pos
    if [[ "$pos" =~ ^[0-9]+$ ]] && (( pos >= 1 && pos <= ${#array_of_things[@]} )); then
        echo "${array_of_things[$((pos-1))]}"
        what_to_do_after
    else
        echo "invalid number"
        exit
    fi
fi

if [[ $menu -eq 3 ]]; then 
    read -p "Enter new character" character
    array_of_things+=("$character")
    echo "${array_of_things[@]}"
    what_to_do_after
    exit 1
fi

if [[ $menu -eq 4  ]]; then
    echo "DO you want to remove" {$array_of_things[-1]}
    read -p "Y/n" yes_no
    if [[ "$yes_no" == "Y" || "$yes_no" == "y" ]]; then
        unset 'array_of_things[-1]'
        echo "${array_of_things[@]}"
        what_to_do_after
        exit
    elif [[ $yes_no == "N" || "$yes_no" == "n" ]]; then
        echo "Goodbye..."
        what_to_do_after
        exit
    else
        echo "invalid response"
        what_to_do_after
        exit
    fi
fi

if [[ $menu -eq 5 ]]; then
    read -p "Enter item position: " pos
    if [[ "$pos" =~ ^[0-9]+$ ]] && (( pos >= 1 && pos <= ${#array_of_things[@]} )); then
        echo "You chose: ${array_of_things[$((pos-1))]}"
        read -p "Remove it? (Yes/no): " yes__no
        if [[ "$yes__no" == "Yes" || "$yes__no" == "yes" ]]; then
            unset 'array_of_things[$((pos-1))]'
            array_of_things=("${array_of_things[@]}")  # reindex
            echo "Updated list: ${array_of_things[@]}"
            what_to_do_after
        else
            echo "Cancelled."
            what_to_do_after
        fi
    else
        echo "Invalid position! Exiting..."
        what_to_do_after
        exit 1
    fi
fi

if [[ $menu -eq 6 ]]; then
    exit 1
fi
