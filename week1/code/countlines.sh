#!/bin/bash

export NUM_LINES=$(wc -l < $1)
echo "the file $1 has $NUM_LINES lines"
echo
#why doesnt this work??/ [!]