install.packages("ggplot2")
library(ggplot2)

install.packages("shinythemes")

install.packages("plotly")

install.packages("plotly")
library(plotly)

install.packages("dplyr")
library(dplyr)


read.csv("./taylor_swift_spotify_clean.csv")
taylor_swift_data <- read.csv("./taylor_swift_spotify_clean.csv")


head(taylor_swift_data)


# Check the structure of the data
str(taylor_swift_data)


# Convert 'release_date' column to Date object
taylor_swift_data$release_date <- as.Date(taylor_swift_data$release_date, format = "%m/%d/%Y")








