# Title     : A/B Testing in R
# Objective : Learn a beginning to end A/B Testing experiment
# Created by: ruben
# Created on: 29/07/2020

# LESSON 1
# Load tidyverse
library(tidyverse)
library(lubridate)
library(scales)
library(powerMediation)

# Read in data
click_data <- read_csv("C:/Users/ruben/PycharmProjects/datacamp/R/A-B Testing/click_data.csv")
click_data

# Find oldest and most recent date
min(click_data$visit_date)
max(click_data$visit_date)

# Calculate the mean conversion rate by day of the week
click_data %>%
  group_by(wday(visit_date)) %>%
  summarize(conversion_rate = mean(clicked_adopt_today))

# Calculate the mean conversion rate by week of the year
click_data %>%
  group_by(week(visit_date)) %>%
  summarize(conversion_rate = mean(clicked_adopt_today))

# Compute conversion rate by week of the year
click_data_sum <- click_data %>%
  group_by(week(visit_date)) %>%
  summarize(conversion_rate = mean(clicked_adopt_today))

# Build plot
ggplot(click_data_sum, aes(x = `week(visit_date)`,
                           y = conversion_rate)) +
  geom_point() +
  geom_line() +
  scale_y_continuous(limits = c(0, 1),
                     labels = percent) +
  labs(x = "Week",
       y = "Conversion Rate")

# Compute and look at sample size for experiment in August
total_sample_size <- SSizeLogisticBin(p1 = 0.54,
                                      p2 = 0.64,
                                      B = 0.5,
                                      alpha = 0.05,
                                      power = 0.8)
total_sample_size  # 758

# Compute and look at sample size for experiment in August with a 5 percentage point increase
total_sample_size <- SSizeLogisticBin(p1 = 0.54,
                                      p2 = 0.59,
                                      B = 0.5,
                                      alpha = 0.05,
                                      power = 0.8)
total_sample_size  # 3085


# LESSON 2
# Group and summarize data
experiment_data_clean_sum <- experiment_data_clean %>%
  group_by(condition, visit_date) %>%
  summarize(conversion_rate = mean(clicked_adopt_today))

# Make plot of conversion rates over time
ggplot(experiment_data_clean_sum,
       aes(x = visit_date,
           y = conversion_rate,
           color = condition,
           group = condition)) +
  geom_point() +
  geom_line()

# Load package for cleaning model results
library(broom)

# View summary of results
experiment_data_clean %>%
  group_by(condition) %>%
  summarize(conversion_rate = mean(clicked_adopt_today))

# Run logistic regression
experiment_results <- glm(clicked_adopt_today ~ condition,
                          family = "binomial",
                          data = experiment_data_clean) %>%
  tidy()
experiment_results

#           term  estimate std.error  statistic      p.value
#1   (Intercept) -1.613684 0.1597307 -10.102533 5.383364e-24
#2 conditiontest  1.149379 0.2007961   5.724108 1.039787e-08

# Load package for running power analysis
library(powerMediation)

# Run logistic regression power analysis
total_sample_size <- SSizeLogisticBin(p1 = 0.39,
                                      p2 = 0.59,
                                      B = 0.5,
                                      alpha = 0.05,
                                      power = 0.8)
total_sample_size  # 194


# Read in data for follow-up experiment
followup_experiment_data <- read_csv('followup_experiment_data.csv')

# View conversion rates by condition
followup_experiment_data %>%
  group_by(condition) %>%
  summarize(conversion_rate = mean(clicked_adopt_today))

# Run logistic regression
followup_experiment_results <- glm(clicked_adopt_today ~ condition,
                                   family = "binomial",
                                   data = followup_experiment_data) %>%
  tidy()
followup_experiment_results

#                 term  estimate std.error statistic      p.value
#1         (Intercept) 1.4790761 0.2611777  5.663103 1.486597e-08
#2 conditionkitten_hat 0.4786685 0.4041175  1.184479 2.362236e-01

