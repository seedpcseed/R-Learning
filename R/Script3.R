# Lesson 3: reshaping data 

# From Hadley Wichkam's "Reshaping data with the reshape package"
# 
# Data often has multiple levels of grouping (nested treatments, split plot designs, or 
# repeated measurements) and typically requires investigation at multiple levels. For 
# example, from a long term clinical study we may be interested in investigating 
# relationships over time, or between times or patients or treatments. 
# Performing these investigation s fluently requires the data to be reshaped
# in different ways, but most software packages make it difficult 
# to generalise these tasks and code
# needs to be written for each specific case.

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

# why go wide to long?  take a plot example
# if we want to plot a simple X by y we might be able to 
# use our only slightly modified data frame mtcars.cars

ggplot(mtcars.cars, aes(Cars, mpg)) +
  geom_point() +
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=0.5))

# but what if we want to look at a few factors by car type

mpg.p<- ggplot(mtcars.cars, aes(Cars, mpg)) +
  geom_point() +
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=0.5))

gear.p<- ggplot(mtcars.cars, aes(Cars, gear)) +
  geom_point() +
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=0.5))

cowplot::plot_grid(mpg.p, gear.p, nrow=1)

# Not the best visualization
# lets go to our 'melted' version

ggplot(mtcars_melt, aes(variable, value)) +
  geom_point() +
  facet_wrap(~Cars) +
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=0.5))

# this helps but is busy AND the scales of the data are different

ggplot(mtcars_melt, aes(variable, value)) +
  geom_point() +
  scale_y_log10()+
  facet_wrap(~Cars) +
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=0.5))

# maybe we just want some of the data and to flip them around

mtcars_melt %>% 
  filter(variable %in% c("mpg", "gear")) %>%
  ggplot(aes(Cars, value)) +
    geom_point() +
    facet_wrap(~variable, scales = "free_y") +
    theme(axis.text.x = element_text(angle=90, hjust=1, vjust=0.5))

# cast the melted data
# cast(data, formula, function)

