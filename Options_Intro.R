# install packages
install.packages("dplyr")
install.packages("readr")
install.packages("ggplot2")
library(ggplot2)
library(dplyr)
library(readr)

# 1. read the data set and load it into dataframe
df_options_intro <- read_csv("data_options_intro.csv")

# 3. grabe the columns and print
k <- df_options_intro$strike
implied_vol <- df_options_intro$implied_vol
ask_price <- df_options_intro$ask

# 4. to determine the number of rows
nrow(df_options_intro)

# 5.take a look at the options data and confirm the value
View(df_options_intro)

# 6. expiration date of all the options
as.Date(df_options_intro$expiration, "%m/%d/%Y")
distinct(df_options_intro, expiration)
as.Date(df_options_intro$trade_date, "%m/%d/%Y")
distinct(df_options_intro, trade_date)

# 7. to determine how many underlyings
distinct(df_options_intro, underlying)

# 8. creat subdataframes
df_SPY <- filter(df_options_intro, underlying == "SPY")
df_IWM <- filter(df_options_intro, underlying == "IWM")
df_QQQ <- filter(df_options_intro, underlying == "QQQ")
df_DIA <- filter(df_options_intro, underlying == "DIA")

# 9/10. draw line graph with strike price and implied_vol
qplot(x = strike, y = implied_vol, geom = "point", data = df_SPY, main = "SPY_plot")
qplot(x = strike, y = implied_vol, geom = "point", data = df_IWM, main = "IWM_plot")
qplot(x = strike, y = implied_vol, geom = "point", data = df_QQQ, main = "QQQ_plot")
qplot(x = strike, y = implied_vol, geom = "point", data = df_DIA, main = "DIA_plot")

# 11. break down SPY into Call and Put
df_SPY_puts <- filter(df_SPY, type == "put")
df_SPY_calls <- filter(df_SPY, type == "call")

# 12. the numbers of puts and calls respectively
nrow(df_SPY_puts)
nrow(df_SPY_calls)

# 13. create a graph with strike and bid_price
qplot(x = strike, y = bid, data = df_SPY_calls, main = "Call Options")
qplot(x = strike, y = bid, data = df_SPY_puts, main = "Put Options")
