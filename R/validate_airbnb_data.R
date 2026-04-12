validate_airbnb_data <- function(df) {
    
    # 1. Check input data type, ensure the input is a data frame
    if (!is.data.frame(df)) {
        stop("Input must be a data frame.")
    }

    # 2. Check required columns exist, ensure key variables are present for analysis
    required_cols <- c("id", "host_is_superhost", "neighbourhood_cleansed", "property_type",
                       "room_type", "accommodates", "bathrooms", "bedrooms", "price", 
                       "review_scores_rating", "reviews_per_month")
    
    missing_cols <- setdiff(required_cols, colnames(df))
    
    if (length(missing_cols) > 0) {
        stop("missing required columns")
    }

    # 3. Check dataset is not empty
    if (nrow(df) == 0) {
        stop("Dataset contains no observations.")
    }

    # 4. Check for duplicate observations (based on id)
    if (any(duplicated(df$id))) {
        warning("Duplicate IDs detected in the dataset.")
    }

    # 5. Check missingness, warn if missing values > 20% in key columns
    missing_prop <- colMeans(is.na(df[, required_cols]))
    
    if (any(missing_prop > 0.2)) {
        warning("Some columns have more than 20% missing values.")
    }

    # 6. Check price format before cleaning
    price_numeric <- suppressWarnings(as.numeric(gsub(",", "", df$price)))
    
    if (any(is.na(price_numeric) & !is.na(df$price))) {
        warning("Some price values cannot be converted to numeric.")
    }

    # 7. Check numeric columns are valid
    if (!is.numeric(df$accommodates)) {
        stop("'accommodates' must be numeric.")
    }

    if (!is.numeric(df$bedrooms)) {
        stop("'bedrooms' must be numeric.")
    }

    if (!is.numeric(df$bathrooms)) {
        stop("'bathrooms' must be numeric.")
    }

    # 8. Check for irregular values
    if (any(df$accommodates <= 0, na.rm = TRUE)) {
        stop("'accommodates' must be greater than 0.")
    }

    if (any(df$bedrooms < 0, na.rm = TRUE)) {
        stop("'bedrooms' cannot be negative.")
    }

    if (any(df$bathrooms < 0, na.rm = TRUE)) {
        stop("'bathrooms' cannot be negative.")
    }

    # 9. Check if categorical variables exist and are valid
    if (!is.character(df$room_type) && !is.factor(df$room_type)) {
        stop("'room_type' must be a categorical variable.")
    }

    if (!is.character(df$property_type) && !is.factor(df$property_type)) {
        stop("'property_type' must be a categorical variable.")
    }

    # if tests all pass
    return(TRUE)
}