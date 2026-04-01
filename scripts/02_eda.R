# ============================================================
# 02_eda.R
# Exploratory Data Analysis
# ============================================================

source("scripts/01_load_data.R")

# Time series plot
plot.ts(
  edu_spend,
  ylab = "Education Spending (% of GDP)",
  xlab = "Year",
  main = "Yearly Education Spending (1992–2023)"
)

# Summary Statistics
length(edu_spend)
sd(edu_spend)
skewness(edu_spend)
sum(is.na(edu_spend))
head(edu_spend)
tail(edu_spend)

# Shape of the Distribution
par(mfrow = c(1, 2))

hist(
  edu_spend,
  main = "Histogram of Education Spending",
  xlab = "Education Spending (% of GDP)",
  col = "lightblue",
  border = "black"
)

boxplot(
  edu_spend,
  main = "Boxplot of Education Spending",
  col = "lightgreen"
)
par(mfrow = c(1, 1))

outliers <- boxplot.stats(edu_spend)$out
outliers

# Time Series Components
acf(
  edu_spend,
  main = "ACF of Education Spending"
)

ggseasonplot(
  edu_spend,
  main = "Seasonal Plot of Education Spending",
  year.labels = TRUE
)