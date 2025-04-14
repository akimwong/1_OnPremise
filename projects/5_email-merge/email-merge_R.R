# Load necessary libraries
library(readxl)
library(RDCOMClient)

# Function to send emails based on assignments
emailer <- function(assignments) {
  # Read data from Excel files
  df1 <- read_excel('assignments_data.xlsx')
  df2 <- read_excel('contacts_data.xlsx')
  
  email_body <- "Hello,\n\nThe following assignments require your attention:\n\n"
  
  for (assignment in assignments) {
    # Filter data to get the row corresponding to the assignment
    row <- df1[df1$ASSIGNMENT == assignment, ]
    if (nrow(row) == 0) {
      print(paste("The assignment", assignment, "was not found in the table"))
      next
    }
    
    # Extract necessary information
    admin_code <- row$ADMIN_CODE[1]
    current_facility <- row$CURRENT_FACILITY[1]
    new_facility <- row$NEW_FACILITY[1]
    
    # Build the email content
    email_body <- paste0(email_body,
                         "Assignment: ", assignment, "\n",
                         "Administrative Code: ", admin_code, "\n",
                         "Current Facility: ", current_facility, "\n",
                         "New Facility: ", new_facility, "\n\n")
  }
  
  # Configure and send the email via Outlook
  outlook_app <- COMCreate("Outlook.Application")
  mail <- outlook_app$CreateItem(0)
  mail[["To"]] <- "recipient@example.com"
  mail[["Subject"]] <- "Assignment Updates"
  mail[["Body"]] <- email_body
  mail$Display()  # Displays a preview of the email
}

# Example usage
emailer(c('Assignment1', 'Assignment2'))

