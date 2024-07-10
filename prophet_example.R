# packages
library(prophet)

# data
data("AirPassengers")

# wrangle
air_passengers <- data.frame(
  ds = as.Date(time(AirPassengers)),
  y = as.numeric(AirPassengers)
)

# fit model
m <- prophet(air_passengers)
future <- make_future_dataframe(m, periods = 12, freq = 'month')
forecast <- predict(m, future)

# Plot
plot(m, forecast)
