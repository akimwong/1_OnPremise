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
# Three Critical Elements of Data Preprocessing
(The backbone of modeling in data science)

- Data preprocessing ensures that quality data is available to machine learning models resulting in excellent prediction performance. 

<p align="center">
  <img src="https://github.com/akimwong/1_OnPremise/blob/main/Journey/003/articles/summaries/DataPreprocessing1.png" width="400" height="400">
</p>

- It entails integration, cleaning, and transformation.

<p align="center">
  <img src="https://github.com/akimwong/1_OnPremise/blob/main/Journey/003/articles/summaries/DataPreprocessing2.png" width="550" height="300">
</p>

## 1. Data Integration
- Involves `exploiting the relationships between disparate datasets` by `combining them` using similar features as connection points.
- Data integration skills can help data scientists harness informative data available in `silos thereby creating more business value` from existing resources.

## 2. Data Cleaning

<p align="center">
  <img src="https://github.com/akimwong/1_OnPremise/blob/main/Journey/003/articles/summaries/DataPreprocessing3.png" width="500" height="300">
</p>

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

### 2.3. Tackling outliers
- Outliers are data points that exist outside the expected range of values for a given variable.
- All outliers `are not created equal. Some are simply noise` that distracts your machine-learning models, while `others are a representation of your data’s real-world attributes`.
- Eliminating a “good” outlier may jeopardize the data cleaning process and result in unrepresentative data models

### 2.4. Removal of wrong observations
- Some observations may be duplicated or corrupted. 
- Eliminating affected data points helps to avoid misrepresentation of the data patterns or issues such as overfitting during modeling.

## 3. Data Transformation

<p align="center">
  <img src="https://github.com/akimwong/1_OnPremise/blob/main/Journey/003/articles/summaries/DataPreprocessing4.png" width="500" height="300">
</p>

- Is the process of converting data into a suitable format or structure that best represents the data patterns and is amenable to model fitting.
- We can squeeze more juice out of the data if we properly apply transformations before modeling.
- Machine learning algorithms accept different data formats and types although numerical data is the most acceptable format. 
- The following data transformations are generally applicable and highly valuable for modeling in data science:

### 3.1. Feature Encoding
- This is the process of converting categorical data into numerical data. 
- Two main approaches exist namely, ordinal and one-hot encoding.
1. Ordinal encoding: In this case, the hierarchy in the categorical data is maintained after transformation. <br/>
2. One-hot encoding: This approach is used when there is no order in the categorical feature and it has few unique categories (low cardinality).

### 3.2. Discretization
- Continuous data may be better presented to an algorithm by creating class intervals that discretize the data. 
- For example, a set of age ranges (0–12: 0, 13 — 19: 1, 20–35: 2, 35+:4) may be created from continuous age data with the transformed data having better predictive power.
- In addition, `binarization is a special type of discretization` which involves assigning feature values to any of two groups namely zero or one. 
- The binarize tool in the Scikit-learn preprocessing module can be used for this operation.

### 3.3. Distribution Mapping
- Some machine learning algorithms perform better `when the input data has specific distributions` (e.g normal distribution). 
- Uniform mapping: This involves mapping the data to a uniform distribution with equally likely outcomes. 
- Gaussian mapping: The data is mapped as close as possible to a normal distribution with the mean, median, and mode being approximately the same. 
- Arguably, `it is not always a good idea to transform the data distribution` due to unintended effects such as masking the true behavior of the residuals. 

### 3.4. Data Scaling
- Ensures that features with different units and magnitude ranges are converted to the same scale to avoid misrepresentation of the data to the model.
- Standardization: This involves subtracting the mean and dividing by the standard deviation. It ensures that the data is centered around zero and scaled with respect to the standard deviation. 
- Normalization: This method ensures that the data values have a unit norm either for each observation or each feature. 
- Scaling to a range: Here, the data values for a given feature are mapped to a specific range. It typically involves subtracting by the mean and dividing by the difference between the min and max value of the feature. 

