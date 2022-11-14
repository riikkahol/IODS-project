library(tidyverse)
setwd("C:/Users/riikk/Documents/Open data science/IODS-project/Data")
students2014 <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/learning2014.txt",
                           sep = ",", header = TRUE)
dim(students2014)
str(students2014)
summary(students2014)
             
keep_columns <- c("gender","age","attitude", "deep", "stra", "surf", "points")
students2014 <- select(students2014, one_of(keep_columns))

library(GGally)
library(ggplot2)
p <- ggpairs(students2014, mapping = aes(col = gender), lower = list(combo = wrap("facethist", bins = 20)))
