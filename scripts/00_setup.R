# ============================================================
# 00_setup.R
# Load required packages
# ============================================================

required_packages <- c(
  "readr",
  "forecast",
  "ggplot2",
  "moments",
  "tseries",
  "nortest",
  "lmtest"
)

for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}