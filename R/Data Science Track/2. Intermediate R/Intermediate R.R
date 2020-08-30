# Lesson 1 Conditionals and Control Flow
# Comparison of logicals
TRUE == FALSE

# Comparison of numerics
-6 * 14 != 17 -101

# Comparison of character strings
"useR" == "user"

# Compare a logical with a numeric
TRUE == 1

# Comparison of numerics
(-6 * 5 +2) >= (-10 + 1)

# Comparison of character strings
"raining" <= "raining dogs"

# Comparison of logicals
TRUE > FALSE

# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# Popular days
linkedin > 15

# Quiet days
linkedin <= 5

# The social data has been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)
views <- matrix(c(linkedin, facebook), nrow = 2, byrow = TRUE)

# When does views equal 13?
views == 13

# When is views less than or equal to 14?
views <= 14

# The linkedin and last variable are already defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
last <- tail(linkedin, 1)

# Is last under 5 or above 10?
last < 5 | last > 10

# Is last between 15 (exclusive) and 20 (inclusive)?
last >15 & last <= 20

# The social data (linkedin, facebook, views) has been created for you

# linkedin exceeds 10 but facebook below 10
linkedin > 10 & facebook < 10

# When were one or both visited at least 12 times?
linkedin >= 12 | facebook >= 12

# When is views between 11 (exclusive) and 14 (inclusive)?
views > 11 & views <= 14

# li_df is pre-loaded in your workspace

# Select the second column, named day2, from li_df: second
second <- li_df[,"day2"]

# Build a logical vector, TRUE if value in second is extreme: extremes
extreme <- second > 25 | second < 5

# Count the number of TRUEs in extremes
sum(extreme)

# Solve it with a one-liner
sum(li_df[,"day2"] > 25 | li_df[,"day2"] < 5)

# Variables related to your last day of recordings
medium <- "LinkedIn"
num_views <- 14

# Control structure for medium
if (medium == "LinkedIn") {
  print("Showing LinkedIn information")
} else if (medium == "Facebook") {
print("Showing Facebook information")

  # Add code to print correct string when condition is TRUE
} else {
  print("Unknown medium")
}

# Control structure for num_views
if (num_views > 15) {
  print("You're popular!")
} else if (num_views <= 15 & num_views > 10) {
  print("Your number of views is average")
  # Add code to print correct string when condition is TRUE

} else {
  print("Try to be more visible!")
}

# Variables related to your last day of recordings
li <- 15
fb <- 9

# Code the control-flow construct
if (li >= 15 & fb >= 15) {
  sms <- 2 * (li + fb)
} else if (li < 10 & fb < 10) {
  sms <- 0.5 * (li + fb)
} else {
  sms <- li + fb
}

# Print the resulting sms to the console
sms

# Lesson 2 While Loop

# Initialize the speed variable
speed <- 64

# Code the while loop
while (speed > 30) {
  print("Slow down!")
  speed <- speed - 7

}

# Print out the speed variable
speed

# Initialize the speed variable
speed <- 64

# Extend/adapt the while loop
while (speed > 30) {
  print(paste("Your speed is",speed))
  if (speed > 48) {
    print("Slow down big time!")
    speed <- speed - 11
  } else {
    print("Slow down!")
    speed <- speed - 6
  }
}

# Initialize the speed variable
speed <- 88

while (speed > 30) {
  print(paste("Your speed is", speed))

  # Break the while loop when speed exceeds 80
  if (speed > 80) {
    break()
  }

  if (speed > 48) {
    print("Slow down big time!")
    speed <- speed - 11
  } else {
    print("Slow down!")
    speed <- speed - 6
  }
}


# Initialize i as 1
i <- 1

# Code the while loop
while (i <= 10) {
  print(3*i)
  if ((3*i) %% 8 == 0) {
  print(3*1)
  break()
  }
  i <- i + 1
}

# For loop
# The linkedin vector has already been defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)

# Loop version 1
for (i in linkedin){
  print(i)
}

# Loop version 2
for (i in 1:length(linkedin)){
  print(linkedin[i])
}

# The nyc list is already specified
nyc <- list(pop = 8405837,
            boroughs = c("Manhattan", "Bronx", "Brooklyn", "Queens", "Staten Island"),
            capital = FALSE)