### 3.5. Data Reduction
- An excessive number of features may result in issues such as overfitting.
- We may need to reduce the number of features to efficiently build machine learning models while improving predictive performance.
- Multi-collinearity (where two or more independent features are highly correlated) is another reason why features may be pruned. It affects the model performance and interpretability of especially non-tree-based algorithms such as linear regression.
- Some methods for data reduction include:
1. Principal component analysis: This is a very useful method for mapping data features to a lower orthogonal dimensional space while preserving as much information in the data as possible.  However, the transformed features are not as interpretable as the original features. Hence, they may not be used in some applications.
2. Feature elimination: In this case, the least relevant features are dropped while keeping the features with the most predictive power.  The original features which are intuitive and mostly interpretable are used and this avoids the issue of interpretability encountered with PCA. 

-----------------------

# Fundamental Techniques of Feature Engineering for Machine Learning
(All required methods for comprehensive data preprocessing with Pandas examples)

## Introduction
- All machine learning algorithms use some input data to create outputs. 
- This input data comprise features, which are usually in the form of structured columns. 
- `Algorithms require features with some specific characteristic to work properly`. 
- Feature engineering efforts mainly have two goals: <br/>
A.	Preparing the proper input dataset, compatible with the machine learning algorithm requirements. <br/>
B. 	Improving the performance of machine learning models. <br/>
- `The features you use influence more than everything else the result`. 
- `No algorithm alone can supplement the information gain given by correct feature engineering`.
- I think the best way to achieve expertise in feature engineering is practicing different techniques on various datasets and observing their effect on model performances.

## 1.Imputation
- Missing values affect the performance of the machine learning models (might be human errors, interruptions in the data flow, privacy concerns, and so on).
- Some machine learning platforms automatically drop the rows which include missing values in the model training phase and it decreases the model performance because of the reduced training size. 
- On the other hand, most of the algorithms do not accept datasets with missing values and gives an error.
- The `most simple solution to the missing values is to drop the rows or the entire column`. 
- `There is not an optimum threshold` for dropping but you can use 70% as an example value and try to drop the rows and columns which have missing values with higher than this threshold.

### 1.1. Numerical Imputation
- Imputation is a more preferable option rather than dropping because it preserves the data size. 
- However, there is an important selection of what you impute to the missing values. 
- I suggest beginning with considering a possible default value of missing values in the column. 
- For example, if you have a column that only has 1 and NA, then it is likely that the NA rows correspond to 0. For another example, if you have a column that shows the “customer visit count in last month”, the missing values might be replaced with 0 as long as you think it is a sensible solution.
- Another reason for the missing values is joining tables with different sizes and in this case, imputing 0 might be reasonable as well.
- `Except for the case of having a default value for missing values, I think the best imputation way is to use the medians of the columns`. As the averages of the columns are sensitive to the outlier values, while `medians are more solid` in this respect.

### 1.2. Categorical Imputation
- Replacing the missing values with the maximum occurred value in a column is a good option for handling categorical columns. 
- But if you think the values in the column are distributed uniformly and there is not a dominant value, imputing a category like “Other” might be more sensible, because in such a case, your imputation is likely to converge a random selection.

## 2.Handling Outliers
- The best way to detect the outliers is to demonstrate the data `visually`. All other statistical methodologies are open to making mistakes, whereas `visualizing the outliers gives a chance to take a decision with high precision`.

### 2.1. Outlier Detection with Standard Deviation
- If a value has a distance to the average higher than x * standard deviation, it can be assumed as an outlier. 
- Then what x should be? There is no trivial solution for x, but `usually, a value between 2 and 4 seems practical`.
- Z-score (or standard score) standardizes the distance between a value and the mean using the standard deviation.

### 2.2. Outlier Detection with Percentiles
- You can assume a certain percent of the value from the top or the bottom as an outlier. 
- The key point is here to ' set the percentage value once again, and this depends on the distribution of your data as mentioned earlier`.
- A common mistake is using the percentiles according to the range of the data. In other words, if your data ranges from 0 to 100, your top 5% is not the values between 96 and 100. `Top 5% means here the values that are out of the 95th percentile of data`.

