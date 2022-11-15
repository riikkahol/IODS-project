# Riikka Holopainen 12.11.2022 Data wrangling exercise, data source: UCI Machine Learning Repository, Student Performance Data (incl. Alcohol consumption) page https://archive.ics.uci.edu/ml/datasets/Student+Performance

library(tidyverse)
student_mat <- read.csv("data/student-mat.csv")
student_por <- read.csv("data/student-por.csv")

dim(student_mat)
dim(student_por)
str(student_mat)
str(student_por)