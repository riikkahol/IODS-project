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

# Riikka Holopainen 2.12.2022 Assignment 5: Data wrangling exercise. Data source: https://hdr.undp.org/data-center/human-development-index#/indicies/HDI, technical notes: https://hdr.undp.org/system/files/documents//technical-notes-calculating-human-development-indices.pdf

# Exploring the srtucture and the dimensions of the data
str(human)
dim (human)

# There are 195 rows and 19 columns in the dataset (19 variables)

# Describing the dataset
# The 'human' dataset originates from the United Nations Development Programme. The data combines different kind of health, knowledge and empowerment -related indicators from most countries. The original names of the variables have been shortened for this purpose. 
#"GNI" = Gross National Income per capita, "Life.Exp" = Life expectancy at birth, "Edu.Exp" = Expected years of schooling, "Mat.Mor" = Maternal mortality ratio, "Ado.Birth" = Adolescent birth rate, "Parli.F" = Percetange of female representatives in parliament, "Edu2.F" = Proportion of females with at least secondary education"Edu2.M" = Proportion of males with at least secondary education,"Labo.F" = Proportion of females in the labour force"Labo.M" " Proportion of males in the labour force, "Edu2.FM" = Edu2.F / Edu2.M, "Labo.FM" = Labo2.F / Labo2.M

# 1.  Mutating the data: 
library(stringr)
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric

# 2. Excluding unecessary variables
library(dplyr)
# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))


# 3. Removing all rows with missing values
human_ <- filter(human, complete.cases(human)) 
human_


# 4. Removing observations which relate to regions
tail(human_, 10)
#last 7 observations relate to regions so removing them
last <- nrow(human_) - 7

# choose everything until the last 7 observations
human_ <- human_[1:last,] %>% as.data.frame()
human_

# Defining the row names by country names and removing country name column from the data

rownames(human_) <- human_$Country
human_ <- select(human_, -Country)
human_

# 155 observations and 8 variables 

# Saving the data including the row names

write.table(file = "Data/human.csv", human_, sep = ",", row.names = T)

test <- read.table("Data/human.csv", sep = ",", row.names = T)
str(test)
# It works!