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
    exit 1
fi

if [[ $menu -eq 2 ]]; then
      read -p "Enter item position: " pos
    if [[ "$pos" =~ ^[0-9]+$ ]] && (( pos >= 1 && pos <= ${#array_of_things[@]} )); then
        echo "${array_of_things[$((pos-1))]}"
    else
        echo "invalid number"
        exit
    fi
fi

if [[ $menu -eq 3 ]]; then 
    read -p "Enter new character" character
    array_of_things+=("$character")
    echo "${array_of_things[@]}"
    exit 1
fi

if [[ $menu -eq 4  ]]; then
    echo "DO you want to remove" {$array_of_things[-1]}
    read -p "Y/n" yes_no
    if [[ "$yes_no" == "Y" || "$yes_no" == "y" ]]; then
        unset 'array_of_things[-1]'
        echo "${array_of_things[@]}"
        exit
    elif [[ $yes_no == "N" || "$yes_no" == "n" ]]; then
        echo "Goodbye..."
        exit
    else
        echo "invalid response"
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
        else
            echo "Cancelled."
        fi
    else
        echo "Invalid position! Exiting..."
        exit 1
    fi
fi

if [[ $menu -eq 6 ]]; then
    exit 1
fi
