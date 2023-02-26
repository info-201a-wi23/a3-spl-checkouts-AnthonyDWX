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
#spl_df <- read.csv("C:/XXX/XXX/2017-2023-10-Checkouts-SPL-Data.csv")
spl_df <- read.csv("C:/Users/14221/Desktop/2017-2023-10-Checkouts-SPL-Data.csv/2017-2023-10-Checkouts-SPL-Data.csv")

#Proceed Csv
spl_df <- spl_df %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth,  "-01" ))
spl_df$date <- as.Date(spl_df$date, format = "%Y-%m-%d")

#Proceed P2 Data
data_AUDIOBOOK <- spl_df %>% 
  select(MaterialType, Checkouts, date) %>%
  filter(str_detect(MaterialType, "AUDIOBOOK")) %>%
  group_by(date) %>%
  summarize(Checkouts = sum(Checkouts, na.rm = TRUE))
data_AUDIOBOOK <- data_AUDIOBOOK %>%
  mutate(MaterialType = "AUDIOBOOK")

data_EBOOK <- spl_df %>% 
  select(MaterialType, Checkouts, date) %>%
  filter(str_detect(MaterialType, "EBOOK")) %>%
  group_by(date) %>%
  summarize(Checkouts = sum(Checkouts, na.rm = TRUE))
data_EBOOK <- data_EBOOK %>%
  mutate(MaterialType = "EBOOK")

data_MaterialType <- rbind(data_AUDIOBOOK, data_EBOOK)

# Plot p2
p2 <- ggplot(data_MaterialType) +
  geom_line(aes(x = date, y = Checkouts, color = MaterialType)) + 
  theme_ipsum() + 
  scale_y_continuous(labels = comma) +
  guides(color = guide_legend(title = 'Book type')) +
  ggtitle("Trend of checked out books type over years")
