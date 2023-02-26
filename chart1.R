# Load libraries 
library(scales)
library(ggrepel)
library(maps)
library(mapproj)
library(dplyr)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(knitr)
library(gridExtra)
library(stringr)
library(readxl)
library(forcats)

#Load csv
spl_df <- read.csv("C:/XXX/XXX/2017-2023-10-Checkouts-SPL-Data.csv")

#Proceed Csv
spl_df <- spl_df %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth,  "-01" ))
spl_df$date <- as.Date(spl_df$date, format = "%Y-%m-%d")

#Proceed P1 Data
data_physical <- spl_df %>% 
  select(UsageClass, Checkouts, date) %>%
  filter(str_detect(UsageClass, "Physical")) %>%
  group_by(date) %>%
  summarize(Checkouts = sum(Checkouts, na.rm = TRUE))
data_physical <- data_physical %>%
  mutate(UsageClass = "Physical")

data_digital <- spl_df %>% 
  select(UsageClass, Checkouts, date) %>%
  filter(str_detect(UsageClass, "Digital")) %>%
  group_by(date) %>%
  summarize(Checkouts = sum(Checkouts, na.rm = TRUE))
data_digital <- data_digital %>%
  mutate(UsageClass = "Digital")
  
data_UsageClass <- rbind(data_physical, data_digital)

# Plot p1
p1 <- ggplot(data_UsageClass) +
  geom_line(aes(x = date, y = Checkouts, color = UsageClass)) + 
  theme_ipsum() +
  guides(color = guide_legend(title = 'Item type')) +
  ggtitle("Trend of checked out items type over years")
