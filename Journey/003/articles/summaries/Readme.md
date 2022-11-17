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

### 5. One Hot Encodi.
ng
- For a scenario where there are a large number of categorical features in our data.
- Categorical features should be converted to numerical features for the models to perform the computation
- It would simply consider each of the categories per feature as an individual column.
- The presence or absence of a particular category would be either marked a 1 or a 0.

### 6. Response Coding
- Quite similar to one hot encoding.
- 