### 2.3. An Outlier Dilemma: Drop or Cap
- Another option for handling outliers is to cap them instead of dropping. 
- So you can keep your data size and at the end of the day, it might be better for the final model performance.
- On the other hand, `capping can affect the distribution of the data, thus it better not to exaggerate it`.

## 3.Binning

<p align="center">
  <img src="https://github.com/akimwong/1_OnPremise/blob/main/Journey/003/articles/summaries/FeatureEngineer1.png" width="700" height="180">
</p>

- Can be applied on both categorical and numerical data:
- `The main motivation of binning is to make the model more robust and prevent overfitting, however, it has a cost to the performance. 
- Every time you bin something, you sacrifice information and make your data more regularized. (Please see regularization in machine learning)
- The trade-off between performance and overfitting is the key point of the binning process`. 
- In my opinion, for numerical columns, except for some obvious overfitting cases, binning might be redundant for some kind of algorithms, due to its effect on model performance.
- However, `for categorical columns, the labels with low frequencies probably affect the robustness of statistical models negatively. Thus, assigning a general category to these less frequent values helps to keep the robustness of the model`. For example, if your data size is 100,000 rows, it might be a good option to unite the labels with a count less than 100 to a new category like “Other”.

## 4.Log Transform
- Logarithm transformation (or log transform) `is one of the most commonly used mathematical transformations in feature engineering`. 
- What are the benefits of log transform: <br/>
A. It helps to handle skewed data and after transformation, the distribution becomes more approximate to normal. <br/>
B. In most of the cases the magnitude order of the data changes within the range of the data. For instance, the difference between ages 15 and 20 is not equal to the ages 65 and 70. In terms of years, yes, they are identical, but for all other aspects, 5 years of difference in young ages mean a higher magnitude difference. This type of data comes from a multiplicative process and log transform normalizes the magnitude differences like that. <br/>
C. It also decreases the effect of the outliers, due to the normalization of magnitude differences and the model become more robust.
- A critical note: The `data you apply log transform must have only positive values, otherwise you receive an error`. Also, you can add 1 to your data before transform it. Thus, you ensure the output of the transformation to be positive.

## 5.One-hot encoding
- Is one of the most common encoding methods in machine learning. 
- This method spreads the values in a column to multiple flag columns and assigns 0 or 1 to them. 
- These binary values express the relationship between grouped and encoded column.
- This method changes your categorical data, which is challenging to understand for algorithms, to a numerical format and enables you to group your categorical data without losing any information. 
- Why One-Hot?: <br/>
A. If you have N distinct values in the column, it is enough to map them to N-1 binary columns, because the missing value can be deducted from other columns. <br/> 
B. If all the columns in our hand are equal to 0, the missing value must be equal to 1. This is the reason why it is called as one-hot encoding. <br/>

## 6.Grouping Operations
- In most machine learning algorithms, every instance is represented by a row in the training dataset, where every column show a different feature of the instance. This kind of data called “Tidy”.
- Tidy datasets are easy to manipulate, model and visualise, and have a specific structure: each variable is a column, each observation is a row, and each type of observational unit is a table.
- Datasets such as transactions rarely fit the definition of tidy data above, because of the multiple rows of an instance. In such a case, we group the data by the instances and then every instance is represented by only one row.
- `The key point of group by operations is to decide the aggregation functions of the features. For numerical features, average and sum functions are usually convenient options, whereas for categorical features it more complicated`.

### 6.1. Categorical Column Grouping
- I suggest three different ways for aggregating categorical columns: <br/> 
A. The first option is to `select the label with the highest frequency`. In other words, this is the max operation for categorical columns, but ordinary max functions generally do not return this value, you need to use a lambda function for this purpose. <br/> 
B. Second option is to make a `pivot table`. This approach resembles the encoding method in the preceding step with a difference. Instead of binary notation, it can be defined as aggregated functions for the values between grouped and encoded columns. This would be a good option if you aim to go beyond binary flag columns and merge multiple features into aggregated features, which are more informative. <br/> 
C. Last categorical grouping option is to `apply a group by function after applying one-hot encoding`. This method preserves all the data -in the first option you lose some-, and in addition, you transform the encoded column from categorical to numerical in the meantime. 

