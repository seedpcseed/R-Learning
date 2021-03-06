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
library(reshape)
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

mtcars.cars %>% select(Cars, mpg, gear) %>% melt(id.vars="Cars")

# and of course we can add more 'shaping' to the frame like sorting  by 
# car name

mtcars.cars %>% 
  melt(id.vars="Cars", measure.vars=c("mpg", "gear")) %>%
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

mtcars_melt %>% 
  filter(variable %in% c("mpg", "gear")) %>%
  ggplot(aes(variable, value)) +
  geom_point() +
  facet_wrap(~Cars, scales = "free_y") +
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=0.5))

mtcars_melt %>% 
  filter(variable %in% c("mpg", "gear")) %>%
  ggplot(aes(variable, value)) +
  geom_point() +
  facet_wrap(~Cars) +
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=0.5))

# recast the melted data

recast(mtcars_melt, Cars~variable)

recast(mtcars_melt, Cars~value) # doesn't make sense

recast(mtcars_melt, variable~Cars) #our original data.frame transposed


# the tidyr way
mtcars.cars %>% 
  tidyr::pivot_longer(cols=mpg:carb, names_to = "Factor", values_to = "Value")

billboard %>%
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    values_to = "rank",
    values_drop_na = TRUE
  )

anscombe %>%
  pivot_longer(everything(),
               names_to = c(".value", "set"),
               names_pattern = "(.)(.)"
  ) %>%
  arrange(set)

pnl <- tibble(
  x = 1:4,
  a = c(1, 1,0, 0),
  b = c(0, 1, 1, 1),
  y1 = rnorm(4),
  y2 = rnorm(4),
  z1 = rep(3, 4),
  z2 = rep(-2, 4),
)

pnl %>%
  pivot_longer(
    -c(x, a, b),
    names_to = c(".value", "time"),
    names_pattern = "(.)(.)"
  )

who %>% pivot_longer(
  cols = new_sp_m014:newrel_f65,
  names_to = c("diagnosis", "gender", "age"),
  names_pattern = "new_?(.*)_(.)(.*)",
  values_to = "count"
)

library(dcldata)
example_eagle_nests %>% 
  pivot_longer(
    cols = c(`2007`, `2009`), 
    names_to = "year", 
    values_to = "num_nests"
  )