# Compute monthly summary
eight_month_checkin_data_sum <- eight_month_checkin_data %>%
  mutate(month_text = month(visit_date, label = TRUE)) %>%
  group_by(month_text, condition) %>%
  summarize(conversion_rate = mean(clicked_adopt_today))

# Plot month-over-month results
ggplot(eight_month_checkin_data_sum,
       aes(x = month_text,
           y = conversion_rate,
           color = condition,
           group = condition)) +
  geom_point() +
  geom_line()

# Plot monthly summary
ggplot(eight_month_checkin_data_sum,
       aes(x = month_text,
           y = conversion_rate,
           color = condition,
           group = condition)) +
  geom_point() +
  geom_line() +
  scale_y_continuous(limits = c(0, 1),
                     labels = percent) +
  labs(x = "Month",
       y = "Conversion Rate")

# Plot monthly summary
ggplot(eight_month_checkin_data_sum,
       aes(x = month_text,
           y = conversion_rate,
           color = condition,
           group = condition)) +
  geom_point(size = 4) +
  geom_line(lwd = 1) +
  scale_y_continuous(limits = c(0, 1),
                     labels = percent) +
  labs(x = "Month",
       y = "Conversion Rate")


# Compute difference over time
no_hat_data_diff <- no_hat_data_sum %>%
  spread(year, conversion_rate) %>%
  mutate(year_diff = `2018` - `2017`)
no_hat_data_diff

# A tibble: 12 x 4
#   month `2017` `2018` year_diff
#   <ord>  <dbl>  <dbl>     <dbl>
# 1 Jan    0.177  0.165  -0.0129
# 2 Feb    0.168  0.225   0.0571
# 3 Mar    0.129  0.135   0.00645
# 4 Apr    0.143  0.137  -0.00667
# 5 May    0.252  0.268   0.0161
# 6 Jun    0.290  0.307   0.0167
# 7 Jul    0.390  0.345  -0.0452
# 8 Aug    0.506  0.581   0.0742
# 9 Sep    0.297 NA      NA
#10 Oct    0.2   NA      NA
#11 Nov    0.23  NA      NA
#12 Dec    0.445 NA      NA

# Compute summary statistics
mean(no_hat_data_diff$year_diff, na.rm = TRUE)  # 0.01323157
sd(no_hat_data_diff$year_diff, na.rm = TRUE)  # 0.03817146


# Load package for power analysis
library(powerMediation)

# Run power analysis for logistic regression
total_sample_size <- SSizeLogisticBin(p1 = 0.49,
                                      p2 = 0.64,
                                      B = 0.5,
                                      alpha = 0.05,
                                      power = 0.8)
total_sample_size  # 341

# Load package to clean up model outputs
library(broom)

# View summary of data
followup_experiment_data_sep %>%
  group_by(condition) %>%
  summarize(conversion_rate = mean(clicked_adopt_today))

# Run logistic regression
followup_experiment_sep_results <- glm(clicked_adopt_today ~ condition,
                                       family = "binomial",
                                       data = followup_experiment_data_sep) %>%
  tidy()
followup_experiment_sep_results

#                 term   estimate std.error  statistic     p.value
#1         (Intercept) -0.1288329 0.1532613 -0.8406096 0.400566704
#2 conditionkitten_hat  0.5931385 0.2194637  2.7026718 0.006878462

# Lesson 3
# Research questions
# Compute summary by month
viz_website_2017 %>%
  group_by(month(visit_date)) %>%
  summarize(article_conversion_rate = mean(clicked_article))

# Compute 'like' click summary by month
viz_website_2017_like_sum <- viz_website_2017 %>%
  mutate(month = month(visit_date, label = TRUE)) %>%
  group_by(month) %>%
  summarize(like_conversion_rate = mean(clicked_like))

# Plot 'like' click summary by month
ggplot(viz_website_2017_like_sum,
       aes(x = month, y = like_conversion_rate, group = 1)) +
  geom_point() +
  geom_line() +
  scale_y_continuous(limits = c(0, 1), labels= percent)


