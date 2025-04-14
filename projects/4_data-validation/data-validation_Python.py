import pandas as pd
import os

def check_production_file():
    # Paths to Excel files
    current_path = os.getcwd()
    reference_path = os.path.join(current_path, 'Reference.xlsx')
    production_path = os.path.join(current_path, 'Production.xlsx')
    unmet_requirements = []

    # Check if the files exist
    if not os.path.exists(reference_path):
        print(f"The reference file '{reference_path}' was not found.")
        return False
    if not os.path.exists(production_path):
        print(f"The production file '{production_path}' was not found.")
        return False

    # Read data from the Excel files
    df_reference = pd.read_excel(reference_path)
    df_production = pd.read_excel(production_path)

    # Requirement 1: Verify that the column names have not changed
    reference_columns = set(df_reference.columns)
    production_columns = set(df_production.columns)
    if reference_columns != production_columns:
        print("The columns have changed")
        missing_columns = reference_columns - production_columns
        new_columns = production_columns - reference_columns
        if missing_columns:
            print("Missing columns in production:", ", ".join(f'"{col}"' for col in missing_columns))
            #print(f"Missing columns in production: {missing_columns}")
        if new_columns:
            print("New columns in production:", ", ".join(f'"{col}"' for col in new_columns))
            #print(f"New columns in production: {new_columns}")
        unmet_requirements.append("The column names have changed.")

    # Requirement 2: Verify that the reference key has not changed
    # Create the key column by combining 'ID' and 'COLUMN_1'
    df_reference['Key'] = df_reference['ID'].astype(str) + '_' + df_reference['COLUMN_1'].astype(str)
    df_production['Key'] = df_production['ID'].astype(str) + '_' + df_production['COLUMN_1'].astype(str)

    # Get the sets of reference and production keys
    reference_keys = set(df_reference['Key'])
    production_keys = set(df_production['Key'])
    if reference_keys != production_keys:
        print("The reference key has changed")
        missing_keys = reference_keys - production_keys
        new_keys = production_keys - reference_keys
        if missing_keys:
            print("Missing keys in production:", ", ".join(f'"{key}"' for key in missing_keys))
        if new_keys:
            print("New keys in production:", ", ".join(f'"{key}"' for key in new_keys))
        unmet_requirements.append("The reference key has changed.")

    # Determine if the minimum requirements are met
    if unmet_requirements:
        print("\nMinimum requirements not met:")
        for requirement in unmet_requirements:
            print(f"- {requirement}")
        return False
    else:
        print("The production file meets the minimum requirements.")
        # Here you can add the code for massive data extraction
        # extract_data_massively(df_production)
        return True

# Example function for massive data extraction
def extract_data_massively(df):
    # Implement the logic for data extraction here
    print("Extracting information from the production file...")
    # For example, you could save certain data to another file or process them

if __name__ == '__main__':
    result = check_production_file()
    if result:
        # If the requirements are met, proceed with massive data extraction
        df_production = pd.read_excel('Production.xlsx')
        extract_data_massively(df_production)