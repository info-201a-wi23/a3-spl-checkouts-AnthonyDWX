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

#Proceed P3 Data
data_2017 <- spl_df %>% 
  select(CheckoutYear) %>%
  filter(CheckoutYear == 2017)
data_2018 <- spl_df %>% 
  select(CheckoutYear) %>%
  filter(CheckoutYear == 2018)
data_2019 <- spl_df %>% 
  select(CheckoutYear) %>%
  filter(CheckoutYear == 2019)
data_2020 <- spl_df %>% 
  select(CheckoutYear) %>%
  filter(CheckoutYear == 2020)
data_2021 <- spl_df %>% 
  select(CheckoutYear) %>%
  filter(CheckoutYear == 2021)
data_2022 <- spl_df %>% 
  select(CheckoutYear) %>%
  filter(CheckoutYear == 2022)
data_2023 <- spl_df %>% 
  select(CheckoutYear) %>%
  filter(CheckoutYear == 2023)

# Plot p3
value <- c(nrow(data_2017), nrow(data_2018), nrow(data_2019), nrow(data_2020), nrow(data_2021), nrow(data_2022), nrow(data_2023))
lbls <- c("2017", "2018", "2019", "2020", "2021", "2022", "2023")
pie_chart <- cbind.data.frame(value, lbls)

percent <- pie_chart %>%
  arrange(desc(value)) %>%
  mutate(prop = percent(value / sum(value)))
pie <- pie_chart %>% 
  mutate(sum = rev(cumsum(rev(value))), 
         pos = value/2 + lead(sum, 1),
         pos = if_else(is.na(pos), value/2, pos))
percent <- percent %>% 
  left_join(pie, percent, by = "lbls")

p3 <- ggplot(pie_chart, aes(x = "" , y = value, fill = fct_inorder(lbls))) +
  geom_col(width = 1, color = 1) +
  coord_polar(theta = "y") +
  scale_fill_brewer(palette = "Pastel1") +
  geom_label_repel(data = percent,
                   aes(y = pos, label = prop),
                   size = 4.5, nudge_x = 1, show.legend = FALSE) +
  ggtitle("Percentage of checked out numbers per year") +
  guides(fill = guide_legend(title = "Year")) +
  theme_void()

