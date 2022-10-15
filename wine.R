getwd()
setwd("your working drive")

install.packages("readr")
install.packages("dplyr")
install.packages("tidyr")
install.packages("ggplot2")
install.packages('corrplot')
install.packages("readxl")

library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(corrplot)
library(readxl)

# PART 1 - Using Example dataset y
y <- read_excel("y.xlsx", 1) 
y <- y[1:11,]

# OPTION 1
y$rose <- grepl("rose", y$description)
y$rose_f <- grepl("rose", y$description, fixed = TRUE)

y$lavender <- grepl("lavender", y$description)
y$lavender_f <- grepl("lavender", y$description, fixed = TRUE)

y$honeysuckle <- grepl("honeysuckle", y$description)
y$honeysuckle_f <- grepl("honeysuckle", y$description, fixed = TRUE)

y$flower <- y$rose | y$lavender | y$honeysuckle

# OPTION 2
y$flower2 <- grepl("rose|lavender|honeysuckle", y$description)
y$flower_f <- grepl("rose|lavender|honeysuckle", y$description, fixed= TRUE)



# PART 2 - using wine dataset

#Read data and fill in NA
wine1 <- read_csv("winemag-data_first150k.csv", na = c("", "NA", "UNKNOWN"))
glimpse(wine1)

# Create Choc variable (2 words)

# Choc Using OPTION 1
wine1$chocolate <- grepl("chocolate", wine1$description, fixed =TRUE)
wine1$mocha <- grepl("mocha", wine1$description, fixed = TRUE)
wine1$choc <- wine1$chocolate | wine1$mocha

# Choc Using OPTION 2
wine1$choc2 <- grepl("chocolate|mocha", wine1$description)

# Choc test choc vs choc2
wine1$choc == wine1$choc2 #for each row, if choc equals choc2, then result will be 1 (TRUE) 
sum(wine1$choc == wine1$choc2) #if both equals each other,then sum will be total records 


# Create Flower variable (3 words)

# Flower Using OPTION 1
wine1$rose <- grepl("rose", wine1$description, fixed = TRUE)
wine1$lavender <- grepl("lavender", wine1$description, fixed = TRUE)
wine1$honeysuckle <- grepl("honeysuckle", wine1$description, fixed = TRUE)
wine1$flower <- wine1$rose | wine1$lavender | wine1$honeysuckle

# Flower Using OPTION 2
wine1$flower2 <- grepl("rose|lavender|honeysuckle", wine1$description)

# Flower test flower vs flower2
wine1$flower == wine1$flower2
sum(wine1$flower == wine1$flower2)


# Create other variables using OPTION 2

# Create berry, Citrus, Coffee, Herb, Melon, Mint, Nut, Spice, Stonefruit, Tobacco variables
wine1$berry <- grepl("berry|cherry|strawberry|blackberry|blueberry|cranberry|raspberry", wine1$description)
wine1$citrus <- grepl("citrus|orange|lemon|grapefruit|acid|tangerine|lime", wine1$description)
wine1$coffee <- grepl("coffee|expresso", wine1$description)
wine1$herb <- grepl("herb|sage|rosemary|cedar|juniper", wine1$description)
wine1$melon <- grepl("melon|watermelon", wine1$description)
wine1$mint <- grepl("mint|menthol", wine1$description)
wine1$nut <- grepl("nut|almond|hazelnut|walnut", wine1$description)
wine1$spice <- grepl("spice|cinnamon|pepper|anise|clove", wine1$description)
wine1$stonefruit <- grepl("stone|peach|plum|stonefruit", wine1$description)
wine1$tobacco <- grepl("tobacco|leather|rustic", wine1$description)

# Remove unwanted columns
wine1 <- wine1 %>% select(-chocolate, -mocha, -choc2, -rose, -honeysuckle, -lavender, -flower2)

# Export dataset into Excel if needed
write.csv(wine1, 'wine_new.csv')
