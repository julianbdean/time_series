# Packages
library(forecast)
library(tidyverse)
library(zoo)

# Data
data(AirPassengers)

# Fit an ARIMA model
fit <- auto.arima(AirPassengers)
forecasted_data <- forecast(fit, h = 12)

# Convert to df
forecast_df <- data.frame(
  Date = as.Date(time(forecasted_data$mean)),  # Extract dates
  Point.Forecast = forecasted_data$mean,        # Point forecasts
  Lo.95 = forecasted_data$lower[, "95%"],       # Lower 95% CI
  Hi.95 = forecasted_data$upper[, "95%"]        # Upper 95% CI
)

historical_df <- data.frame(
  Date = as.Date(time(AirPassengers)),  # Extract dates
  Passengers = as.numeric(AirPassengers)  # Convert to numeric
)

# Plotting using ggplot2 with theme_classic
ggplot() +
  geom_line(data = historical_df, aes(x = Date, y = Passengers)) +
  geom_line(data = forecast_df, aes(x = Date, y = Point.Forecast), linetype = "dashed") +
  geom_ribbon(data = forecast_df, aes(x = Date, ymin = Lo.95, ymax = Hi.95), fill = "grey", alpha = 0.5) +
  labs(x = "Year", y = "Passengers", title = "Passenger count forecast using ARIMA") +
  theme_classic()

ggsave(filename = "passenger_forecast_arima_R.jpg")
