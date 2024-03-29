
# 1. Modelos de Regresión

## 1.1. MSE: Mean squared error (Error cuadrático medio)
- Mide el promedio de los errores cuadráticos entre las predicciones del modelo y los valores reales de la variable de respuesta. 
- Objetivo: Minimizar (las predicciones del modelo están más cercanas a los valores reales).
- Esta métrica es especialmente útil cuando se desea penalizar más los errores grandes que los pequeños. 
- (junto con RMSE) es de las métricas más comunes que se usan 

## 1.2. RMSE: Root mean squared error (raíz cuadrada del MSE)
- Mide la desviación entre los valores observados y los valores predichos por el modelo. 
- Objetivo: Minimizar
- RMSE es una medida de la magnitud de los errores de predicción del modelo <b>en las mismas unidades que la variable de respuesta</b>. 
- Se utiliza para expresar el error en la misma unidad que la variable de salida y para facilitar la interpretación de la calidad de la predicción.
- If your response variable units are dollars, the units of MSE are dollars-squared, but the RMSE will be in dollars.

## 1.3. MAE: Mean absolute error. 
- Media de las diferencias absolutas entre las predicciones del modelo y los valores reales observados.  Esto significa que, para cada punto de datos, se toma la diferencia absoluta entre la predicción del modelo y el valor real observado, y luego se calcula la media de esas diferencias absolutas.
- Mide la magnitud promedio de los errores en la predicción del modelo, sin tener en cuenta la dirección de los errores (es decir, si la predicción es demasiado alta o demasiado baja).
- Similar a MSE, pero en lugar de elevar al cuadrado, solo toma la diferencia media absoluta entre los valores reales y predichos.  Esto resulta en menos énfasis en errores más grandes en comparación con MSE.
-  Es útil en cualquier caso en el que se esté interesado en minimizar la diferencia absoluta promedio entre los valores reales y los valores predichos
- Objetivo: Minimizar

## 1.4. RMSLE: Root mean squared logarithmic error. 
- Compara el logaritmo de las predicciones con el logaritmo de los valores reales. 
- Luego, se calcula la diferencia cuadrática media de estos logaritmos. 
- La razón detrás del uso de los logaritmos es que los errores relativamente grandes en valores pequeños y los errores relativamente pequeños en valores grandes pueden tener un efecto similar en la medida de evaluación. 
- Al tomar los logaritmos de los valores, se reduce la influencia de los valores extremos en la medida de evaluación. 
- Objetivo: Minimizar (cuanto más cercano a cero, mejor es el modelo).
- Algunos ejemplos de casos de uso de RMSLE son la predicción de precios de bienes raíces, la predicción de ventas de productos de alto valor y la predicción de ingresos anuales de empresas.

## 1.5. R2
- Medida de qué tan bien los valores predichos por un modelo de regresión lineal se ajustan a los valores reales de la variable de respuesta. 
- El valor de R2 varía de 0 a 1, donde un valor de 1 indica una perfecta ajuste del modelo a los datos.
- Para calcular R2, se compara la variabilidad explicada por el modelo con la variabilidad total de los datos. 
- La variabilidad explicada se refiere a la cantidad de variación en la variable de respuesta que puede ser explicada por las variables predictoras en el modelo, mientras que la variabilidad total es la cantidad total de variación en la variable de respuesta.
- Se calcula como la proporción de la variabilidad explicada por el modelo sobre la variabilidad total. 
- Un valor de R2 cercano a 1 indica que el modelo explica la mayor parte de la variabilidad en los datos, mientras que un valor cercano a 0 indica que el modelo no explica la variabilidad en los datos mejor que simplemente usar la media de la variable de respuesta como predicción.
- Este es un métrica popular que representa la proporción de la varianza en la variable dependiente que es predecible a partir de la(s) variable(s) independiente(s). 
- Desafortunadamente, tiene varias limitaciones. Por ejemplo, dos modelos construidos a partir de dos conjuntos de datos diferentes podrían tener el mismo RMSE exacto, pero si uno tiene menos variabilidad en la variable de respuesta, entonces tendría un R2 más bajo que el otro. No se debe hacer demasiado énfasis en esta métrica.
- R2 no indica si el modelo es teóricamente sólido o no, ni si los coeficientes son estadísticamente significativos o no. Además, el R2 puede ser engañoso si se utiliza en situaciones en las que las variables independientes están altamente correlacionadas entre sí o si el modelo es inadecuado para los datos. Por lo tanto, <b> es importante utilizar el R2 junto con otras métricas y análisis para evaluar la calidad de un modelo de regresión </b>


# 2. Modelos de Clasificación

## 2.1. Exactitud (Accuracy)
- Mide la proporción de ejemplos que fueron correctamente clasificados por el modelo en comparación con el número total de ejemplos en el conjunto de datos.
- Es una métrica útil para problemas de clasificación balanceados donde todas las clases tienen aproximadamente el mismo número de ejemplos. 
- Sin embargo, puede ser engañosa si las clases están desequilibradas en términos de cantidad de ejemplos.

## 2.2. Precisión (Precision)
- Mide la proporción de ejemplos que fueron correctamente clasificados como positivos (es decir, verdaderos positivos) en comparación con el número total de ejemplos que el modelo clasificó como positivos (tanto verdaderos positivos como falsos positivos). 
- Es útil en problemas donde el costo de un falso positivo es alto.

## 2.3. Sensibilidad o tasa de verdaderos positivos (Recall o True Positive Rate)
- Mide la proporción de ejemplos positivos que fueron correctamente clasificados como positivos (es decir, verdaderos positivos) en comparación con el número total de ejemplos positivos en el conjunto de datos. 
- Es útil en problemas donde el costo de un falso negativo es alto.

## 2.4. F1-score
- Es la media armónica entre la precisión y la sensibilidad, y mide la eficacia general del modelo. 
- Es una métrica útil para problemas de clasificación desequilibrados, donde hay una clase minoritaria que es más importante que las demás.

## 2.5. Curva ROC (ROC Curve)
- Es una representación gráfica de la sensibilidad versus la tasa de falsos positivos para diferentes umbrales de clasificación. 
- Es una métrica útil para evaluar la capacidad de discriminación del modelo y comparar diferentes modelos. 
- El área bajo la curva ROC (AUC) se utiliza a menudo como una medida agregada de la calidad del modelo.
