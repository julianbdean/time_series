# Packages
library(forecast)

# data
data(AirPassengers)

# Fit an ARIMA model
fit <- auto.arima(AirPassengers)

# Forecast the next 12 months
forecasted_data <- forecast(fit, h=12)
summary(fit)

# Plot
plot(AirPassengers)
plot(forecasted_data)
