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

# Here is a classic way




