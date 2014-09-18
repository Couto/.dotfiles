#!/bin/bash

PACKAGES=$(cat <<EOF
    grunt-cli
    yo
    serve
    nodemon
    nesh
EOF)

INSTALLED=$(npm ls -g --depth 0);

for package in $PACKAGES; 
do
    in_global=$(npm ls -g --depth 0 --parsable | grep -o $package)
    echo $in_global
done
