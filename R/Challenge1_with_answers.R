# CHALLENGE: Plot the COVID-19 cases and deaths by
#
library(tidyverse)

curl::curl_download("https://covid19-lake.s3.us-east-2.amazonaws.com/enigma-nytimes-data-in-usa/csv/us_states/us_states.csv", "Data/us_covid.csv")

midwest_states<- c("Illinois", "Indiana",
                   "Iowa", "Kansas",
                   "Michigan", "Minnesota",
                   "Missouri", "Nebraska",
                   "North Dakota", "Ohio",
                   "South Dakota", "Wisconsin")

read.csv("Data/us_covid.csv") %>%
  filter(date >= "2020-04-01" & date <= "2020-04-31" & state %in% midwest_states) %>%
  mutate(date=as.Date(date)) %>%
  select(-fips) %>%
  pivot_longer(cols = c("cases", "deaths"), names_to= c("type"))

library(ggthemes)
ggplot(df, aes(date, value, group=state))+
    geom_line()+
    geom_point(aes(shape=type, color=state), alpha=0.5) +
    scale_color_hue() +
    facet_wrap(~type, scales="free_y")+
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, hjust=1, vjust=0.5))
