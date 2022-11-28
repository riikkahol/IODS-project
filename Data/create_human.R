# Riikka Holopainen 25.11.2022 Assignment 4: Data wrangling exercise. Data source: https://hdr.undp.org/data-center/human-development-index#/indicies/HDI, technical notes: https://hdr.undp.org/system/files/documents//technical-notes-calculating-human-development-indices.pdf

library(tidyverse)
library(dplyr)
library(readr)

# 2. Reading in the “Human development” and “Gender inequality” data sets
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv", col_types = "icddddni")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# 3. Exploring the datasets
str(hd)
dim(hd)

# hd dataset has 195 rows and 8 columns, which means 8 variables with very long names
str(gii)
dim(gii)
# gii dataset has 195 rows and 10 columns, - 10 variables. Expect varible country these are different variables from the other dataset

summary(hd)
summary(gii)

# There seems to be some missing values in many variables, 

# 4. Renaming the variables
names(hd) <- c("HDI.Rank","Country","HDI","Life.Exp","Edu.Exp","Edu.Mean","GNI","GNI.Minus.Rank")
names(gii) <- c("GII.Rank","Country","GII","Mat.Mor","Ado.Birth","Parli.F","Edu2.F","Edu2.M","Labo.F","Labo.M")


# 5. Mutating the “Gender inequality” data and creating two new variables. 
gii <- mutate(gii, Edu2.FM = Edu2.F / Edu2.M)
gii <- mutate(gii, Labo.FM = Labo.F / Labo.M)

glimpse(hd)
glimpse(gii)

# 6. Joining together the two datasets
human <- inner_join(hd, gii, by = "Country")

# joined data should have 195 observations and 19 variables
dim(human)

#saving the joined data
write_csv(human, "Data/human.csv")


  
