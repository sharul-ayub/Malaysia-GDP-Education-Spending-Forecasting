# ============================================================
# 01_load_data.R
# Load dataset and convert to time series
# ============================================================

source("scripts/00_setup.R")

# Import CSV file
data <- read_csv("data/edu_spend_dataset.csv")

# Convert to time series object (yearly data)
edu_spend <- ts(
  data$`Education Spending (%)`,
  start = 1992,
  frequency = 1
)
