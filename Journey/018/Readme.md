# Random Forest

## 1. Description

Random Forest is a popular machine learning algorithm that falls under the category of ensemble learning methods. It is a combination of decision trees and bagging (bootstrap aggregating) techniques.

In random forest, multiple decision trees are built using bootstrapped samples of the training data set. Each tree is built by selecting a random subset of features to split at each node. The final prediction is made by averaging the predictions of all the individual trees in the forest.

Random Forest is a powerful algorithm that can be used for both classification and regression tasks. Some of its key advantages are:

    It can handle large data sets with high dimensionality.
    It is less `prone to overfitting` than decision trees.
    It can `provide feature importance ranking`, which can be used to identify the most relevant features in the data set.
    It can handle both categorical and numerical features.

Random Forest has some <b>limitations</b> as well. The main ones are:

    It is a `black box model`, which makes it difficult to interpret the results.
    It may `not perform well on imbalanced data` sets, where one class is much more prevalent than the other.
    It may `not work well on data sets with high levels of multicollinearity`.

## 2. Hiperparámetros:
    
1. n_estimators: El número de árboles en el bosque. A medida que se incrementa este valor, el rendimiento mejora, pero también aumenta el tiempo de entrenamiento y la memoria necesaria.
2. criterion: La función de medición de calidad de la división. Los dos criterios disponibles son “gini” para el índice Gini y “entropy” para la ganancia de información. Por defecto, se utiliza Gini.  Si el tiempo de ejecución es una preocupación importante, se puede utilizar la medida Gini para el criterio de selección de características. Si la precisión de clasificación es una prioridad, la entropía puede proporcionar mejores resultados, aunque a costa de un mayor tiempo de ejecución.
3. max_depth: La profundidad máxima del árbol. Si no se define, los nodos se expandirán hasta que todas las hojas contengan menos de min_samples_split muestras.
4. min_samples_split: El número mínimo de muestras necesarias para dividir un nodo interno.
5. min_samples_leaf: El número mínimo de muestras que deben contener las hojas finales del árbol. Si el número de muestras es menor que este valor, no se dividirá y se considerará una hoja.
6. max_features: El número máximo de características que se considerarán para cada división. Si es “auto”, entonces max_features = sqrt(n_features).
7. max_leaf_nodes: El número máximo de hojas en el árbol. Si no se define, entonces no hay límite en el número de hojas.
8. bootstrap: Si se utiliza bootstrap (true por defecto) o no (false). Si se establece en False, todas las muestras se utilizarán para construir cada árbol.
9. oob_score: Si se utiliza el error de fuera de bolsa para estimar la precisión generalizada (false por defecto).
10. n_jobs: El número de trabajos en paralelo para la construcción de árboles. Si se establece en -1, se utilizarán todos los núcleos disponibles.

Ejemplo: <br/>

param_grid = {  <br/>
<p>'n_estimators': [100, 200, 300], </p>
<p>'max_depth': [10, 20, 30],  </p>
        'min_samples_split': [2, 4, 6], <br/>
        'min_samples_leaf': [1, 2, 4],  <br/>
        'criterion': ['gini', 'entropy'] <br/>
}
