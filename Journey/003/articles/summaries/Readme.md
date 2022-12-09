# Which Feature Engineering Techniques improve Machine Learning Predictions?
### 1. Imputation
- This is a method by that we fill in the missing values in the data.
- We might either fill the missing values with the mean or the average of the feature.
- There are other methods such as median imputation and mode imputation of the features.

### 2. Scaling
- The features that we are using can have different scales when we initially receive the data.
- We cannot compare the 2 features as the number of bedrooms is measured in units while the interest rates are measured in dollars ($) respectively.
- It is important to perform the scaling operations of the features before giving them to the models for prediction.

### 3. Normalization
- We ensure that the features have a minimum value of 0 and a maximum value of 1
- This would ensure that we are able to produce the best results with our models and get good predictions.

### 4. Standardization
- Is similar to normalization in converting the features except that we transform the data in such a way that we get an output that has unit variance and zero mean for each and every individual feature.

### 5. One Hot Encoding
- For a scenario where there are a large number of categorical features in our data.
- Categorical features should be converted to numerical features for the models to perform the computation
- It would simply consider each of the categories per feature as an individual column.
- The presence or absence of a particular category would be either marked a 1 or a 0.

### 6. Response Coding
- Quite similar to one hot encoding.
- We are mostly interested in the mean value of our target per category.
- In order to predict the housing prices per various localities, we would be grouping the localities and finding the mean house price per locality.
- Later, we would be replacing locality with that specific mean house price per locality to represent the numerical value which was earlier a categorical feature.

### 7. Handling Outliers
- Some outliers in the data can be quite useful and important for the model to rightly determine the outcome.
- We would have to take the right steps to ensure that we remove them before training the models and putting them into production.
- If the data points lie 3 standard deviations above or below the mean, we can automatically classify them as outliers and remove them so that they would not affect the machine learning model predictions.

### 8. Log Transformation
- Could be used when we find that there is a heavy skew in the data.
- Log transformation can be a handy feature engineering technique that boosts the performance of ML models respectively.

### Conclusion
Using the best feature engineering techniques at the right time can be truly handy and generate valuable predictions for companies to use as a result of using artificial intelligence.

# Standardization vs Normalization

## Standardization
- Standardization or Z-Score Normalization is one of the feature scaling techniques.
- Transformation of features is done by subtracting from the mean and dividing by standard deviation. 
- This is often called Z-score normalization. 
- The resulting data will have the mean as 0 and the standard deviation as 1.

## Normalization
- It transforms features by subtracting from the minimum value of the data and dividing by (maximum minus minimum).

## Observations:

- The resulting data after standardization will have a mean of 0 and a standard deviation of 1, whereas the resulting data after min-max scaling will have a minimum value as0 and a maximum value of 1 (Here the mean and standard deviation can be anything).
- The scatter plots and KDE plots above show that there will be no change in the distribution of data before and after applying the standard scaler or min-max scaler, only the scale changes.
- The feature scaling step has to be performed while applying algorithms where distance gets calculated (Eg: KNN, KMEANS) and involves gradient descent (Eg: Linear and Logistic regressions, neural networks).
- There will not be any effect of scaling when we use tree-based algorithms like decision trees or random forests.
- In the above examples, the accuracy of Logistic regression and KNN increased significantly after scaling. But there was no effect on accuracy when the decision tree or random forest was used.
- Outliers in the dataset will still remain an outlier even after applying the feature scaling methods, as data scientists, it is our responsibility to handle the outliers.
- There is no hard rule to tell which technique to use, but we need to check both standardization and normalization and decide based on the result which one to use.
