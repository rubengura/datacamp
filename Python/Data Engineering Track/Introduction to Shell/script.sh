# LESSON 1
# Manipulating files and directories
# Copying files
cp original.txt duplicate.txt
cp seasonal/autumn.csv seasonal/winter.csv backup

# Moving files to the directory above your current location
mv autumn.csv winter.csv ..
# Moving files renaming
mv course.txt old-course.txt

# Removing files
rm thesis.txt backup/thesis-2017-08.txt

# LESSON 2
# Viewing files content
cat agarwal.txt

# Viewing files page by page
less seasonal/spring.csv seasonal/summer.csv
# Pressing spacebar pages down
# Pressing :n moves to the next file
# Pressing :q quits the file

# Viewing the start of a file
head seasonal/summer.csv
head -n 3 seasonal/summer.csv