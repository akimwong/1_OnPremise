#### (from https://www.kaggle.com/code/benpowis/customer-propensity-to-purchase/notebook)

# I. ¿Cuál es el problema?

- Tenemos muchos visitantes a nuestro sitio web todos los días, algunos compran pero muchos no. 
- Gastamos dinero reorientando los visitantes que no compran, nos gustaría optar por esta actividad dirigiéndonos a los visitantes que tienen más probabilidades de convertir. 
- Para ello, hemos tomado datos que muestran `con qué partes de nuestra web interactuaron nuestros usuarios`, nuestras preguntas son:

1. ¿Cuales de estas interacciones tienen relación con una posible compra?
2. ¿Podemos segmentar a los visitantes de ayer que no compraron? ¿para estimar quiénes son los que tienen mayor probabilidad de comprar?


#### ¿Qué datos usaremos?

- Tenemos columnas de enteros, cada una reflejando una acción en el sitio web.
- Y una columna, que parece un identificador de usuario.
- Tenemos 1’s o 0’s en las columnas, indicando si un usuario interactuó o no con estas áreas del sitio web. 
- La última columna muestra si el usuario compró o no, ésta es la objetivo!

# II. ENFOQUE:
El problema propuesto es de clasificación: Convierte (1) - No convierte (0)

Antes de abrir el dataset y de empezar a trabajar con las features disponibles se decriben las condiciones necesarias para una posible compra:

1. Existencia de la necesidad de un producto o servicio
2. Búsqueda del producto o servicio
3. Comprobación de precio
4. Comparación del producto con productos similares
5. Revisión de valoraciones (de haber) del producto elegido
6. Facilidad de compra / navegación por el sitio web
7. Coste del envío
8. Política de devolución

### 1. ¿Qué Método? <- ¿Por qué?

Tipo de problema: Quantitativo (Toma de decisión justificada por números) </br>

Método usado: CRISP-DM (estándar de la industria para resolver problemas cuantitativos)

1.1. Business understanding - ¿Cuál es exactamente el problema que tratamos de resolver con los datos? <br/>

- ¿Qué interacciones tienen los usuarios con nuestra página web que finalmente derivan en una posible compra?
- ¿Cómo segmentar a los usuarios que tienen mayor potencial de compra en función de sus interacciones con nuestra página web?

1.2. Data understanding <br/>

- Se presentan columnas de potenciales acciones en nuestra web: 0 si NO se hizo / 1 si se hizo


1.3. Data preprocesing  <br/>

- Comprobación de nivel de correlación de las diferentes acciones con nuestra variables objetivo
- Extración (drop) de variables identificativa, eliminación de filas duplicadas -> nueva comprobación de correlaciones
- Comprobación de missings (imputaciones)
- Filtro de variables

1.4. Modelo <br/>

- Se usará un modelo de clasificación binaria

1.5. Optimización  <br/>

- Grid para búsqueda de hiperparámetros

1.6. Despliegue


### 2. ¿Qué Técnica? <- ¿Por qué?

- Se usará la técnica de Ensemble: Random Forest como modelo de referencia
(Aunque no existe un modelo que satisfaga todas las necesidades, Random Forest funciona habitualmente bien cuando se hacen comparativas)

No se usarán:
- Modelos de Deep learning, debido a la pequeña escala del dataset
- Modelos de aprendizaje No Supervisado, debido a que la variable objetivo se encuentra etiquetada
- Modelos de aprendizaje Por Refuerzo, debido a que todavía no ha sido estudiada en profundidad

### 3. ¿Qué Herrramienta(s)? <- ¿Por Qué?

Se usará Python (Pandas, Numpy, SKlearn), y posteiormente, R.  </br>
El objetivo de la práctica es educativo: 
- Conocer diferentes casos de uso de negocio
- Conocer diferentes tipos de datasets que hay en el mercado
- Exponer los resultados desde un punto de vista de Data Analyst
- Practicar diferentes códigos
- Medir tiempos de respuesta
- Comprobar los resultados de diferentes librerías

#### [(Siguiente: Exploratory Data Analysis (EDA))](https://github.com/akimwong/1_OnPremise/tree/main/Journey/002/01_Classification/01_Titanic/)