### 6.2. Numerical Column Grouping
- Numerical columns are grouped using sum and mean functions in most of the cases. 
- Both can be preferable according to the meaning of the feature. 
- For example, if you want to obtain ratio columns, you can use the average of binary columns. In the same example, sum function can be used to obtain the total count either.

## 7.Feature Split
- Splitting features is a good way to make them useful in terms of machine learning. 
- Most of the time the dataset contains string columns that violates tidy data principles. 
- By extracting the utilizable parts of a column into new features: <br/> 
A. We enable machine learning algorithms to comprehend them. <br/> 
B. Make possible to bin and group them. <br/> 
C. Improve model performance by uncovering potential information. <br/> 
- Split function is a good option, however, `there is no one way of splitting features. It depends on the characteristics of the column`, how to split it. 

## 8.Scaling
- In most cases, the numerical features of the dataset do not have a certain range and they differ from each other. 
- In real life, it is nonsense to expect age and income columns to have the same range. 
- But from the machine learning point of view, how these two columns can be compared?  `Scaling solves this problem. The continuous features become identical in terms of the range, after a scaling process. This process is not mandatory for many algorithms, but it might be still nice to apply. However, the algorithms based on distance calculations such as k-NN or k-Means need to have scaled continuous features as model input`.
- Basically, there are two common ways of scaling:

### 8.1. Normalization
- Normalization (or min-max normalization) `scale all values in a fixed range between 0 and 1`. 
- This transformation does not change the distribution of the feature and due to the decreased standard deviations, the effects of the outliers increases. 
- Therefore, `before normalization, it is recommended to handle the outliers`.

### 8.2. Standardization
- Standardization (or z-score normalization) scales the values while taking into account standard deviation. 
- If the standard deviation of features is different, their range also would differ from each other. 
- This reduces the effect of the outliers in the features.

## 9.Extracting Date
- Though `date columns usually provide valuable information about the model target`, they are neglected as an input or used nonsensically for the machine learning algorithms. 
- It might be the reason for this, that `dates can be present in numerous formats, which make it hard to understand by algorithms`, even they are simplified to a format like "01–01–2017".
- Building an ordinal relationship between the values is very challenging for a machine learning algorithm if you leave the date columns without manipulation. 
- Here, I suggest three types of preprocessing for dates: <br/> 
A. `Extracting` the parts of the date into different columns: Year, month, day, etc. <br/> 
B. `Extracting` the time period between the current date and columns in terms of years, months, days, etc. <br/> 
C. `Extracting` some specific features from the date: Name of the weekday, Weekend or not, holiday or not, etc. <br/> 

#### After this article, proceeding with other topics of data preparation such as feature selection, train/test splitting, and sampling might be a good option.
 
---------------------------
# 7 Techniques to Handle Imbalanced Data
(techniques that are commonly applied in domains like intrusion detection or real-time bidding, because the datasets are often extremely imbalanced)

## 1. Use the right evaluation metrics
If accuracy is used to measure the goodness of a model, a model which classifies all testing samples into “0” will have an excellent accuracy (99.8%), but obviously, this model won’t provide any valuable information for us.

- Precision/Specificity: how many selected instances are relevant.
- Recall/Sensitivity: how many relevant instances are selected.
- F1 score: harmonic mean of precision and recall.
- MCC: correlation coefficient between the observed and predicted binary classifications.
- AUC: relation between true-positive rate and false positive rate. 

## 2. Resample the training set
We can also work on getting different dataset

