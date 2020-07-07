# CHALLENGE: Plot the COVID-19 cases and deaths by   
# 
library(tidyverse)
library(tibbletime)

curl::curl_download("https://covid19-lake.s3.us-east-2.amazonaws.com/enigma-nytimes-data-in-usa/csv/us_states/us_states.csv", "Data/us_covid.csv")

midwest_states<- c("Illinois", "Indiana", 
                   "Iowa", "Kansas", 
                   "Michigan", "Minnesota",
                   "Missouri", "Nebraska", 
                   "North Dakota", "Ohio", 
                   "South Dakota", "Wisconsin")

read_csv("Data/us_covid.csv") %>% 
  as_tbl_time(date) %>%
  filter(date>=as.Date("2020-04-01") & 
           date<=as.Date("2020-04-30") & 
           state %in% midwest_states) %>%
  select(-fips) %>%
  pivot_longer(cols = c("cases", "deaths"), names_to= c("type")) %>%
  dplyr::group_by(state) %>%
  ggplot(aes(date, value, group=state))+
    geom_line(aes(color=state))+
    geom_point(aes(shape=type), size=0.5, alpha=0.7) +
    facet_wrap(~type, scales="free_y")+
    theme_classic() +
    theme(axis.text.x = element_text(angle = 90, hjust=1, vjust=0.5))+
    xlab("Date")+
    ylab("Count")

