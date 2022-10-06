#!/bin/bash

cat $1 > $3
cat $2 >> $3
echo "merged file is"
cat $3