2.1. Under-sampling
- Balances the dataset by reducing the size of the abundant class. 
- This method is used when quantity of data is sufficient. 
- By keeping all samples in the rare class and randomly selecting an equal number of samples in the abundant class, a balanced new dataset can be retrieved for further modelling.
 
2.2. Over-sampling
- It tries to balance dataset by increasing the size of rare samples. 
- Rather than getting rid of abundant samples, `new rare samples are generated by using e.g. repetition, bootstrapping or SMOTE (Synthetic Minority Over-Sampling Technique)`.

Note that `there is no absolute advantage of one resampling method over another`. Application of these two methods depends on the use case it applies to and the dataset itself. A combination of over- and under-sampling is often successful as well. 

## 3. Use K-fold Cross-Validation in the Right Way
- Cross-validation should be applied properly while using over-sampling method to address imbalance problems.
- If cross-validation is `applied after over-sampling, basically what we are doing is overfitting` our model to a specific artificial bootstrapping result.
- That is why `cross-validation should always be done before over-sampling` the data, just as how feature selection should be implemented.

## 4. Ensemble Different Resampled Datasets
- The easiest way to successfully generalize a model is by using more data. 
- The problem is that out-of-the-box classifiers like `logistic regression or random forest tend to generalize by discarding the rare class`. 
- One easy best practice is `building n models that use all the samples of the rare class and n-differing samples of the abundant class`.

## 5. Resample with Different Ratios
- Instead of training all models with the same ratio in the ensemble, it is worth trying to ensemble different ratios.  
- So if 10 models are trained, it might make sense to have a model that has a ratio of 1:1 (rare:abundant) and another one with 1:3, or even 2:1. 
- Depending on the model used this can influence the weight that one class gets.

## 6. Cluster the abundant class
- Instead of relying on random samples to cover the variety of the training samples, he suggests clustering the abundant class in r groups, with r being the number of cases in r. 
- For each group, `only the medoid (centre of cluster 'centroide') is kept. The model is then trained with the rare class and the medoids only`. 

## 7. Design Your Models
- All the previous methods focus on the data and keep the models as a fixed component. 
- But in fact, there is no need to resample the data if the model is suited for imbalanced data. 
- The famous XGBoost is already a good starting point if the classes are not skewed too much, because it internally takes care that the bags it trains on are not imbalanced. But then again, the data is resampled, it is just happening secretly. 
- By designing a `cost function that is penalizing wrong classification of the rare class more than wrong classifications of the abundant class`, it is possible to design many models that naturally generalize in favour of the rare class. 
- For example, tweaking an SVM to penalize wrong classifications of the rare class by the same ratio that this class is underrepresented. 

There is `no best approach or model suited for all problems` and it is strongly recommended to `try different techniques and models` to evaluate what works best. Try to be creative and combine different approaches. It is also important, to `be aware that in many domains (e.g. fraud detection, real-time-bidding), where imbalanced classes occur`, the “market-rules” are constantly changing. So, check if past data might have become obsolete.

-----------------------
# Class Imbalance in Machine Learning Problems: A Practical Guide
(Five lessons from the trenches of applied data science)

## 1. Class imbalance is the norm, not the exception
Imbalance is simply part of the reality that we live in. In fact, the opposite is rare.
- in credit card fraud detection, most transactions are legitimate, and only a small fraction are fraudulent.
- in spam detection, it’s the other way around: most Emails sent around the globe today are spam.
- in ads conversion prediction, most users will ignore the ad, and only a small fraction will click on it.
- in user churn prediction, most users will stay on the platform, and only a small fraction will ‘churn’ (i.e., leave the platform).

## 2. Class imbalance itself is not the problem
When working on an imbalanced ML problem, there are 3 things can go wrong:

2.1. Choosing the wrong metric. 
`Accuracy is a bad metric` to quantify the performance of an ML model `on an imbalanced problem`: if the positivity rate is just 1%, then a naive classifier labeling everything as negative has 99% accuracy by definition. This sounds good on paper, but is bad in practice. This problem can of course be avoided by choosing a more suitable metric such as precision at fixed recall, recall at fixed precision, PR-AUC, or ROC-AUC.