# Loop version 1
for (i in nyc){
  print(i)
}



# Loop version 2
for (i in 1:length(nyc)){
  print(nyc[[i]])
}

# The tic-tac-toe matrix ttt has already been defined for you

#ttt
#     [,1] [,2] [,3]
#[1,] "O"  NA   "X"
#[2,] NA   "O"  "O"
#[3,] "X"  NA   "X"

# define the double for loop
for (i in 1:nrow(ttt)) {
  for (j in 1:ncol(ttt)) {
    print(paste("On row", i, "and column", j, "the board contains", ttt[i,j]))
  }
}

# The linkedin vector has already been defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)

# Code the for loop with conditionals
for (li in linkedin) {
  if (li > 10 ) {
    print("You're popular!")
  } else {
    print("Be more visible!")
  }
  print(li)
}

# The linkedin vector has already been defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)

# Extend the for loop
for (li in linkedin) {
  if (li > 10) {
    print("You're popular!")
  } else {
    print("Be more visible!")
  }

  # Add if statement with break
  if (li > 16){
    print("This is ridiculous, I'm outta here!")
    break()
  } else

  # Add if statement with next
  if(li < 5){
    print("This is too embarrassing!")
    next()
  }

  print(li)
}

# Pre-defined variables
rquote <- "r's internals are irrefutably intriguing"
chars <- strsplit(rquote, split = "")[[1]]

# Initialize rcount
rcount <- 0

# Finish the for loop
for (char in chars) {
  if (char == "r"){
    rcount <- rcount + 1
  } else if (char == "u") {
    break()
  }
  print(rcount)
}

# Lesson 3 Introduction to functions
# Consult the documentation on the mean() function
help(mean)

# Inspect the arguments of the mean() function
args(mean)


# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# Calculate average number of views
avg_li <- mean(linkedin)
avg_fb <- mean(facebook)

# Inspect avg_li and avg_fb
print(avg_li)
print(avg_fb)

# Calculate the mean of the sum
avg_sum <- mean(linkedin + facebook)

# Calculate the trimmed mean of the sum
avg_sum_trimmed <- mean(linkedin + facebook, trim = 0.2)

# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, NA, 17, 14)
facebook <- c(17, NA, 5, 16, 8, 13, 14)

# Basic average of linkedin
mean(linkedin)

# Advanced average of linkedin
mean(linkedin, na.rm = T)

# Calculate the mean absolute deviation
mean(abs(linkedin - facebook), na.rm = T)

# Writing functions
# Create a function pow_two()
pow_two <- function(x){
  return(x**2)
}


# Use the function
pow_two(12)

# Create a function sum_abs()
sum_abs <- function(x, y) {
  return(abs(x) + abs(y))
}


# Use the function
sum_abs(-2, 3)

# Define the function hello()
hello <- function() {
  print("Hi there!")
  return(TRUE)
}

# Call the function hello()
hello()

# Finish the pow_two() function
pow_two <- function(x, print_info = TRUE) {
  y <- x ^ 2
  if (print_info == TRUE){
   print(paste(x, "to the power two equals", y))
  }
  return(y)
}


# The linkedin and facebook vectors have already been created for you

# Define the interpret function
interpret <- function(num_views) {
  if (num_views > 15) {
    print("You're popular!")
    return(num_views)
  } else {
    print("Try to be more visible!")
    return(0)
  }
}

# Call the interpret function twice
interpret(linkedin[1])
interpret(facebook[2])


# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# The interpret() can be used inside interpret_all()
interpret <- function(num_views) {
  if (num_views > 15) {
    print("You're popular!")
    return(num_views)
  } else {
    print("Try to be more visible!")
    return(0)
  }
}

# Define the interpret_all() function
# views: vector with data to interpret
# return_sum: return total number of views on popular days?
interpret_all <- function(views, return_sum = TRUE) {
  count <- 0

  for (v in views) {
  count <- count + interpret(v)
  }

  if (return_sum) {
    return(count)
  } else {
    return(NULL)
  }
}

# Call the interpret_all() function on both linkedin and facebook
interpret_all(linkedin)
interpret_all(facebook)

# Load the ggplot2 package
library(ggplot2)

# Retry the qplot() function
qplot(mtcars$wt, mtcars$hp)

