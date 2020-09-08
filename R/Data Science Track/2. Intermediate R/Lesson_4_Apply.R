# Title     : TODO
# Objective : TODO
# Created by: ruben
# Created on: 08/09/2020

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

