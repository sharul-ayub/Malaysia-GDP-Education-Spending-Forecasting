# 📊 Malaysia GDP Education Spending Forecasting

## 📌 Project Overview

This project applies **univariate time series modelling** to analyse and forecast Malaysia’s education expenditure (% of GDP) using annual data from **1992–2023**.

Four forecasting approaches were implemented and compared:

- Naïve Forecast
- Average Change Model
- Holt’s Linear Trend Model
- ARIMA-based Models (AR, MA, ARMA)

The objective is to identify the most accurate and statistically reliable model for **12-year-ahead forecasting**.

---

## 📂 Dataset Description

- **Country:** Malaysia  
- **Period:** 1992–2023  
- **Frequency:** Annual  
- **Observations:** 30  
- **Variable:** Education Expenditure (% of GDP)

### Descriptive Summary

- Mean ≈ 20%
- Standard Deviation ≈ 2.62
- Approximately symmetric distribution
- No seasonality (annual data)
- Moderate variation over time

The series exhibits long-run structural movement with temporary shocks but no persistent cyclical pattern.

---

## 🔍 Methodology

### 1️⃣ Classical Forecasting Models

- **Naïve Forecast** (Benchmark model)
- **Average Change Model**
- **Holt’s Linear Trend Model**

### 2️⃣ Stochastic Time Series Modelling

- Stationarity testing:
  - Augmented Dickey–Fuller (ADF)
  - KPSS Test
- Autocorrelation analysis:
  - ACF
  - PACF
- ARMA model selection using:
  - RMSE
  - MAE
  - MAPE
  - MASE
  - AIC / BIC

### Residual Diagnostic Tests

- Anderson–Darling (Normality)
- Breusch–Pagan (Homoscedasticity)
- Durbin–Watson (Autocorrelation)
- Ljung–Box (Serial Independence)

---

## 🏆 Model Comparison Results

| Model | RMSE | MAE | MAPE | MASE |
|-------|------|------|------|------|
| Naïve | 2.334 | 1.852 | 9.590 | 1.000 |
| Average Change | 2.577 | 1.946 | 10.17 | 1.051 |
| Holt’s Linear Trend | 2.297 | 1.824 | 9.474 | 0.985 |
| **ARMA(1,2)** | **1.897** | **1.606** | **8.348** | **0.867** |

### ✅ Best Performing Model: **ARMA(1,2)**

Although AR(1) achieved slightly lower AIC/BIC values, ARMA(1,2) delivered:

- Lowest forecasting errors
- Superior predictive accuracy
- Statistically well-behaved residuals

---

## 🔬 Residual Diagnostics

Both Holt’s Linear Trend and ARMA(1,2) passed all residual diagnostic tests:

- Residuals approximately normally distributed  
- No heteroscedasticity  
- No serial correlation  
- No ARCH effects  

ARMA(1,2) demonstrated stronger predictive performance while maintaining statistical adequacy.

---

## 📈 12-Year Forecast (2024–2035)

The selected ARMA(1,2) model forecasts:

- Short-term increase (2024–2026)
- Convergence toward long-run mean ≈ 19.77%
- Gradually widening confidence intervals

### Interpretation

Education spending is expected to remain relatively stable in the long run, with deviations driven primarily by short-term shocks rather than structural changes.

This behaviour is consistent with a stationary ARMA process where shocks are temporary and mean reversion dominates.

---

## 💡 Key Insights

- Malaysia’s education expenditure behaves approximately as a stationary process.
- Short-term fluctuations exist, but long-term stability prevails.
- ARMA modelling significantly improves forecasting accuracy over classical methods.
- Residual diagnostics confirm model adequacy and reliability.

---

## 🛠 Tools & Packages Used

- R
- forecast
- tseries
- ggplot2
- lmtest
- nortest



