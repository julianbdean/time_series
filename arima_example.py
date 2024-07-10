# Import necessary libraries
import pandas as pd
import matplotlib.pyplot as plt
from statsmodels.tsa.arima.model import ARIMA
from statsmodels.datasets import co2
from pandas.plotting import register_matplotlib_converters

# Load data (AirPassengers is available in statsmodels datasets)
data = co2.load_pandas().data
df = pd.DataFrame(data['co2'].copy())
df.columns = ['passengers']

# Fit an ARIMA model
model = ARIMA(df, order=(1, 1, 1))
fit = model.fit()

# Forecast the next 12 months
forecasted_data = fit.forecast(steps=12)

forecast_df = pd.DataFrame(forecasted_data)
forecast_df.columns = ['passengers']

df['forecast'] = 0
forecast_df['forecast'] = 1

full_data  = pd.concat([df, forecast_df], axis = 0)
plot_data = full_data[full_data.index >= '1990-01-01']

# Plotting
plt.figure(figsize=(10, 6))

# Plot solid lines for forecast = 0
plt.plot(plot_data.index[plot_data['forecast'] == 0], plot_data.loc[plot_data['forecast'] == 0, 'passengers'],
          label='Historical', linestyle='-', color='black')

# Plot dashed lines for forecast = 1
plt.plot(plot_data.index[plot_data['forecast'] == 1], plot_data.loc[plot_data['forecast'] == 1, 'passengers'],
         label='Forecast', linestyle='--', color = 'gray')

plt.xlabel('Index')
plt.ylabel('Passengers')
plt.title('Passenger Count with Forecast')
plt.legend()
plt.grid(True)
plt.show()
