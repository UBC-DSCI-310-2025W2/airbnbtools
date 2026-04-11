library(testthat)
library(airbnbtools)

# helper: create a valid dataset for test
create_valid_df <- function() {
    data.frame(
        id = 1:5,
        host_is_superhost = c("t", "f", "t", "f", "t"),
        neighbourhood_cleansed = rep("Downtown", 5),
        property_type = rep("Apartment", 5),
        room_type = rep("Entire home/apt", 5),
        accommodates = c(2, 3, 4, 2, 1),
        bathrooms = c(1, 1, 1.5, 1, 1),
        bedrooms = c(1, 2, 2, 1, 1),
        price = c("100", "150", "200", "120", "90"),
        review_scores_rating = c(90, 95, 88, 92, 85),
        reviews_per_month = c(1.2, 0.5, 2.0, 1.0, 0.3)
    )
}

# 1. PASS CASE
test_that("validate_airbnb_data returns TRUE for valid data", {
    df <- create_valid_df()
    expect_true(validate_airbnb_data(df))
})

# 2. ERROR CASES
test_that("error when input is not a data frame", {
    expect_error(validate_airbnb_data(123))
})

test_that("error when required columns are missing", {
    df <- create_valid_df()
    df <- df[, -1]  # remove id
    expect_error(validate_airbnb_data(df))
})

test_that("error when dataset is empty", {
    df <- create_valid_df()[0, ]
    expect_error(validate_airbnb_data(df))
})

test_that("error when accommodates is not numeric", {
    df <- create_valid_df()
    df$accommodates <- as.character(df$accommodates)
    expect_error(validate_airbnb_data(df))
})

test_that("error when bedrooms is negative", {
    df <- create_valid_df()
    df$bedrooms[1] <- -1
    expect_error(validate_airbnb_data(df))
})

test_that("error when bathrooms is negative", {
    df <- create_valid_df()
    df$bathrooms[1] <- -1
    expect_error(validate_airbnb_data(df))
})

test_that("error when accommodates <= 0", {
    df <- create_valid_df()
    df$accommodates[1] <- 0
    expect_error(validate_airbnb_data(df))
})

test_that("error when room_type is not categorical", {
    df <- create_valid_df()
    df$room_type <- as.numeric(1:5)
    expect_error(validate_airbnb_data(df))
})

test_that("error when property_type is not categorical", {
    df <- create_valid_df()
    df$property_type <- as.numeric(1:5)
    expect_error(validate_airbnb_data(df))
})

# 3. WARNING CASES

test_that("warning when duplicate ids exist", {
    df <- create_valid_df()
    df$id[2] <- df$id[1]
    expect_warning(validate_airbnb_data(df))
})

test_that("warning when missing values exceed 20%", {
    df <- create_valid_df()
    df$price[1:2] <- NA  # >20%
    expect_warning(validate_airbnb_data(df))
})

test_that("warning when price cannot be converted to numeric", {
    df <- create_valid_df()
    df$price[1] <- "abc"
    expect_warning(validate_airbnb_data(df))
})