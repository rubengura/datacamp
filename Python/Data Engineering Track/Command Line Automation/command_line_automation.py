__author__ = "rgr"

### LESSON 1
# IPython commands
# Showing free disk
!df -h

# Capturing output of a command
ls = !ls

# Capturing .csv filenames from a directory
ls = !ls test_dir/*.csv

# Unix pipes
# Counting size of python files
ls -l | awk '{ SUM +=$5} END {print SUM}'

# Pipe multiple outputs using Pipe operators
ls -l | grep .py | awk '{ SUM +=$5} END {print SUM}'