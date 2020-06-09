# R- Learning Script 2
# June 5, 2020
# P. Seed

# Here we will do a little review of the steps in Script 1 session
# We will then go beyond this to talk about 
# Examining data.frames and matricies
# Filtering and selecting parts 
# Using basic piping


#First a review
#We have data in the 'Data' folder called mtcars.csv
#Based on the extension, how do you expect the data to be written in the file?
#How could you pull the data into R Studio to work with it?

read.csv("./Data/mtcars.csv")

#Ooops. That just put the data into the console. How
#do we put it into a variable like 'df'? 

df<- read.csv("./Data/mtcars.csv")

#Did you use tab complete to get any of the information into
#your code?

#Get a datatable to play with and push around
#So it turns out that mtcars is 'built in' data 
#in R and you can get it this way

data(mtcars)

#How do we get a quick look at it?

head(mtcars)

# Let's first look at what the objective class is

class(mtcars)

# Now assign this to a new variable

df<- mtcars  #This will keep the original complete

head(df) # Look like mtcars?

class(df) # As expected the new variable takes on the class of the data assigned to it.

# look at the dimensions of the dataframe

nrow(df)

ncol(df)

# There is a way to get the dimensions in one command

dim(df)  # this is showing the rows and columns

# Remember how to get the column names? Rownames?

colnames(df)

rownames(df)

# Now let's select just parts of the dataframe.
# There are many ways in R to do this

# Here is a classic way if you know the columns and rows you want by numeric positions


# Here is a way using the names of columns you want


# These ways are OK but there are newer methods that are easier to read
# and make for a little more throughput

# first you will need a couple packages
# Rather than getting them individually we can get them as a group 
# In what is called "tidyverse". This will give more than you need right now
# But you'll use much of the subpackages in the future!

install.packages("tidyverse")

library(tidyverse)

# this is taking our dataframe and sending it to View()
# this is a little silly

# Let's try to get just a few columns of data

colnames(df)

# dataframe[rows, columns]

df[ , c('mpg', 'cyl')]

# Here we are indicating columns we want 
# df[rows,columns]

df[ , c(1,2)]

df[1:5, 1:5]

df[c(1,3,5), c(1,5,9)]

# Now you have many tools to read and write data, to filter and sort data, 
# and do something called piping.  Off to put it to work!

# first let's work on some basic pipes
# pipes take one action/step and send parts to the next step directly
# Here is an example

df %>% View()


#let's try to a more 'modern' approach

df %>% 
  select(cyl, mpg)

# what about selecting parts of the table values and range
# first let's look at one column we do this as df$NAME

df$mpg # rstudio should help you with a list of columns

range(df$mpg)

quantile(df$mpg)

df %>%
  select(mpg, cyl) %>%
  range()

# so what if we just want the data table 
# where mpg is greater that the 50%ile

df2<-df %>% filter(mpg>19.2)

head(df2)

df$mpg
df2$mpg

df3<- df %>% filter(mpg>19.2 & mpg<22.8)

df3.1<- df %>% filter(mpg>19.2 & cyl>4)

df4<- df %>% filter(mpg<19.2 | mpg>22.8)

# you can use a lot of other comparisons like >= or <=

df5<- df %>% filter(cyl!=4)

# what about sorting a table 

df %>% arrange(mpg) # what do you notice?

df %>% arrange(desc(mpg))

df %>% arrange(mpg, cyl)

df6<- df %>% arrange(desc(mpg))

# maybe we want to get a summary of some information about df

df %>% 
  group_by(cyl) %>%
  summarise(
  N.cyl=n(),
  Mean.mpg=mean(mpg),
  Sum.mpg=sum(mpg)
  )

var <- "mass" # this is one of the column names for the dataset 'starwars'
head(starwars) #see?

summarise(starwars, avg = mean(.data[[var]], na.rm = TRUE))

starwars %>% 
  group_by(hair_color) %>%
  summarise(
    N.hc=n(),
    mean.mass=mean(mass, na.rm = TRUE)
  )

starwars %>%
  filter(eye_color=="blue")

starwars %>%
  filter(eye_color!="blue")

table(starwars$homeworld)

hw<- starwars %>%
  group_by(homeworld) %>%
  summarise(
    N=n()
  )

