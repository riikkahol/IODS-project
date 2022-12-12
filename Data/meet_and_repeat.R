# Riikka Holopainen 11.11.2022 Assignment 6: Data wrangling exercise. Data source: https://github.com/KimmoVehkalahti/MABS

library(dplyr); library(tidyr); library(ggplot2); library(tidyverse)

# 1. Loading the data sets (BPRS and RATS) into R and saving the files in data folder

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep ="\t", header = T)

setwd("C:/Users/riikk/Documents/Open data science/IODS-project/Data")
write_csv(BPRS, "BPRS.csv")
write.csv(RATS, "RATS.csv")

# Checking the names of the variables, viewing the contents of the data, looking at the structure of the data and summaries

names(BPRS)
str(BPRS)
glimpse(BPRS)
summary(BPRS)

names(RATS)
str(RATS)
glimpse(RATS)
summary(RATS)

# 2. Converting the categorical variables of both data sets to factors.
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


# 3. Converting the data sets to long form. Adding a week variable to BPRS and a Time variable to RATS.

BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) %>% mutate(week = as.integer(substr(weeks,5,5)))

RATSL <- pivot_longer(RATS, cols=-c(ID,Group), names_to = "WD",values_to = "Weight")  %>%  mutate(Time = as.integer(substr(WD,3,4))) %>% arrange(Time)


# 4. Taking a look at the new data sets and comparing them with their wide form versions

names(BPRSL)
str(BPRSL)
glimpse(BPRSL)
summary(BPRSL)

names(RATSL)
str(RATSL)
glimpse(RATSL)
summary(RATSL)