2.2. Training/serving skew. 
This refers to the problem when the `data used for training the model is not the same as the data used at inference time`, for example because the `training data has been manually rebalanced`. The problem with training/serving skew is that the performance on the training data is not a good proxy for the performance at serving time, and the model may end up being worse than expected. For example, if at training time we down-sampled negatives by a factor of 10X, then, in the worst case, the precision in production may be 10X worse than expected.

2.3. Data scarcity. 
In imbalanced problems, it may be `hard to gather a sufficiently large number of labeled positive samples to train a ML model with reasonable performance`. For example, if you only have 10 to 100 positive samples, the model may easily memorize these samples, leading to an overfit model that generalized poorly. The more imbalanced the problem, the fewer positive samples you may have available for training the model.

## 3. Upsampling the minority class may not be a good idea
There are two reasons why upsampling can actually hurt model performance:

3.1. First, upsampling introduces training/serving skew.  When you then pick an operating point on the the training data, that `operating point may be sub-optimal in the real world`.  After upsampling the minority class in the training data, the log-loss on unseen data increased from 1.28 to 2.3, a notable degradation.  His conclusion: Your Dataset Is Imbalanced? Do Nothing!

3.2. Second, another potential problem with upsampling is data leakage: if you first upsample the data and then split the data into training and validation folds, `your model can simply memorize the positives from the training data and achieve artificially strong performance on the validation data, causing you to think that the model is much better than it actually is. If you have to upsample, always do it after splitting the data into training and validation folds, not before`.

## 4. Downsample the majority class with caution
There are two scenarios when you’ll want to consider doing this:

4.1. when the training data doesn’t fit into memory (and your ML training pipeline requires it to be in memory), or <br/>
4.2. when model training takes unreasonably long (days to weeks), causing too long iteration cycles, and preventing you from iterating quickly.

- When you downsample randomly, you may drop some of the most informative samples from the data, leading to worse model performance than if you hadn’t dropped anything.
- Instead of random downsampling, a better idea may therefore be a `domain filter`: a simple heuristic rule that cuts down most of the majority class, while keeping nearly all of the minority class. For example, if a rule can retain 99% of positives but only 1% of the negatives, this would make a great domain filter. Then, `apply that rule both at training time and at inference time prior to your ML model`. Here are some examples of good population filters:

a. in credit card fraud prediction, filter for new credit cards, i.e. those without a purchase history. <br/>
b. in spam detection, filter for Emails from addresses that haven’t been seen before.  <br/>
c. in e-commerce product classification, filter for products that contain a certain keyword, or combination of keywords.  <br/>
d. in ads conversion prediction, filter for a certain demographic segment of the user population.  <br/>

- Coming up with a good domain filter `requires domain knowledge`, so a good tip is to `source ideas from the program stakeholders, who know the problem domain best, and then validate these ideas on the data`.

## 5. Hyperparameters should be the last thing to experiment with

- If the model performance is acceptable, deploy the model into production as soon as possible, so that you can confirm that the modeling pipeline is actually working, and that the performance is as expected. 
- If the model performance is not acceptable, instead of tuning hyperparameters, a better use of your time may be to invest in data quality: collect more training data, construct better features, and make sure the labels are correct.

#### There are numerous techniques for class imbalance that I did not cover here, but `in practice oftentimes the highest-leverage thing you can do is stick to the simplest methods and deploy your model as soon as possible`.

---------------------------------
## 7 of the Most Used Feature Engineering Techniques
(Hands-on Feature Engineering with Scikit-Learn, Tensorflow, Pandas and Scipy)

## Introduction
- `The quality of the data, as well as the proper preparation of the data set features, have a greater impact on the success of a machine learning model than any other part of the ML pipeline`

<p align="center">
  <img src="https://github.com/akimwong/1_OnPremise/blob/main/Journey/003/articles/summaries/FeatureEngineer2.PNG" width="700" height="180">
</p>
