#!/bin/bash
DEST_DIR="$HOME/Bashing_Boxes/Bashing_Boxes/Data"
mkdir -p "$DEST_DIR"
SAVED_LIST="saved_list.txt"


array_of_things=(
    "mal" 
    "ben" 
    "carlos" 
    "evie" 
    "Jay" 
    "Audrey" 
    "uma" 
    "Hook" 
    "Red" 
    "Chloe"
)

menu_of_input_valuesibilities=(
    "1. Print list\n"
    "2. Print item at X position in list\n"
    "3. Add item to list\n"
    "4. Remove last item from list\n"
    "5. Remove item from X position\n"
    "6. Exit\n"
    "7. Generate random box from file\n"
)

save_list_menu=(
    "A. Save list" 
    "B. Load previous list" 
    "C. List existing saved files" 
    "D. Exit"
)

get_user_input(){
    read -p "Enter: " input_value
}

display_array(){
    echo "Descendants Characters"
    echo "====================="
    echo "${array_of_things[@]}"
}

display_menu_of_input_valuesibilities(){
    echo "Main Menu"
    echo "====================="
    echo -e "${menu_of_input_valuesibilities[@]}"
}

display_save_list_menu(){
    echo "Save/Load Menu"
    echo "====================="
    echo "${save_list_menu[@]}"
}

print_list(){
    echo "Here is your list:"
    echo "${array_of_things[@]}"
}

print_item_input_valueition(){
    get_user_input
    if [[ $input_value =~ ^[0-9]+$ && $input_value -ge 1 && $input_value -le ${#array_of_things[@]} ]]; then
        echo -e "Here is your Character: ${array_of_things[$((input_value-1))]}"
    else
        echo "Invalid position"
    fi
}

enter_new_character(){
    echo "Enter new Character:"
    get_user_input
    array_of_things+=("$input_value")
    display_array
}

remove_last_character(){
    echo -e "Do you want to remove ${array_of_things[-1]}? (Y/n)"
    get_user_input
    if [[ $input_value == "Y" || $input_value == "y" ]]; then
        unset 'array_of_things[-1]'
        display_array
    else
        echo "Cancelled"
    fi       
}

remove_any_character(){
    echo "Enter character number"
    get_user_input
    if [[ $input_value =~ ^[0-9]+$ && $input_value -ge 1 && $input_value -le ${#array_of_things[@]} ]]; then
        echo "You chose: ${array_of_things[$((input_value-1))]}"
        read -p "Remove it? (Y/n): " yes__no
        if [[ "$yes__no" == "Y" || "$yes__no" == "y" ]]; then
            unset 'array_of_things[$((input_value-1))]'
            array_of_things=("${array_of_things[@]}")  # reindex
            echo "Updated list: ${array_of_things[@]}"
        else
            echo "Cancelled"
        fi
    else
        echo "Invalid position"
    fi
}

exit_program(){
    echo "See you soon"
    exit 0
}

save_list_lazy(){
    count=$(ls "$DEST_DIR"/edited_file_* 2>/dev/null | wc -l)
    next_num=$((count + 1))
    edited_file_="$DEST_DIR/edited_file_${next_num}.txt"
    printf "%s\n" "${array_of_things[@]}" > "$edited_file_"
    echo "Saved new version: $edited_file_"
}

save_current_list(){
    printf "%s\n" "${array_of_things[@]}" > "$SAVED_LIST"
    echo "List saved to $SAVED_LIST"
}

save_list(){
    read -p "Do you want to save to the default file? (y/n): " enter
    if [[ "$enter" == "Y" || "$enter" == "y" ]]; then
        save_current_list
    else
        save_list_lazy
    fi
}





print_made_lists(){
    files=("$DEST_DIR"/edited_file_*.txt)
    if [[ ${#files[@]} -eq 0 ]]; then
        echo "No saved files found."
    else 
        echo "Saved Files:"
        ls "$DEST_DIR"
    fi
}

load_previous() {
    files=("$DEST_DIR"/edited_file_*.txt)
    if [[ ${#files[@]} -eq 0 ]]; then
        echo "No saved list found"
    else 
        print_made_lists
        echo "Enter file number:"
        get_user_input
        file_index=$((input_value-1))
        if [[ $file_index -ge 0 && $file_index -lt ${#files[@]} ]]; then
            mapfile -t array_of_things < "${files[$file_index]}"
            echo "Here is your file:"
            echo "${array_of_things[@]}"
        else
            echo "Invalid file number"
        fi
    fi
}

what_next(){
    echo " Do you wanna exit Y/n ?"
    get_user_input
    if [[ $input_value == "N" || $input_value == "n" ]]; then
        display_save_list_menu
        get_user_input
        case $input_value in
            A|a) save_list ;;
            B|b) print_made_lists ;;
            C|c) load_previous ;;
            D|d) exit_program ;;
             *) 
        echo "Invalid"
        exit_program ;;
esac

        #statements
    fi
}

Generate_random_box_from_file(){
    box_array=()
    ls 
    read -p "Enter file name" box
    if [[ $box == "box" || $box == "box.txt" ]]; then # -f "$box_file"
        mapfile -t box_array < <(grep -vE '^\s*$|^\s*#' box.txt)
        box_size
    else
        echo "invalid"
    fi
}
box_size(){
    read -p "How many items do you want in box? " number

    if [[ "$number" =~ ^[0-9]+$ && "$number" -le ${#box_array[@]} ]]; then
        mapfile -t shuffled < <(printf "%s\n" "${box_array[@]}" | shuf -n "$number")

        printf "%s\n" "${shuffled[@]}"

        array_of_things=("${shuffled[@]:0:number}")

        display_menu_of_input_valuesibilities
        read -p "what do you want? " input_value
        final
    else
        echo "Invalid amount"
        Generate_random_box_from_file
    fi
}






# Display menus and get input
display_menu_of_input_valuesibilities
get_user_input
final(){
    case $input_value in
    1) print_list 
       what_next
       ;;
    2) print_item_input_valueition
       what_next 
       ;;
    3) enter_new_character 
       what_next
       ;;
    4) remove_last_character 
       what_next
       ;;
    5) remove_any_character 
       what_next
       ;;
    6) exit_program ;;
    7) Generate_random_box_from_file;;
    A|a) save_list ;;
    B|b) load_previous ;;
    C|c) print_made_lists ;;
    D|d) exit_program ;;
    *) 
        echo "Invalid"
        exit_program ;;
esac

}
final
