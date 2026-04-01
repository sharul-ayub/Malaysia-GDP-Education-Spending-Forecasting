# ============================================================
# 05_accuracy_and_diagnostics.R
# Accuracy table + residual diagnostics
# ============================================================

source("scripts/03_model_fitting.R")

# -----------------------------
# Error measures (accuracy)
# -----------------------------
models <- list(
  Naive        = naive_model,
  Average      = average_model,
  Holt         = holt_model,
  ARIMA_100    = model100,
  ARIMA_001    = model001,
  ARIMA_101    = model101,
  ARIMA_201    = model201,
  ARIMA_102    = model102
)

get_metrics <- function(model) {
  acc <- accuracy(model)
  is_arima <- inherits(model, "Arima")
  
  data.frame(
    ME    = acc["Training set", "ME"],
    RMSE  = acc["Training set", "RMSE"],
    MAE   = acc["Training set", "MAE"],
    MPE   = acc["Training set", "MPE"],
    MAPE  = acc["Training set", "MAPE"],
    MASE  = acc["Training set", "MASE"],
    AIC   = if (is_arima) AIC(model) else NA,
    BIC   = if (is_arima) BIC(model) else NA
  )
}

results_table <- do.call(rbind, lapply(models, get_metrics))
results_table <- cbind(Model = names(models), results_table)
rownames(results_table) <- NULL

results_table

# ============================================================
# Residual Diagnostics: Holt’s Linear Trend Model
# ============================================================

par(
  mfrow = c(2, 4),
  oma = c(0, 0, 4, 0)
)

res_holt <- residuals(holt_model)

plot(
  res_holt,
  type = "p",
  pch = 16,
  col = "red",
  xlab = "Index",
  ylab = "Residuals",
  main = "Scatterplot of Residuals"
)

hist(
  res_holt,
  main = "Histogram of Residuals",
  xlab = "Residuals",
  col = "lightgray",
  border = "black"
)

qqnorm(res_holt, main = "Q–Q Plot of Residuals")
qqline(res_holt, col = "red")

std_res_holt <- res_holt / sd(res_holt)
fitted_holt <- fitted(holt_model)
valid_holt <- is.finite(std_res_holt) & is.finite(fitted_holt)

plot(
  fitted_holt[valid_holt],
  std_res_holt[valid_holt],
  pch = 16,
  main = "Standardized Residuals vs Fitted Values",
  xlab = "Fitted Values",
  ylab = "Standardized Residuals"
)
abline(h = 0, col = "red")

acf(
  res_holt,
  main = "ACF of Residuals"
)

res_holt_clean <- na.omit(res_holt)
fitted_holt_clean <- fitted(holt_model)[is.finite(res_holt)]

plot(
  fitted_holt_clean,
  res_holt_clean,
  main = "Scatterplot of Residuals vs. Fitted Values",
  xlab = "Fitted Values",
  ylab = "Residuals",
  pch = 1
)

boxplot(
  res_holt,
  main = "Boxplot of Residuals",
  ylab = "Residuals"
)

acf(
  res_holt^2,
  main = "ACF of Squared Residuals"
)

title(
  "Residual Diagnostics for Holt’s Linear Trend Model",
  outer = TRUE,
  cex.main = 1.4,
  font.main = 2
)

fit_holt <- fitted(holt_model)
idx_holt <- is.finite(res_holt) & is.finite(fit_holt)
res_holt_ok <- res_holt[idx_holt]
fit_holt_ok <- fit_holt[idx_holt]

ad_holt <- ad.test(res_holt_ok)
bp_holt <- bptest(res_holt_ok ~ fit_holt_ok)
dw_holt <- dwtest(res_holt_ok ~ 1)
lb_holt <- Box.test(res_holt_ok, lag = 5, type = "Ljung-Box")

ad_holt
bp_holt
dw_holt
lb_holt

# ============================================================
# Residual Diagnostics: ARMA(1,2)
# ============================================================

resmodel102 <- residuals(model102)

par(
  mfrow = c(2, 4),
  oma = c(0, 0, 4, 0)
)

plot(
  resmodel102,
  type = "p",
  pch = 16,
  col = "red",
  xlab = "Index",
  ylab = "Residuals",
  main = "Scatterplot of Residuals"
)

hist(
  resmodel102,
  main = "Histogram of Residuals",
  xlab = "Residuals",
  col = "lightgray",
  border = "black"
)

qqnorm(resmodel102, main = "Q–Q Plot of Residuals")
qqline(resmodel102, col = "red")

sd_arma <- sd(resmodel102, na.rm = TRUE)
std_res_arma <- resmodel102 / sd_arma
std_res_arma <- std_res_arma[is.finite(std_res_arma)]

plot(
  std_res_arma,
  type = "p",
  pch = 16,
  main = "Standardized Residuals vs Fitted values",
  xlab = "Fitted values",
  ylab = "Standardized Residuals"
)

abline(h = 0, col = "red", lwd = 2, lty = 2)

acf(
  resmodel102,
  main = "ACF of Residuals"
)

res_arma102_clean <- na.omit(resmodel102)
fitted_arma102_clean <- fitted(model102)[is.finite(resmodel102)]

plot(
  fitted_arma102_clean,
  res_arma102_clean,
  main = "Scatterplot of Residuals vs Fitted Values",
  xlab = "Fitted Values",
  ylab = "Residuals",
  pch = 1
)

boxplot(
  resmodel102,
  main = "Boxplot of Residuals",
  ylab = "Residuals"
)

boxplot.stats(resmodel102)$out

acf(
  resmodel102^2,
  main = "ACF of Squared Residuals"
)

title(
  "Residual Diagnostics for ARMA(1,2)",
  outer = TRUE,
  cex.main = 1.4,
  font.main = 2
)

fit_arma102 <- fitted(model102)
idx_arma102 <- is.finite(resmodel102) & is.finite(fit_arma102)
res_arma102_ok <- resmodel102[idx_arma102]
fit_arma102_ok <- fit_arma102[idx_arma102]

ad_arma102 <- ad.test(res_arma102_ok)
bp_arma102 <- bptest(res_arma102_ok ~ fit_arma102_ok)
dw_arma102 <- dwtest(res_arma102_ok ~ 1)
lb_arma102 <- Box.test(res_arma102_ok, lag = 5, type = "Ljung-Box")

ad_arma102
bp_arma102
dw_arma102
lb_arma102