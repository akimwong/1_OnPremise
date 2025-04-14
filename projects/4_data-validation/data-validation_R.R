library(readxl)
library(stringr)

check_production_file <- function() {
  # Paths to Excel files
  current_path <- getwd()
  reference_path <- file.path(current_path, "Reference.xlsx")
  production_path <- file.path(current_path, "Production.xlsx")
  unmet_requirements <- c()
  
  # Check if the files exist
  if (!file.exists(reference_path)) {
    cat(sprintf("The reference file '%s' was not found.\n", reference_path))
    return(FALSE)
  }
  if (!file.exists(production_path)) {
    cat(sprintf("The production file '%s' was not found.\n", production_path))
    return(FALSE)
  }
  
  # Read data from the Excel files
  df_reference <- read_excel(reference_path)
  df_production <- read_excel(production_path)
  
  # Requirement 1: Verify that the column names have not changed
  reference_columns <- names(df_reference)
  production_columns <- names(df_production)
  if (!identical(reference_columns, production_columns)) {
    cat("The columns have changed.\n")
    missing_columns <- setdiff(reference_columns, production_columns)
    new_columns <- setdiff(production_columns, reference_columns)
    if (length(missing_columns) > 0) {
      cat("Missing columns in production:", paste(shQuote(missing_columns, type = "cmd"), collapse=", "), "\n")
    }
    if (length(new_columns) > 0) {
      cat("New columns in production:", paste(shQuote(new_columns, type = "cmd"), collapse=", "), "\n")  
    }
    unmet_requirements <- c(unmet_requirements, "The column names have changed.")
  }
  
  # Requirement 2: Verify that the reference key has not changed
  # Create the key column by combining 'ID' and 'COLUMN_1'
  df_reference$Key <- str_c(df_reference$ID, "_", df_reference$`COLUMN_1`)
  df_production$Key <- str_c(df_production$ID, "_", df_production$`COLUMN_1`)
  
  # Get the sets of reference and production keys
  reference_keys <- unique(df_reference$Key)
  production_keys <- unique(df_production$Key)
  if (!identical(reference_keys, production_keys)) {
    cat("The reference key has changed.\n")
    missing_keys <- setdiff(reference_keys, production_keys)
    new_keys <- setdiff(production_keys, reference_keys)
    if (length(missing_keys) > 0) {
      cat("Missing keys in production: ")
      #cat(paste(missing_keys, collapse=", "), "\n")  # Ajuste aquí
      cat(paste(shQuote(missing_keys), collapse=", "), "\n")
    }
    if (length(new_keys) > 0) {
      cat("New keys in production: ")
      cat(paste(shQuote(new_keys), collapse=", "), "\n")
      #print(new_keys)
    }
    unmet_requirements <- c(unmet_requirements, "The reference key has changed.")
  }
  
  # Determine if the minimum requirements are met
  if (length(unmet_requirements) > 0) {
    cat("\nMinimum requirements not met:\n")
    for (requirement in unmet_requirements) {
      cat(sprintf("- %s\n", requirement))
    }
    return(FALSE)
  } else {
    cat("The production file meets the minimum requirements.\n")
    # Here you can add the code for massive data extraction
    # extract_data_massively(df_production)
    return(TRUE)
  }
}

# Example function for massive data extraction
extract_data_massively <- function(df) {
  # Implement the logic for data extraction here
  cat("Extracting information from the production file...\n")
  # For example, you could save certain data to another file or process them
}

# Main execution
if (check_production_file()) {
  df_production <- read_excel("Production.xlsx")
  extract_data_massively(df_production)
}