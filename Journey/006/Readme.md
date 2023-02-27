
# 1. Modelos de Regresión

## 1.1. MSE: Mean squared error (Error cuadrático medio)
- Mide el promedio de los errores cuadráticos entre las predicciones del modelo y los valores reales de la variable de respuesta. 
- Objetivo: Minimizar (las predicciones del modelo están más cercanas a los valores reales).
- (junto con RMSE) es de las métricas más comunes que se usan 

## 1.2. RMSE: Root mean squared error (raíz cuadrada del MSE)
- Mide la desviación entre los valores observados y los valores predichos por el modelo. 
- Objetivo: Minimizar
- RMSE es una medida de la magnitud de los errores de predicción del modelo <b>en las mismas unidades que la variable de respuesta</b>. 
- If your response variable units are dollars, the units of MSE are dollars-squared, but the RMSE will be in dollars.

## 1.3. 

Deviance: Short for mean residual deviance. In essence, it provides a degree to which a model explains the variation in a set of data when using maximum likelihood estimation. Essentially this compares a saturated model (i.e. fully featured model) to an unsaturated model (i.e. intercept only or average). If the response variable distribution is Gaussian, then it will be approximately equal to MSE. When not, it usually gives a more useful estimate of error. Deviance is often used with classification models.10 Objective: minimize

## 1.4.
MAE: Mean absolute error. Similar to MSE but rather than squaring, it just takes the mean absolute difference between the actual and predicted values (MAE=1n∑ni=1(|yi−^yi|)

). This results in less emphasis on larger errors than MSE. Objective: minimize

## 1.5. 
RMSLE: Root mean squared logarithmic error. Similar to RMSE but it performs a log() on the actual and predicted values prior to computing the difference (RMSLE=√1n∑ni=1(log(yi+1)−log(^yi+1))2

). When your response variable has a wide range of values, large response values with large errors can dominate the MSE/RMSE metric. RMSLE minimizes this impact so that small response values with large errors can have just as meaningful of an impact as large response values with large errors. Objective: minimize

## 1.6.
R2
: This is a popular metric that represents the proportion of the variance in the dependent variable that is predictable from the independent variable(s). Unfortunately, it has several limitations. For example, two models built from two different data sets could have the exact same RMSE but if one has less variability in the response variable then it would have a lower R2 than the other. You should not place too much emphasis on this metric. Objective: maximize
