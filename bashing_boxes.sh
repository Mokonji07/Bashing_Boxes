#!/bin/bash
#nano readme
# Bashing Boxes
#===============
array_of_things=("mal" "ben" "carlos" "evie" "Jay" "Audrey" "uma" "Hook" "Red" "Chloe")

echo "
	hello
	This is on a new line!
	"
echo $array_of_things
echo "choose an option: "
#read varaiable
#echo $varaiable

echo ${array_of_things[@]}
read character
echo "welcome" $character ",Lets do some calculating"

read -p "Enter first number: " num1
read -p "Enter second number: " num2

sum=$((num1 + num2))
echo "Sum: "$sum