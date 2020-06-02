# R Learning Script 1
# 
# Pat Seed
# 
# June 1, 2020
# 
# 

# Goals:
# 1) Examine the R studio environment
# 2) Install some packages
# 3) Obtain data from a file or a web source
# 4) Examine the data
# 5) Plot data
# 
# 


# First look at the environment
# - Browse the files explorer
# - See what is under "More"
# - Run this little script and then look at Plots

library(ggplot2)
data("iris")
ggplot(iris, aes(Sepal.Length, Sepal.Width))+
  geom_point()

# - Look at the Packages tab 
# -- Click on the name of a package. What do you see? Go down another level in a link
# Let's install a package and then find it in this tab
# 

install.packages("ggplot2")

# Now go to the Packages tab and find ggplot2
# Click on ggplot2 and then the first item aes
# What if you want to get this help page without going through these clicks
# Try entering the following in the console

? aes


# Get some data using two ways: 1) Get it from a file and 2) Get it from a web link

read.csv("./Data/Cell ASD.csv")

# How do we 'keep' the data for reuse? We put it into a variable

cell_data<-read.csv("./Data/Cell ASD.csv")

# How do we see what the data look like in the variable cell_data?

head(cell_data)

# What about a little more?

head(cell_data, n=15)

# How about examing the 'bottom' of the set

tail(cell_data)

# R Studio has another neat trick
# Try typing this in the console

View(cell_data)

# We got those data from a locally stored file
# What about data in a table on a link?

web_data<-read.csv("https://data.mendeley.com/datasets/ngzmj4zkms/1/files/fb7927df-a1ea-4257-bf2f-33fecc4090e9/Fig1EFGH_subset8.csv?dl=1")

# install the package Beeswarm

install.packages("beeswarm")

library(beeswarm)

# What are the data columns to plot?

colnames(cell_data)

# or 

names(cell_data)

beeswarm(OFT_velocity~ASD_diagnosis, cell_data)
