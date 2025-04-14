# Import the necessary libraries
import pandas as pd
import win32com.client as win32

# Function to send emails based on assignments
def emailer(assignments):
    # Read data from Excel files
    df1 = pd.read_excel('assignments_data.xlsx')
    df2 = pd.read_excel('contacts_data.xlsx')
    
    email_body = "Hello,\n\nThe following assignments require your attention:\n\n"
    
    for assignment in assignments:
        # Filter data to get the row corresponding to the assignment
        row = df1.loc[df1['ASSIGNMENT'] == assignment]
        if row.empty:
            print(f"The assignment {assignment} was not found in the table")
            continue
        
        # Extract necessary information
        admin_code = row['ADMIN_CODE'].values[0]
        current_facility = row['CURRENT_FACILITY'].values[0]
        new_facility = row['NEW_FACILITY'].values[0]
        
        # Build the email content
        email_body += f"Assignment: {assignment}\n"
        email_body += f"Administrative Code: {admin_code}\n"
        email_body += f"Current Facility: {current_facility}\n"
        email_body += f"New Facility: {new_facility}\n\n"
    
    # Configure and send the email
    outlook = win32.Dispatch('outlook.application')
    mail = outlook.CreateItem(0)
    mail.To = 'recipient@example.com'
    mail.Subject = 'Assignment Updates'
    mail.Body = email_body
    mail.Display(True)  # Displays a preview of the email

# Example usage
emailer(['Assignment1', 'Assignment2'])
