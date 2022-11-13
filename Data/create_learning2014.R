# Riikka Holopainen 12.11.2022 Data wrangling exercise source http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt


# Data Wrangling Exercise 2 
# I have explored the data, dimensions: 183 64,  structure: 183 obs. of  64 variables:

library(tidyverse)
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
dim(lrn14)
str(lrn14)

# Data Wrangling exercise 3 I hope I understood what I need to do, at least I ended up with 166 observations and 7 variables

library(dplyr)
lrn14$attitude <- lrn14$Attitude / 10
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
lrn14$deep <- rowMeans(lrn14[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
lrn14$stra <- rowMeans(lrn14[, strategic_questions])

keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))
learning2014 <- filter(learning2014, Points > 0)

learning2014


