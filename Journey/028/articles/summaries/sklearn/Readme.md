# 7 Scikit-Learn Best Practices For Data Scientists
(Tips for taking full advantage of this machine learning package)

## 1. Use Scikit Learn (and not Pandas) for feature engineering
- While the `Pandas library is excellent for conducting exploratory data analysis`, it can not compare to Scikit Learn in the machine learning space.
- The `transformers` in Scikit Learn are designed for `machine learning applications`.
- `Shoehorning Pandas functions into a data pipeline with other Scikit Learn tools will inevitably lead to inefficient procedures that are prone to error`.

## 2. Use stratified splits in classification tasks
- When the data of interest exhibits data imbalance, where one or more classes are underrepresented, with stratification, users can maintain the presence of all classes in every subset of the original data.
- When splitting the dataset into train and test sets, users can use the stratify parameter.
- When splitting the training data into `multiple folds for cross-validation, users can use the StratifiedKFold class`.
