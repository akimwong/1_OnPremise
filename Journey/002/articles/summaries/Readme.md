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
- If you have many columns, it will be easier to go audit your variables by type (broadly): boolean, datetime, numerical (int/float), categorical and text. <br/>
a. Boolean: Standardise all boolean columns to have True/False as objects instead of other forms like Y/N or Yes/No.<br/>
b. Datetime: Convert the column to a datetime object and plot out the dates in a histogram to make sure it is within a logical range. <br/>
c. Numerical: Plot boxplots to get a snapshot of the distributions and see which variables have illogical max/min values that should be clipped. But before clipping, make sure you understand what the variables mean. <br/>
d. Categorical: Print all the unique variables for each categorical column and ensure that the values are as they should be. Otherwise, merge columns. If there are too many categories, consider grouping them to reduce complexity. <br/>
e. Text: Sometimes you’ll get data in text form that is sort of standardised but mostly a whole mess of different inputs. As much as possible use regex to standardise the entries, and then we can reduce the number of unique values with CHAID (Chi-square Automatic Interaction Detector). <br/>

#### Impute missing data
- Fill the missing data based on other values in the column
- If the column has skewed data, take the median (numerical) or mode (non-numeric) so that you are drawing from the majority and don’t end up shifting the distribution. 
- If the column has unskewed data, take the mean for the same reasons!
- Another method is called iterative imputation, sequentially using the data from each feature to fill in the missing data
- With categorical or text data, you could also treat missing data as a category of data by replacing np.nan with ‘MISSING’. Perhaps the very fact that the data is missing might be predictive in itself.

#### Encode non-numeric data
- If you have ordinal (ordered) data, you can use label encoding which converts an alphabetically sorted category into a sequence of numbers. [‘A’, ‘B’, ‘C’] = [1,2,3].
- This works best when the order corresponds with the increasing value of the numbers for example: [‘short’, ‘average’, ‘tall’] = [1,2,3]. But when applied to non-ordered data like: [‘apple’, ‘pear’, ‘banana’]=[1,2,3], the model gets the sense that banana > pear > apple, which is not true!
- Instead, we use one-hot encoding which converts numbers into vectors. So data like: [‘apple’, ‘pear’, ‘banana’] = [[0,0,1],[0,1,0],[1,0,0]]. However, where there is high cardinality (many unique values), these vectors will become very large and take up a lot of memory, so be wary.

#### Ready for modelling!
This was by no means an exhaustive guide for all you could do to clean data. There are more steps you could do depending on your dataset, but this is a pipeline I found helpful at least to start.

# Why Data Quality Is Harder than Code Quality
- Code quality is the process of ensuring code meets expectations. 
- Data quality is the process of ensuring data meets expectations.

#### Why is detecting data quality issues hard?
- Most data repositories will be several orders of magnitude bigger than any code repository. 
- On top of that, you can deploy code up to a few times per day, but data can get updated in milliseconds. 
- With more data changes, there is also a higher chance that you will experience a data quality issue.
- There are three main ways to detect a data quality issue: <br/>
a. A business user reports an issue. <br/>
b. A data test fails. <br/>
c. Data monitoring raises an alert. <br/>

#### Testing data vs. testing code
....

# Classification Metrics Walkthrough: Logistic Regression with Accuracy, Precision, Recall, and ROC
- Classification is about predicting a label and then identifying which category an object belongs to based on different parameters.
- In order to measure how well our classification model is doing at making these predictions, we use classification metrics. 

#### Problems with the threshold
- Using the threshold concept of values above the threshold value tend to be 1, and a value below the threshold value tends to be 0 can cause challenges.
- Although there is the option to adjust the threshold value, it still raises the risk that we classify incorrectly.

#### 1. Accuracy
accuracy = correct_predictions / total_predictions

However, we can further expand on this using these:

    True Positive (TP) - you predicted positive and it’s actually positive 
    True Negative (TN) - you predicted negative and it’s actually negative
    False Positive (FP) - you predicted positive and it’s actually negative
    False Negative (FN) - you predicted negative and it’s actually positive  

So we can say the true predictions are TN+TP, while the false prediction is FP+FN. The equation can now be redefined as:
 
