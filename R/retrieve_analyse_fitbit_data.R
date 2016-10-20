### Analyze Fitbit data


## Libraries
library("fitbitScraper")       # Retrieving data from Fitbit website
library("ggplot2")             # Plotting


## Settings & preparations
setwd("~/git/fitbit")
pw_file <- "./data/pw.txt"
myemailadres <- "dljvandenberg@gmail.com"
mypassword <- readLines(pw_file)

# Login to Fitbit website
cookie <- login(email=emailadres, password=mypassword)


## Retrieve Data

# Options: "steps", "distance", "floors", "active-minutes", "calories-burned", "heart-rate"
df_steps <- get_intraday_data(cookie, what="steps", date="2016-10-16")
df_steps_daily <- get_daily_data(cookie, what="steps", start_date="2016-10-15", end_date="2016-10-20")
df_heartrate <- get_intraday_data(cookie, what="heart-rate", date="2016-10-16")



## Visualizations

# Steps
ggplot(df_steps) + geom_bar(aes(x=time, y=steps, fill=steps), stat="identity") +
  xlab("") +ylab("steps") +
  theme(axis.ticks.x=element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.background=element_blank(),
        panel.grid.major.y=element_line(colour="gray", size=.1),
        legend.position="none")

# Heartrate
ggplot(df_heartrate) + geom_line(aes(x=time, y=bpm), stat="identity") +
  xlab("") +ylab("bpm") +
  theme(axis.ticks.x=element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.background=element_blank(),
        panel.grid.major.y=element_line(colour="gray", size=.1),
        legend.position="none")

# Heartrate histogram
ggplot(df_heartrate, aes(x=bpm)) + geom_histogram()

# Summary statistics
summary(df_heartrate)
