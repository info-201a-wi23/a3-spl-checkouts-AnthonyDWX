#Load libraries
library(dplyr)
library(knitr)

#Load csv
spl_df <- read.csv("C:/Users/14221/Desktop/2017-2023-10-Checkouts-SPL-Data.csv/2017-2023-10-Checkouts-SPL-Data.csv")

#list data
spl_summary <- list(
  nrow = nrow(spl_df),
  n_distinct_UsageClass = n_distinct(spl_df$UsageClass),
  n_distinct_CheckoutType = n_distinct(spl_df$CheckoutType),
  n_distinct_MaterialType = n_distinct(spl_df$MaterialType),
  max_CheckoutYear = max(spl_df$CheckoutYear),
  min_CheckoutYear = min(spl_df$CheckoutYear),
  max_CheckoutMonth = max(spl_df$CheckoutMonth),
  min_CheckoutMonth = min(spl_df$CheckoutMonth),
  max_Checkouts = max(spl_df$Checkouts),
  min_Checkouts = min(spl_df$Checkouts),
  mean_Checkouts = mean(spl_df$Checkouts),
  median_Checkouts = median(spl_df$Checkouts)
)
