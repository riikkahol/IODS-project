# Riikka Holopainen 19.11.2022 Assignment 3: Data wrangling exercise. Data source P. Cortez and A. Silva. Using Data Mining to Predict Secondary School Student Performance. In A. Brito and J. Teixeira Eds., Proceedings of 5th FUture BUsiness TEChnology Conference (FUBUTEC 2008) pp. 5-12, Porto, Portugal, April, 2008, EUROSIS, ISBN 978-9077381-39-7.https://archive.ics.uci.edu/ml/datasets/Student+Performance


library(tidyverse)
library(dplyr)
library(ggplot2)
library(readr)

# 3. Setting working directory. Reading student-mat and student-por into R and exploring the structure
setwd("C:/Users/riikk/Documents/Open data science/IODS-project/Data")

student_mat <- read.table("student-mat.csv", sep = ";", header=TRUE)
student_por <- read.table("student-por.csv", sep = ";", header=TRUE)

dim(student_mat)
#396 rows and 33 columns
str(student_mat)
# 396 obs. of  33 variables
dim(student_por)
#650  rows and 33 columns
str(student_por)
# 650 obs. of  33 variables

# 4. Joining the data sets

free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")
join_cols <- setdiff(colnames(student_por), free_cols)
math_por <- inner_join(student_mat, student_por, by = join_cols, suffix = c(".math", ".por"))
glimpse(math_por)
dim(math_por)
str(math_por)
# 370 rows  39 columns 

# 5. Getting rid of duplicates

colnames(math_por)

alc <- select(math_por, all_of(join_cols))

colnames(free_cols)

for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

# glimpse at the new combined data
glimpse (alc)
# 370 rows and 33 columns left

# 6. Taking the average of the answers and creating new logical column 

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)

# 7. glimpse at the data
glimpse(alc)

write_csv(alc, "alc.csv")

