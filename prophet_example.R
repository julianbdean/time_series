# packages
library(prophet)
library(tidyverse)
library(zoo)

# data
data("AirPassengers")

historical <- data.frame(
  ds = as.Date(time(AirPassengers)),  # Convert to Date first
  y = as.numeric(AirPassengers)
)

historical$ds <- as.POSIXct(historical$ds)

# Model
m <- prophet(historical)

future <- make_future_dataframe(m, periods = 12, freq = 'month')
forecast <- predict(m, future)

# Plot
ggplot() +
  geom_line(data = filter(forecast, ds > max(historical$ds)), aes(x = ds, y = yhat, linetype = "Forecast"), color = "blue") +
  geom_ribbon(data = filter(forecast, ds > max(historical$ds)), aes(x = ds, ymin = yhat_lower, ymax = yhat_upper), 
              fill = "blue", alpha = 0.3) +
  geom_line(data = historical, aes(x = ds, y = y, linetype = "Actual"), color = "black") +
  labs(x = "Date", y = "Passengers", title = "Passengers forecast with Prophet") +
  scale_linetype_manual(name = "Data Type", values = c("Actual" = "solid", "Forecast" = "dashed")) +
  theme_classic()


ggsave(filename = 'prophet_passengers.jpg')
