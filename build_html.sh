#!/bin/bash
mv docs html
cd html
make html
cd ../
mv html docs
git add -A
git commit -m "$1"
