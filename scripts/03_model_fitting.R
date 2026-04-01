# ============================================================
# 03_model_fitting.R
# Fit classical and ARIMA-based models
# ============================================================

source("scripts/01_load_data.R")

# -----------------------------
# Classical Time Series Models
# -----------------------------
naive_model <- naive(edu_spend)
average_model <- meanf(edu_spend)
holt_model <- holt(edu_spend)

fitted_naive <- fitted(naive_model)
fitted_average <- fitted(average_model)
fitted_holt <- fitted(holt_model)

fitted_naive
length(fitted_naive)

fitted_average
length(fitted_average)

fitted_holt
length(fitted_holt)

# -----------------------------
# ARIMA-Based Models
# -----------------------------
par(mfrow = c(1, 2))

plot.ts(
  edu_spend,
  ylab = "Education Spending (% of GDP)",
  xlab = "Year",
  main = "Yearly Education Spending (1992–2023)"
)

acf(
  edu_spend,
  main = "ACF of Education Spending"
)

pacf(
  edu_spend,
  main = "PACF of Education Spending"
)

# Stationarity tests
adf.test(edu_spend)
kpss.test(edu_spend)

# ACF/PACF for order suggestion
par(mfrow = c(1, 2))
acf(edu_spend, main = "ACF of Education Spending")
pacf(edu_spend, main = "PACF of Education Spending")

# Auto ARIMA trace
auto_model_trace <- auto.arima(
  edu_spend,
  trace = TRUE
)

# Candidate models
model101 <- Arima(edu_spend, order = c(1, 0, 1))
model100 <- Arima(edu_spend, order = c(1, 0, 0))
model001 <- Arima(edu_spend, order = c(0, 0, 1))
model201 <- Arima(edu_spend, order = c(2, 0, 1))
model102 <- Arima(edu_spend, order = c(1, 0, 2))

# Best model
best_model <- model102