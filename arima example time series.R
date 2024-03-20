# Load the package
library(forecast)

# Load the dataset
data(AirPassengers)

# Display the structure of the data
print(AirPassengers)

# Plot the data
plot(AirPassengers)

# Fit an ARIMA model
fit <- auto.arima(AirPassengers)

# Print the summary of the fit
summary(fit)

# Forecast the next 12 months
forecasted_data <- forecast(fit, h=12)

# Print the forecasted data
print(forecasted_data)

# Plot the forecasted data
plot(forecasted_data)