# Check out the currently attached packages again
search()

# Lesson 4 The apply family

# lapply
# The vector pioneers has already been created for you
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")

# Split names from birth year
split_math <- strsplit(pioneers, split = ":")

# Convert to lowercase strings: split_low
split_low <- lapply(split_math, tolower)

# Take a look at the structure of split_low
str(split_low)

# Write function select_first()
select_first <- function(x) {
  x[1]
}

# Transform: use anonymous function inside lapply
names <- lapply(split_low, function(x) {
  x[1]
})

# Transform: use anonymous function inside lapply
years <- lapply(split_low, function(x) {
  x[2]
})

# Generic select function
select_el <- function(x, index) {
  x[index]
}

# Use lapply() twice on split_low: names and years
names <-lapply(split_low, select_el, 1)
years <- lapply(split_low, select_el, 2)

# sapply
# temp is already defined in the workspace
# temp
#[[1]]
#[1]  3  7  9  6 -1
#
#[[2]]
#[1]  6  9 12 13  5
#
#[[3]]
#[1]  4  8  3 -1 -3
#
#[[4]]
#[1]  1  4  7  2 -2
#
#[[5]]
#[1] 5 7 9 4 2
#
#[[6]]
#[1] -3  5  8  9  4
#
#[[7]]
#[1] 3 6 9 4 1

# Finish function definition of extremes_avg
extremes_avg <- function(x) {
  ( min(x) + max(x) ) / 2
}

# Apply extremes_avg() over temp using sapply()
sapply(temp, extremes_avg)

# Apply extremes_avg() over temp using lapply()
lapply(temp, extremes_avg)

# Create a function that returns min and max of a vector: extremes
extremes <- function(x) {
  c(min = min(x), max= max(x))
}

# Apply extremes() over temp with sapply()
sapply(temp, extremes)

# Apply extremes() over temp with lapply()
lapply(temp, extremes)

# Definition of below_zero()
below_zero <- function(x) {
  return(x[x < 0])
}

# Apply below_zero over temp using sapply(): freezing_s
freezing_s <- sapply(temp, below_zero)

# Apply below_zero over temp using lapply(): freezing_l
freezing_l <- lapply(temp, below_zero)

# Are freezing_s and freezing_l identical?
identical(freezing_s, freezing_l)

# Definition of print_info()
print_info <- function(x) {
  cat("The average temperature is", mean(x), "\n")
}

# Apply print_info() over temp using sapply()
sapply(temp, print_info)

# Apply print_info() over temp using lapply()
lapply(temp, print_info)

# vapply

# temp is already available in the workspace
#temp
#[[1]]
#[1]  3  7  9  6 -1
#
#[[2]]
#[1]  6  9 12 13  5
#
#[[3]]
#[1]  4  8  3 -1 -3
#
#[[4]]
#[1]  1  4  7  2 -2
#
#[[5]]
#[1] 5 7 9 4 2
#
#[[6]]
#[1] -3  5  8  9  4
#
#[[7]]
#[1] 3 6 9 4 1

# Definition of basics()
basics <- function(x) {
  c(min = min(x), mean = mean(x), max = max(x))
}

# Apply basics() over temp using vapply()
vapply(temp, basics, numeric(3))

# Fix the error:
vapply(temp, basics, numeric(4))

# Convert to vapply() expression
vapply(temp, max, numeric(1))

# Convert to vapply() expression
vapply(temp, function(x, y) { mean(x) > y }, y = 5, logical(1))


# Lesson 5 Utilities
# The errors vector has already been defined for you
errors <- c(1.9, -2.6, 4.0, -9.5, -3.4, 7.3)

# Sum of absolute rounded values of errors
sum(round(abs(errors)))

# Don't edit these two lines
vec1 <- c(1.5, 2.5, 8.4, 3.7, 6.3)
vec2 <- rev(vec1)

# Fix the error
mean(append(abs(vec1), abs(vec2)))

# The linkedin and facebook lists have already been created for you
linkedin <- list(16, 9, 13, 5, 2, 17, 14)
facebook <- list(17, 7, 5, 16, 8, 13, 14)

# Convert linkedin and facebook to a vector: li_vec and fb_vec
li_vec <- unlist(linkedin)
fb_vec <- unlist(facebook)


