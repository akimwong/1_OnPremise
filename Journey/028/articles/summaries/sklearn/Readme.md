# 7 Scikit-Learn Best Practices For Data Scientists
(Tips for taking full advantage of this machine learning package)

## 1. Use Scikit Learn (and not Pandas) for feature engineering
- While the `Pandas library is excellent for conducting exploratory data analysis`, it can not compare to Scikit Learn in the machine learning space.
- The `transformers` in Scikit Learn are designed for `machine learning applications`.
- `Shoehorning Pandas functions into a data pipeline with other Scikit Learn tools will inevitably lead to inefficient procedures that are prone to error`.

## 2. Use stratified splits in classification tasks
- `When the data of interest exhibits data imbalance, where one or more classes are underrepresented`, with stratification, users can maintain the presence of all classes in every subset of the original data.
- When splitting the dataset into train and test sets, users can use the stratify parameter.
- When splitting the training data into `multiple folds for cross-validation, users can use the StratifiedKFold class`.

## 3. Speed up hyperparameter tuning with the n_jobs parameter
- Users can speed up hyperparameter tuning methods like grid search and random search by leveraging the n_jobs parameter, which determines the number of jobs to run in parallel. 
- By default, the n_jobs value is set to 1, but users can attain results much faster by assigning `n_jobs to -1, which runs jobs parallelly with the use of all available processors`.

## 4. Assign a random_state value to attain reproducible results
- This ensures that the program will yield reproducible results.
- Users can set a random_state value when performing operations such as:
1.	splitting a dataset into training and testing sets
2.	configuring a machine learning classifier object
3.	hyperparameter tuning
- The number assigned to the random_state parameter doesn’t really matter as long as it isn’t changed during the experimentation.

## 5. Specify the scoring parameter in hyperparameter tuning
- `How can models perform well when they are evaluated with the wrong metric?` This is a very possible outcome when you use the default value for the scoring parameter in the Scikit Learn module’s `GridSearchCV` and `RandomizedSearchCV` objects.
- `By default`, the grid search and random search evaluates hyperparameters of classification models by `accuracy`. Unfortunately, this is rarely the suitable metric for a machine learning application.
- To avoid this, identify the most fitting evaluation metric for the model of interest and assign it to the scoring parameter. 

## 6. Transform data with pipelines
- The Scikit Learn pipeline is a tool that chains together a series of transformations and estimators, enabling users to execute operations with code that is easier to write, read, and debug.
- All the transformations and modeling in the pipeline object can be executed on a training set with just a single fit method. 
- Moreover, the `same transformations can be applied prior to generating predictions` from the testing set using a single `predict method`.

## 7. Get familiar with other packages compatible with Scikit Learn
- It is worth it to familiarize oneself with other packages that are compatible with Scikit Learn. 
- These packages contain tools that can be used together with Scikit Learn for feature engineering and data modeling.
- Two noteworthy examples are the `feature_engine and XGBoost packages`, which boast their own unique transformers and machine learning algorithms that can be used with other Scikit Learn tools.
