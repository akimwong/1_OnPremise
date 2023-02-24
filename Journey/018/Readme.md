# Random Forest

## 1. Description

Random Forest is a popular machine learning algorithm that falls under the category of ensemble learning methods. It is a combination of decision trees and bagging (bootstrap aggregating) techniques.

In random forest, multiple decision trees are built using bootstrapped samples of the training data set. Each tree is built by selecting a random subset of features to split at each node. The final prediction is made by averaging the predictions of all the individual trees in the forest.

Random Forest is a powerful algorithm that can be used for both classification and regression tasks. Some of its key advantages are:

    It can handle large data sets with high dimensionality.
    It is less prone to overfitting than decision trees.
    It can provide feature importance ranking, which can be used to identify the most relevant features in the data set.
    It can handle both categorical and numerical features.

Random Forest has some limitations as well. The main ones are:

    It is a black box model, which makes it difficult to interpret the results.
    It may not perform well on imbalanced data sets, where one class is much more prevalent than the other.
    It may not work well on data sets with high levels of multicollinearity.

## Hiperparámetros:
    
1. n_estimators: número de árboles que se deben crear en el bosque.
2. criterion: criterio utilizado para medir la calidad de una división. Puede ser "gini" o "entropy".
3. max_depth: profundidad máxima de cada árbol.
4. min_samples_split: número mínimo de muestras necesarias para dividir un nodo interno.
5. min_samples_leaf: número mínimo de muestras necesarias en cada hoja.
6. max_features: número máximo de características a considerar en cada división.

