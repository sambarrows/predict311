library(astsa)
library(xts)

# set working directory
setwd("/Users/sambarrows/Dropbox/Stats/Projects/predict311")

# read csv
df = read.table("calldat1617.csv", sep=",", head=TRUE)
nrow(df)
head(df)

# select training data series
train = as.numeric(unlist(df[1:(nrow(df)-20000*2),]['total']))
length(train)

# try plotting P/ACF without a lag
# (we clearly see the daily trend - one day is 24*6 = 144 time steps)

# try plotting P/ACF with a max.lag
acf2(train, max.lag=500)
acf2(train, max.lag=144)

# I found was freezing with full training set. 
# Try instead with the last two weeks of training data
t = tail(train, n=24*6*7)

# Non-Seasonal: ACF and PCF trailing off
# Seasonal: ACF and PCF trailing off
sarima(t, 1, 0, 1, 1, 0, 1, 144)

# forcast for validation set
f = sarima.for(train, n.ahead = 24*6*7, 1, 0, 1, 1, 0, 1, 144)

# Whilst can fit the model, although it takes a while, I left the forecasting
# running for ages and it did not complete. Not sure if it will be possible
# to in a practical amoutn of time, so will use a simpler baseline instead.