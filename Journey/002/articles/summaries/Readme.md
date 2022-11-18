# So You’ve Got a Really Big Dataset. Here’s How You Clean It

#### Filter
- If you are working with a subset of data, you want to make sure that the data represents the subset of interest. 
- Filter for characteristics of specific columns to make sure

#### Standardise missing data labels
- Sometimes missing data is coded as ‘NO DATA’, ‘0’, ‘N/A’ or just an empty string. For ease of cleaning, convert all these into np.nan.

#### Clean dependent variable
- If there isn’t a value for the variable you’re predicting, then there’s no point in having the entry in the final dataset. 
- Check that the maximum and minimum values are within logical bounds for the variable and that all rows are of the same data type.

#### Remove duplicate entries
- Having duplicates indicates possible errors in data entry. 
- Before removing all duplicates, ask: Why are there duplicates in the dataset? (The answer will change your strategy for removing them).
- Don’t be so quick to remove duplicates!

#### Check missing value percentage per variable
- If there are too many missing values, you will want to drop the column. 
- But what is the cut-off point? Generally having more than 50% of the data missing makes the column seem useless BUT before dropping any columns understand why there is so much data missing.
- The column might only be filled under certain circumstances.  If two columns with complementary data have high percentage of missing values, they could be used to accurately impute data.
- Every column of data took work to collect and shows something possibly important. If you decide to drop the column, be clear about why and make sure you’ve thought it through!

#### Check missing value percentage per row
- If the entire row has no or very little data, dropping it might be better than filling the entire entry with imputed data later on. 
- Just make sure to question why the row is empty before dropping it!

#### Clean by variable type
- We want to make sure each column has the data we expect. 
- If you have many columns, it will be easier to go audit your variables by type (broadly): boolean, datetime, numerical (int/float), categorical and text.
a. Boolean: Standardise all boolean columns to have True/False as objects instead of other forms like Y/N or Yes/No.
b. Datetime: Convert the column to a datetime object and plot out the dates in a histogram to make sure it is within a logical range.
c. Numerical: Plot boxplots to get a snapshot of the distributions and see which variables have illogical max/min values that should be clipped. But before clipping, make sure you understand what the variables mean.
d. Categorical: Print all the unique variables for each categorical column and ensure that the values are as they should be. Otherwise, merge columns. If there are too many categories, consider grouping them to reduce complexity.





