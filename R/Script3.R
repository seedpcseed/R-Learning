# Lesson 3: reshaping data 

# First we want to get some data
# 

data("mtcars")

# take a look at the data. You remember how

head(mtcars)

# or

View(mtcars)

# sometimes we want to 'rotate' the data or
# technically called transpose

mtcars_transposed<- t(mtcars)

head(mtcars_transposed)

# sometimes we want to reshape data 
# the mtcars dataframe is considered 'wide' 
# for instance in mtcars, each car has a number of characteristics that 
# are measured. Let's reshape the data to make a unique line by 
# car type | factor | measured value

library(tidyverse)
library(reshape2)

?melt.data.frame

# first if we want to make the 'id variable' the car names, we need a
# car name column

mtcars.cars<- data.frame(Cars=rownames(mtcars), mtcars)

mtcars_melt<- melt(mtcars.cars, id.vars = "Cars")

head(mtcars_melt)

# we can also use pipes as we have before

mtcars.cars %>% melt(id.vars="Cars")

# what if we do not want all the car measures to be in 
# our new melted data frame?
# 

mtcars.cars %>% melt(id.vars="Cars", measure.vars=c("mpg", "gear"))

# and of course we can add more 'shaping' to the frame like sorting  by 
# car name

mtcars.cars %>% melt(id.vars="Cars", measure.vars=c("mpg", "gear")) %>%
  arrange(Cars)
