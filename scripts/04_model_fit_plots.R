# ============================================================
# 04_model_fit_plots.R
# Plot observed vs fitted values
# ============================================================

source("scripts/03_model_fitting.R")

# Plot observed vs fitted Classical Time Series Models
classical_models <- list(
  "Naïve Model" = naive_model,
  "Average Change Model" = average_model,
  "Holt’s Linear Trend Model" = holt_model
)

par(mfrow = c(3, 1))
for (name in names(classical_models)) {
  plot(
    edu_spend,
    col = "black",
    lwd = 2,
    main = paste("Observed vs Fitted:", name),
    ylab = "Education Spending (% of GDP)",
    xlab = "Year"
  )
  
  lines(
    fitted(classical_models[[name]]),
    col = "blue",
    lwd = 2
  )
  
  legend(
    "topright",
    legend = c("Observed", "Fitted"),
    col = c("black", "blue"),
    lty = 1,
    lwd = 2,
    bty = "n"
  )
}

# ============================================================
# Plot observed vs fitted ARIMA-Based Models
arima_models <- list(
  "ARMA(1,1)" = model101,
  "AR(1)"     = model100,
  "MA(1)"     = model001,
  "ARMA(2,1)" = model201,
  "ARMA(1,2)" = model102
)

par(mfrow = c(3, 2))
for (name in names(arima_models)) {
  plot(
    edu_spend,
    col = "black",
    lwd = 2,
    main = paste("Observed vs Fitted:", name),
    ylab = "Education Spending (% of GDP)",
    xlab = "Year"
  )
  
  lines(
    fitted(arima_models[[name]]),
    col = "blue",
    lwd = 2
  )
  
  legend(
    "topright",
    legend = c("Observed", "Fitted"),
    col = c("black", "blue"),
    lty = 1,
    lwd = 2,
    bty = "n"
  )
}