# Plot comparison of 'like'ing and 'sharing'ing an article
ggplot(viz_website_2017_like_share_sum,
       aes(x = month, y = conversion_rate, color = action, group = action)) +
  geom_point() +
  geom_line() +
  scale_y_continuous(limits = c(0,1), labels = percent)


# Compute conversion rates for A/A experiment
viz_website_2018_01_sum <- viz_website_2018_01 %>%
  group_by(condition) %>%
  summarize(like_conversion_rate = mean(clicked_like))

viz_website_2018_01_sum

# Plot conversion rates for two conditions
ggplot(viz_website_2018_01_sum,
       aes(x = condition, y = like_conversion_rate)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(limits = c(0, 1), labels = percent)

# Load library to clean up model outputs
library(broom)

# Run logistic regression
aa_experiment_results <- glm(clicked_like ~ condition,
                             family = "binomial",
                             data = viz_website_2018_01) %>%
  tidy()
aa_experiment_results

#         term    estimate  std.error   statistic   p.value
#1 (Intercept) -1.38025691 0.02004420 -68.8606672 0.0000000
#2 conditionA2 -0.02591398 0.02845802  -0.9106038 0.3625041


# Compute 'like' conversion rate by week and condition
viz_website_2018_02 %>%
  mutate(week = week(visit_date)) %>%
  group_by(week, condition) %>%
  summarize(like_conversion_rate = mean(clicked_like))

# Compute 'like' conversion rate by if article published and condition
viz_website_2018_02 %>%
  group_by(article_published, condition) %>%
  summarize(like_conversion_rate = mean(clicked_like))

# Plot 'like' conversion rates by date for experiment
ggplot(viz_website_2018_02_sum,
       aes(x = visit_date,
           y = like_conversion_rate,
           color = condition,
           linetype = article_published,
           group = interaction(condition, article_published))) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept = as.numeric(as.Date("2018-02-15"))) +
  scale_y_continuous(limits = c(0, 0.3), labels = percent)


# Side effects
# Compute 'like' conversion rate and mean pageload time by day
viz_website_2018_03_sum <- viz_website_2018_03 %>%
  group_by(visit_date, condition) %>%
  summarize(mean_pageload_time = mean(pageload_time),
            like_conversion_rate = mean(clicked_like))

# Plot effect of 'like' conversion rate by pageload time
ggplot(viz_website_2018_03_sum,
       aes(x = mean_pageload_time, y = like_conversion_rate, color = condition)) +
  geom_point()

# Plot 'like' conversion rate by day
ggplot(viz_website_2018_03_sum,
       aes(x = visit_date,
           y = like_conversion_rate,
           color = condition,
           linetype = pageload_delay_added,
           group = interaction(condition, pageload_delay_added))) +
  geom_point() +
  geom_line() +
  geom_vline(xintercept = as.numeric(as.Date("2018-03-15"))) +
  scale_y_continuous(limits = c(0, 0.3), labels = percent)


# Lesson 4
# Power analysis
# Load package to run power analysis
library(powerMediation)

# Run power analysis for logistic regression
total_sample_size <- SSizeLogisticBin(p1 = 0.17,
                                      p2 = 0.27,
                                      B = 0.5,
                                      alpha = 0.05,
                                      power = 0.8)
total_sample_size  # 537


# Load package to run power analysis
library(pwr)

# Run power analysis for t-test
sample_size <- pwr.t.test(d = 0.3,
                          sig.level = 0.05,
                          power = 0.8)
sample_size


#     Two-sample t test power calculation
#
#              n = 175.3847
#              d = 0.3
#      sig.level = 0.05
#          power = 0.8
#    alternative = two.sided
#
#NOTE: n is number in *each* group

# Load package to clean up model outputs
library(broom)

# Run logistic regression
ab_experiment_results <- glm(clicked_like ~ condition,
                             family = "binomial",
                             data = viz_website_2018_04) %>%
  tidy()
ab_experiment_results

#            term   estimate  std.error statistic       p.value
#1    (Intercept) -1.6123207 0.02192998 -73.52131  0.000000e+00
#2 conditiontools -0.9887948 0.03895874 -25.38057 4.133837e-142

