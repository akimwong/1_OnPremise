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


------------------------------
# Standardization vs Normalization

## Standardization
- Standardization or Z-Score Normalization is one of the feature scaling techniques.
- Transformation of features is done by subtracting from the mean and dividing by standard deviation. 
- This is often called Z-score normalization. 
- The resulting data will have the `mean as 0 and the standard deviation as 1`.

## Normalization
- It transforms features by subtracting from the minimum value of the data and dividing by (maximum minus minimum).

## Observations:

- The resulting data after standardization will have a mean of 0 and a standard deviation of 1, whereas the resulting data after min-max scaling will have a minimum value as0 and a maximum value of 1 (Here the mean and standard deviation can be anything).
- The scatter plots and KDE plots above show that there will be no change in the distribution of data before and after applying the standard scaler or min-max scaler, only the scale changes.
- The feature scaling step has to be performed while applying algorithms where distance gets calculated (Eg: KNN, KMEANS) and involves gradient descent (Eg: Linear and Logistic regressions, neural networks).
- There will not be any effect of scaling when we use tree-based algorithms like decision trees or random forests.
- In the above examples, the accuracy of Logistic regression and KNN increased significantly after scaling. But there was no effect on accuracy when the decision tree or random forest was used.
- `Outliers in the dataset will still remain an outlier` even after applying the feature scaling methods, as data scientists, it is our responsibility to handle the outliers.
- There is no hard rule to tell which technique to use, but `we need to check both standardization and normalization and decide based on the result which one to use`.

------------------------------
# Fundamental Processes in Feature Engineering
(Presenting data patterns to models the right way)

Feature engineering is the process of modifying existing features to enhance the ability of a model to learn from the data.

## 1. Feature Extraction
- This is the process of generating new features from existing ones. 
- It is `highly domain-specific` and `relies heavily on your knowledge of the subject area`. 
- Many ML models work with `numerical data`, data consisting of integers or decimals. Hence, we `need to encode the raw categorical data`, data consisting of strings to make them usable to the models.

## 2. Feature Selection
- This is the process of `choosing` the `most relevant features` for the training process. 
- Feature selection methods fall under three main categories namely wrapper, filter, and embedded methods.
- Some measures of a feature’s relevance include:

#### 2.1. Correlation analysis 
- (Correlation coefficient) Measures the `relationship between two variables and takes a value between -1 and +1`. 
- In feature selection, features having a higher correlation with the target variable are chosen because they have a higher predictive power.

#### 2.2. Feature importance 
- Some tree methods such as random forests and gradient-boosting algorithms provide feature importance scores that show the effect of each feature on the target prediction. -
- These scores may be used the choose the most relevant features. 

#### 2.3. Mutual information
- Measures the reduction in the uncertainty of one variable based on the knowledge of another variable. 
- A reduction in uncertainty results from having more information about the variable. 
- Features with high mutual information scores are considered more relevant and are chosen for ML modeling. 

## 3. Feature Projection
- It typically involves `reducing the number of features` fed to an ML algorithm.
- There are two main classes of feature projection techniques:

#### 3.1. Linear projection
- These methods employ a linear combination of the features and do not capture interactions between two or more features. 
- Some examples include linear discriminant analysis (LDA) and principal component analysis (PCA). 

#### 3.2. Non-linear projection
- These methods are more complex and described by non-linear equations. 
- Some examples include kernel principal component analysis (KPCA) and principal curves. 

-------------------------
# Three Critical Elements of Data Preprocessing — Part 1
(The backbone of modeling in data science)

- Data preprocessing ensures that quality data is available to machine learning models resulting in excellent prediction performance. 
- It entails integration, cleaning, and transformation.

## 1. Data Integration
- Involves `exploiting the relationships between disparate datasets` by `combining them` using similar features as connection points.
- Data integration skills can help data scientists harness informative data available in `silos thereby creating more business value` from existing resources.

## 2. Data Cleaning
- This is the process of identifying and removing or correcting duplicated, corrupted, and missing data from a collected dataset.
- Improves the quality of data fed to machine learning algorithms and can make or break a data science project.
- Generating cleaner data is better than spending more computing power and time tuning sophisticated algorithms.
- Consists of the following tasks:

### 2.1. Correcting structural errors
- This involves identifying and fixing inconsistencies in the data. 
- For example, categorical features may be labeled with different capitalization (Male vs male) or target variables may be assigned to the wrong class.

### 2.2. Handling missing values
- `Depending on the prevalence and type` of missing values being dealt with, missing values `may be estimated` or affected observations (examples) `may be removed`.
- Based on experience, `dropping observations` when the percentage of missing values is `“very small” (say < 5%) compared with overall available data`. 
- Similarly, `features with more than 95%` of the data missing `may be dropped` although these are hard not thresholds and can be changed based on domain knowledge.
