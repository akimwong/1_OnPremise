# 1. Feature Encoding
- This is the process of converting categorical data into numerical data. 
- Two main approaches exist namely, ordinal and one-hot encoding.
1. Ordinal encoding: In this case, the hierarchy in the categorical data is maintained after transformation. <br/>
2. One-hot encoding: This approach is used when there is no order in the categorical feature and it has few unique categories (low cardinality).

# 2. Discretization
- Continuous data may be better presented to an algorithm by creating class intervals that discretize the data. 
- For example, a set of age ranges (0–12: 0, 13 — 19: 1, 20–35: 2, 35+:4) may be created from continuous age data with the transformed data having better predictive power.
- In addition, `binarization is a special type of discretization` which involves assigning feature values to any of two groups namely zero or one. 
- The binarize tool in the Scikit-learn preprocessing module can be used for this operation.

# 3. Distribution Mapping
- Some machine learning algorithms perform better `when the input data has specific distributions` (e.g normal distribution). 
- Uniform mapping: This involves mapping the data to a uniform distribution with equally likely outcomes. 
- Gaussian mapping: The data is mapped as close as possible to a normal distribution with the mean, median, and mode being approximately the same. 
- Arguably, `it is not always a good idea to transform the data distribution` due to unintended effects such as masking the true behavior of the residuals. 

# 4. Data Scaling
- Ensures that features with different units and magnitude ranges are converted to the same scale to avoid misrepresentation of the data to the model.
- Standardization: This involves subtracting the mean and dividing by the standard deviation. It ensures that the data is centered around zero and scaled with respect to the standard deviation. 
- Normalization: This method ensures that the data values have a unit norm either for each observation or each feature. 
- Scaling to a range: Here, the data values for a given feature are mapped to a specific range. It typically involves subtracting by the mean and dividing by the difference between the min and max value of the feature. 

# 5. Data Reduction
- An excessive number of features may result in issues such as overfitting.
- We may need to reduce the number of features to efficiently build machine learning models while improving predictive performance.
- Multi-collinearity (where two or more independent features are highly correlated) is another reason why features may be pruned. It affects the model performance and interpretability of especially non-tree-based algorithms such as linear regression.
- Some methods for data reduction include:
1. Principal component analysis: This is a very useful method for mapping data features to a lower orthogonal dimensional space while preserving as much information in the data as possible.  However, the transformed features are not as interpretable as the original features. Hence, they may not be used in some applications.
2. Feature elimination: In this case, the least relevant features are dropped while keeping the features with the most predictive power.  The original features which are intuitive and mostly interpretable are used and this avoids the issue of interpretability encountered with PCA. 
