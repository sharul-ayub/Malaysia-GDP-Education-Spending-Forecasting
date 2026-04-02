# ============================================================
# 06_forecasting.R
# Forecasting using best model
# ============================================================

source("scripts/03_model_fitting.R")

arima_forecast <- forecast(
  best_model,
  h = 12,
  level = c(80, 95)
)


plot(
  arima_forecast,
  lwd = 2,
  xlab = "Time (Years)",
  ylab = "Education Spending (% of GDP)",
  main = "12-step Ahead Forecast using ARMA(1,2)"
)

# Fitted values (BLUE)
lines(fitted(best_model), col = "blue", lwd = 2)

# Forecast mean (RED)
lines(arima_forecast$mean, col = "red", lwd = 2)

legend(
  "topleft",
  legend = c("Observed", "Fitted Values", "Forecast"),
  col = c("black", "blue", "red"),
  lty = 1,
  lwd = 2,
  bty = "o",
  bg  = "white"
)

forecast_table <- data.frame(
  Year = 2024:2035,
  Forecast = as.numeric(arima_forecast$mean),
  Lower_80 = arima_forecast$lower[, 1],
  Upper_80 = arima_forecast$upper[, 1],
  Lower_95 = arima_forecast$lower[, 2],
  Upper_95 = arima_forecast$upper[, 2]
)

forecast_table
