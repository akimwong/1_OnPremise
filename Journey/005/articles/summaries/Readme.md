# 7 Scikit-Learn Best Practices For Data Scientists
(Tips for taking full advantage of this machine learning package)

## 1. Use Scikit Learn (and not Pandas) for feature engineering
- The transformers in Scikit Learn are designed for machine learning applications. 
- They can prepare training and testing sets efficiently while avoiding data leakage (if done properly).

## 2. Use stratified splits in classification tasks
- Classification tasks can be challenging when the data of interest exhibits data imbalance, where one or more classes are underrepresented.
- Fortunately, with `stratification`, users can maintain the presence of all classes in every subset of the original data.
- When splitting the dataset into train and test sets, users can use the stratify parameter.
- When splitting the training data into multiple folds for cross-validation, users can use the StratifiedKFold class.

## 3. Speed up hyperparameter tuning with the n_jobs parameter
- Hyperparameter tuning can be one of the more time-consuming parts of the data modeling phase. 
- Evaluating multiple combinations of hyperparameters one at a time will naturally be a slow process.
- Fortunately, users can speed up hyperparameter tuning methods like grid search and random search by leveraging the `n_jobs` parameter, which determines the number of jobs to run in parallel. 
- By default, the n_jobs value is set to 1, but users can attain results much faster by assigning `n_jobs to -1`, which `runs jobs parallelly with the use of all available processors`.

## 4. Assign a random_state value to attain reproducible results
- A number of feature engineering procedures and machine learning algorithms incorporate `randomness`. 
- However, a program that utilizes pure randomness `will be unable to reproduce its results`, which makes it difficult to conduct experiments.
- Users can attain reproducible results by setting a seed to the random number generator. 
- For Scikit Learn tools, this is done by assigning a value to the `random_state` parameter to an object when applicable. 
- This ensures that the `program will yield reproducible results`.
- Users can set a random_state value when performing operations such as:

1. splitting a dataset into training and testing sets
2. configuring a machine learning classifier object
3. hyperparameter tuning <br/>

Note: The number assigned to the random_state parameter doesn’t really matter as long as it isn’t changed during the experimentation.

## 5. Specify the scoring parameter in hyperparameter tuning
- How can models perform well when they are evaluated with the wrong metric? 
- This is a very possible outcome when you use the default value for the scoring parameter in the Scikit Learn module’s GridSearchCV and RandomizedSearchCV objects.
- By default, the grid search and random search evaluates hyperparameters of classification models by accuracy. 
- Unfortunately, this is rarely the suitable metric for a machine learning application.
- To avoid this, `identify the most fitting evaluation metric for the model of interest and assign it to the scoring parameter`. 
- One can find the list of available metrics in the package’s [documentation](https://scikit-learn.org/stable/modules/model_evaluation.html).
- If none of the provided metrics are suitable, one can also create their own custom metric with the make_scorer function. 
- This is a useful feature when users favor one type of error over another.

## 6. Transform data with pipelines
- Beginners starting out with Scikit Learn might be used to carrying one transformation at a time. 
- This approach entails using the fit and transform methods multiple times on the training and testing set.
- Transforming data in this manner requires many lines of code and can easily lead to mistakes (e.g., using fit on the testing set). 
- So, you will be glad to know that Scikit Learn offers a tool that facilitates these operations with much greater ease: `the pipeline`.
- The `Scikit Learn pipeline` is a tool that chains together a series of transformations and estimators, enabling users to execute operations with code that is easier to write, read, and debug.

## 7. Get familiar with other packages compatible with Scikit Learn
- In the end, the Scikit Learn package’s wide range of tools can not account for every case imaginable.
- Thus, it is worth it to familiarize oneself with other packages that are compatible with Scikit Learn. 
- These packages contain tools that can be used together with Scikit Learn for feature engineering and data modeling.
- Two noteworthy examples are the `feature_engine` and `XGBoost packages`, which boast their own unique transformers and machine learning algorithms that can be used with other Scikit Learn tools.






