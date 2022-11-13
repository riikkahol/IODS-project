# Riikka Holopainen 13.11.2022 This is  data analysis exercise from assignment 2, performing and interpreting regression analysis

# reading the raw data and exploring it.  
library(tidyverse)
setwd("C:/Users/riikk/Documents/Open data science/IODS-project/Data")
#students2014 = read_csv("learning2014.csv")
students2014 <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/learning2014.txt",
                           sep = ",", header = T)
dim(students2014)
str(students2014)
# add here description of the dataset

summary(students2014)

library(GGally)
library(ggplot2)

p <- ggpairs(students2014, mapping = aes(col = gender), lower = list(combo = wrap("facethist", bins = 20)))

# less male participants, participating women ar a bit younger, women seem to have worse attitudes, attitudes does not seem to be normally distributed
my_model <- lm(points ~ attitude + stra + surf, data = students2014)
#par(mfrow = c(2,2)) 
par(mar=c(1,1,1,1))
plot (my_model, which = c(1,2,5))
summary(my_model)
#Coefficients:
# Estimate Std. Error t value Pr(>|t|)    
#(Intercept)  11.0171     3.6837   2.991  0.00322 ** 
# attitude      3.3952     0.5741   5.913 1.93e-08 ***
#  stra          0.8531     0.5416   1.575  0.11716    
#surf         -0.5861     0.8014  -0.731  0.46563    
#---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
my_model <- lm(points ~ attitude, data = students2014)
summary(my_model)
plot (my_model, which = c(1,2,5))
