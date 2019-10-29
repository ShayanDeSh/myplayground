#!/bin/bash
read -p "Enter your expression:" exp
declare -a array
tokens=$(echo $exp | grep -o -E '\w*')
for i in $tokens;do
	array=("${array[@]}" $i)
done
operand=$(echo $exp | grep -o -E '\+|-|/|\*')
if [[ $operand = '+' ]];then
	echo sum
	echo $((array[0]+array[1]))
elif [[ $operand = '*' ]];then
	echo $((array[0]*array[1]))
elif [[ $operand = '/' ]];then
	echo $((array[0]/array[1]))
elif [[ $operand = '-' ]];then
	echo $((array[0]-array[1]))
else
	echo duck you !!!
fi