# Append fb_vec to li_vec: social_vec
social_vec <- append(li_vec, fb_vec)

# Sort social_vec
sort(social_vec, decreasing = T)

# Fix me
rep(seq(1, 7, by = 2), times = 7)

# Create first sequence: seq1
seq1 <- seq(1,500, 3)

# Create second sequence: seq2
seq2 <- seq(1200, 900, -7)

# Calculate total sum of the sequences
sum(seq1, seq2)

# Regular Expressions
# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org",
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use grepl() to match for "edu"
grepl("edu", emails)

# Use grep() to match for "edu", save result to hits
hits <- grep("edu", emails)

# Subset emails using hits
emails[hits]

# Use grepl() to match for .edu addresses more robustly
grepl(pattern = "@.*\\.edu$", emails)

# Use grep() to match for .edu addresses more robustly, save result to hits
hits <- grep(pattern = "@.*\\.edu$", emails)

# Subset emails using hits
emails[hits]

# Use sub() to convert the email domains to datacamp.edu
sub("@.*\\.edu$", "@datacamp.edu", emails)


# Times and Dates
# Get the current date: today
today <- Sys.Date()

# See what today looks like under the hood
unclass(today)

# Get the current time: now
now <- Sys.time()

# See what now looks like under the hood
unclass(now)

# Definition of character strings representing dates
str1 <- "May 23, '96"
str2 <- "2012-03-15"
str3 <- "30/January/2006"

# Convert the strings to dates: date1, date2, date3
date1 <- as.Date(str1, format = "%b %d, '%y")
date2 <- as.Date(str2, format = "%Y-%m-%d")
date3 <- as.Date(str3, format = "%d/%B/%Y")

# Convert dates to formatted strings
format(date1, "%A")
format(date2, "%d")
format(date3, "%b %Y")

# Definition of character strings representing times
str1 <- "May 23, '96 hours:23 minutes:01 seconds:45"
str2 <- "2012-3-12 14:23:08"

# Convert the strings to POSIXct objects: time1, time2
time1 <- as.POSIXct(str1, format = "%B %d, '%y hours:%H minutes:%M seconds:%S")
time2 <- as.POSIXct(str2, format = "%Y-%m-%d %H:%M:%S")

# Convert times to formatted strings
format(time1, "%M")
format(time2, "%I:%M %p")

# day1, day2, day3, day4 and day5 are already available in the workspace
day1 <- "2020-08-12"
day2 <- "2020-08-14"
day3 <- "2020-08-19"
day4 <- "2020-08-25"
day5 <- "2020-08-30"

# Difference between last and first pizza day
day5 - day1

# Create vector pizza
pizza <- c(day1, day2, day3, day4, day5)

# Create differences between consecutive pizza days: day_diff
day_diff <- diff(pizza)

# Average period between two consecutive pizza days
mean(day_diff)

# login and logout are already defined in the workspace
#login
#[1] "2020-08-16 10:18:04 UTC" "2020-08-21 09:14:18 UTC"
#[3] "2020-08-21 12:21:51 UTC" "2020-08-21 12:37:24 UTC"
#[5] "2020-08-23 21:37:55 UTC"
#logout
#[1] "2020-08-16 10:56:29 UTC" "2020-08-21 09:14:52 UTC"
#[3] "2020-08-21 12:35:48 UTC" "2020-08-21 13:17:22 UTC"
#[5] "2020-08-23 22:08:47 UTC"

# Calculate the difference between login and logout: time_online
time_online <- logout - login

# Inspect the variable time_online
time_online

# Calculate the total time online
sum(time_online)

# Calculate the average time online
mean(time_online)

#astro
#       spring        summer          fall        winter
#"20-Mar-2015" "25-Jun-2015" "23-Sep-2015" "22-Dec-2015"

#meteo
#           spring            summer              fall            winter
#    "March 1, 15"      "June 1, 15" "September 1, 15"  "December 1, 15"

# Convert astro to vector of Date objects: astro_dates
astro_dates <- as.Date(astro, format = "%d-%b-%Y")

# Convert meteo to vector of Date objects: meteo_dates
meteo_dates <- as.Date(meteo, format = "%B %d, %y")

# Calculate the maximum absolute difference between astro_dates and meteo_dates
max(abs(meteo_dates - astro_dates))

