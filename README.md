# airbnbtools

[![R-CMD-check](https://github.com/UBC-DSCI-310-2025W2/airbnbtools/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/UBC-DSCI-310-2025W2/airbnbtools/actions/workflows/R-CMD-check.yaml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

`airbnbtools` is a small R package that bundles the data-cleaning, splitting,
visualization, and model-evaluation helpers used in our Airbnb listing price
prediction project. It exists so that the team — and anyone else doing
similar work — can reuse these helpers without copy-pasting source files
between projects.

## Overview

The package was built to support the
[UBC DSCI 310 (2025W2) Airbnb price-prediction analysis](https://github.com/UBC-DSCI-310-2025W2/dsci-310-group-01-jet2holiday).
It packages the preprocessing decisions, the id-aware train/test split, the
exploratory boxplot helper, and the test-set evaluation metrics that we use
across that pipeline. Each function handles bad input gracefully with clear
error messages, and each is documented with a `roxygen2` block and covered
by `testthat` tests.

## Functions

| Function | Purpose |
| --- | --- |
| `clean_airbnb_data()` | Preprocess raw Airbnb listings: select the modelling columns, drop rows with missing predictors, parse `price` from a `$1,234`-style string into a number, and collapse rare property types and neighbourhoods into "Other". |
| `split_data()` | Split a data frame into training and test sets (80/20 by default) using an `id` column to guarantee no row appears in both sets. |
| `plot_boxplot()` | Generate a `ggplot2` boxplot of any categorical predictor against `log_price`, with sensible defaults and optional rotated x-axis labels. |
| `calculate_rmse()` | Compute root mean squared error from a predicted and actual numeric vector. Validates input length, types, and missingness. |
| `calculate_r_squared()` | Compute R-squared (1 − SS_res / SS_tot) for held-out test data, where `summary(model)$r.squared` does not apply. |

## Installation

`airbnbtools` is not on CRAN. Install it from GitHub with
[`devtools`](https://devtools.r-lib.org/):

```r
# install.packages("devtools")
devtools::install_github("UBC-DSCI-310-2025W2/airbnbtools")
```

## Usage

A minimal end-to-end example, from a raw listings data frame to a fitted
model and its test-set metrics:

```r
library(airbnbtools)

# `raw_airbnb` is a data frame in the shape of an Inside Airbnb listings.csv
clean <- clean_airbnb_data(raw_airbnb)
clean$log_price <- log(clean$price)

split <- split_data(clean, prop = 0.8)
train <- split$train
test  <- split$test

model <- lm(log_price ~ accommodates + bedrooms + bathrooms + room_type,
            data = train)

predictions <- predict(model, newdata = test)
calculate_rmse(predictions, test$log_price)
calculate_r_squared(predictions, test$log_price)

plot_boxplot(train, room_type, title = "Log price by room type")
```

## Where this fits in the R package ecosystem

The generic building blocks `airbnbtools` is built on already exist and are
excellent: [`dplyr`](https://dplyr.tidyverse.org/),
[`tidyr`](https://tidyr.tidyverse.org/), and
[`stringr`](https://stringr.tidyverse.org/) for data wrangling;
[`rsample`](https://rsample.tidymodels.org/) and
[`caret`](https://topepo.github.io/caret/) for train/test splitting;
[`ggplot2`](https://ggplot2.tidyverse.org/) for visualization; and
[`yardstick`](https://yardstick.tidymodels.org/) and
[`Metrics`](https://github.com/mfrasco/Metrics) for evaluation metrics like
RMSE and R-squared.

`airbnbtools` is **not** a competitor to any of those. It is a thin,
domain-specific wrapper that codifies the exact preprocessing and
evaluation choices our analysis makes — parsing the `$`-prefixed `price`
column, collapsing rare property types and neighbourhoods into "Other",
splitting on the listing `id` to prevent leakage, and computing R-squared
on a held-out test set rather than from a fitted-model summary. If you are
not analyzing Airbnb data, the generic packages above will serve you
better. If you are, `airbnbtools` saves you from re-deriving the same
preprocessing pipeline.

## Used in

- [dsci-310-group-01-jet2holiday](https://github.com/UBC-DSCI-310-2025W2/dsci-310-group-01-jet2holiday) — the companion data analysis project.

## Contributing

Contributions, bug reports, and feature requests are welcome. Please read
[CONTRIBUTING.md](CONTRIBUTING.md) for the development workflow and
[CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) before participating.

## License

`airbnbtools` is released under the MIT License — see [LICENSE](LICENSE)
for the full text.
