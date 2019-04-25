#!/bin/bash

for i in {0..80..2}
do
	echo $i
	python top_block.py -n $i
done
