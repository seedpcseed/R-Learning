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
# Say we want to make a new dataframe that only has the 'vs' column
# 

df[, 8] #vs is column 8; here we are defining parts of df we want ---> df[rows,columns]

# or

df[, 'vs']

# what if you want 'vs', 'am', 'wt' ?

df[ ,c(8,9,6)] # very clunky

df[, c('vs', 'am', 'wt')] #slightly better

# We can also specify rows we want

df[c(1,5,8),] # note that leaving NO condition in the place of columns after the comma means we want ALL the columns

#or we can get chunks

df[1:5, 1:3] # this states to subset rows 1 to 5 and columns 1 to 3

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
# Sort of a silly example because we can just type

View(df) #this gives us the same thing

# but want after selecting columns in df like we did before

df %>% select(vs, am, wt) # this is saying to start with df and select  the columns as named. Note the column names are not enclosed

# to select rows is a little different

df %>% slice(5) # this gives row 5

df %>% slice(1:5) #this gives rows 1:5

df %>% slice_head(n=5) # take 5 from the top

df %>% slice_tail(n=3) #take 3 from the bottom



