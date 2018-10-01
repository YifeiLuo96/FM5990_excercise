install.packages("dplyr")
install.packages("readr")
install.packages("stringr")
library(dplyr)
library(readr)
library(stringr)

# 2. read in both CSV fies into dataframe
df_occ <- read_csv("data_occ_201808.csv")
df_etfs <- read_csv("data_etf_list.csv")

# 3. creat a monthly volume report grouping by underlying
df_monthly_volume <- group_by(df_occ, underlying)

# 6. change uppercase to lowercase
df_etfs$segment <- tolower(df_etfs$segment)
View(df_etfs)

# 8. isolate the volatility ETFs
df_vol_etfs <- filter(df_etfs, str_detect(segment, "volatility"))

# 9. top 100 most liquid non-volatility ETFs
df_no.vol_etfs <- filter(df_etfs, !str_detect(segment, "volatility"))
df_top_100 <- top_n(df_no.vol_etfs, 100, desc(spread))

# 10. how many distinct segments
nrow(distinct(df_top_100, segment))
