# Riikka Holopainen 12.11.2022 Data wrangling exercise, data source: UCI Machine Learning Repository, Student Performance Data (incl. Alcohol consumption) page https://archive.ics.uci.edu/ml/datasets/Student+Performance

library(tidyverse)
student_mat <- read.csv("data/student-mat.csv", sep = ";", header = TRUE)
student_por <- read.csv("data/student-por.csv", sep = ";", header = TRUE)

dim(student_mat)
str(student_mat)
summary(student_mat)

dim(student_por)
str(student_por)
summary(student_mat)