# Run t-test
ab_experiment_results <- t.test(time_spent_homepage_sec ~ condition,
                                data = viz_website_2018_04)
ab_experiment_results


#	Welch Two Sample t-test
#
#data:  time_spent_homepage_sec by condition
#t = 0.36288, df = 29997, p-value = 0.7167
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
# -0.01850573  0.02691480
#sample estimates:
# mean in group tips mean in group tools
#           49.99909            49.99489

# Sequential Analysis
# Load package to run sequential analysis
library(gsDesign)

# Run sequential analysis
seq_analysis_3looks <- gsDesign(k = 3,
                               test.type = 1,
                               alpha = 0.05,
                               beta = 0.2,
                               sfu = "Pocock")
seq_analysis_3looks

#One-sided group sequential design with
#80 % power and 5 % Type I Error.
#           Sample
#            Size
#  Analysis Ratio*  Z   Nominal p  Spend
#         1  0.394 1.99    0.0232 0.0232
#         2  0.789 1.99    0.0232 0.0155
#         3  1.183 1.99    0.0232 0.0113
#     Total                       0.0500
#
#++ alpha spending:
# Pocock boundary.
#* Sample size ratio compared to fixed design with no interim
#
#Boundary crossing probabilities and expected sample size
#assume any cross stops the trial
#
#Upper boundary (power or Type I Error)
#          Analysis
#   Theta      1      2      3 Total   E{N}
#  0.0000 0.0232 0.0155 0.0113  0.05 1.1591
#  2.4865 0.3334 0.2875 0.1791  0.80 0.8070

# Load package to run sequential analysis
library(gsDesign)

# Run sequential analysis
seq_analysis_3looks <- gsDesign(k = 3,
                                test.type = 1,
                                alpha = 0.05,
                                beta = 0.2,
                                sfu = "Pocock")

# Fill in max number of points and compute points per group and find stopping points
max_n <- 3000
max_n_per_group <- max_n / 2
stopping_points <- max_n_per_group * seq_analysis_3looks$timing
stopping_points  # 500 1000 1500


# Multivariate testing

# Compute summary values for four conditions
viz_website_2018_05_sum <- viz_website_2018_05 %>%
  group_by(word_one, word_two) %>%
  summarize(mean_time_spent_homepage_sec = mean(time_spent_homepage_sec))

# Plot summary values for four conditions
ggplot(viz_website_2018_05_sum,
       aes(x = word_one,
           y = mean_time_spent_homepage_sec,
           fill = word_two)) +
  geom_bar(stat = "identity", position = "dodge")

# Compute summary values for four conditions
viz_website_2018_05_sum <- viz_website_2018_05 %>%
  group_by(word_one, word_two) %>%
  summarize(like_conversion_rate = mean(clicked_like))

# Plot summary values for four conditions
ggplot(viz_website_2018_05_sum,
       aes(x = word_one,
           y = like_conversion_rate,
           fill = word_two)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_y_continuous(limits = c(0, 1), labels = percent)


# Load package for cleaning model output
library(broom)

# Organize variables and run logistic regression
viz_website_2018_05_like_results <- viz_website_2018_05 %>%
  mutate(word_one = factor(word_one,
                           levels = c("tips", "tools"))) %>%
  mutate(word_two = factor(word_two,
                           levels = c("better", "amazing"))) %>%
  glm(clicked_like ~ word_one * word_two,
                                    family = "binomial",
                                    data = .) %>%
  tidy()
viz_website_2018_05_like_results

#                           term    estimate  std.error   statistic
#1                   (Intercept) -1.30558956 0.01961052 -66.5759940
#2                 word_onetools -0.79640382 0.03239365 -24.5851815
#3               word_twoamazing -0.01933586 0.02781111  -0.6952566
#4 word_onetools:word_twoamazing  1.77174758 0.04128273  42.9174069
#        p.value
#1  0.000000e+00
#2 1.819678e-133
#3  4.868945e-01
#4  0.000000e+00
