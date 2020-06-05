# R- Learning Script 2
# June 5, 2020
# P. Seed

# Here we will do a little review of the steps in Script 1 session
# We will then go beyond this to talk about 
# Examining data.frames and matricies
# Filtering and selecting parts 
# Using basic piping

#Get a datatable to play with and push around

data(mtcars)

head(mtcars)

# Let's first look at what the objective class is

class(mtcars)

# Now assign this to a new variable

df<- mtcars  #This will keep the original complete

head(df) # Look like mtcars?

class(df) # As expected the new variable takes on the class of the data assigned to it.

# look at the dimensions of the dataframe

nrows(df)

ncols(df)

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

# Now you have many tools to read and write data, to filter and sort data, 
# and do something called piping.  Off to put it to work!

# first let's work on some basic pipes
# pipes take one action/step and send parts to the next step directly
# Here is an example

df %>% View()

# this is taking our dataframe and sending it to View()




