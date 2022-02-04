#!/usr/bin/bash
IFS=$'\n'
lit_head="# RUN: choco-opt %s | filecheck %s"

file_backup=$(cat $1)
if [[ $file_backup == *$lit_head* ]]
then
	echo already written, exit
	exit
fi

xs=$(tools/choco-opt $1)

echo >> $1
echo >> $1
echo $lit_head >> $1

flag=1
for x in ${xs[@]}
do
	if [[ $flag -eq 0 ]]
	then
		echo -n "# CHECK-NEXT: " >> $1
	else
		echo -n "# CHECK: " >> $1
		flag=0
	fi
	echo $x >> $1

done
