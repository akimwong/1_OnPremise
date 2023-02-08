#### (from https://www.kaggle.com/code/benpowis/customer-propensity-to-purchase/notebook)

# I. ¿Cuál es el DESAFÍO?

- Tenemos muchos visitantes a nuestro sitio web todos los días, algunos compran pero muchos no. 
- Gastamos dinero reorientando los visitantes que no compran, nos gustaría optar por esta actividad dirigiéndonos a los visitantes que tienen más probabilidades de convertir. 
- Para ello, hemos tomado datos que muestran `con qué partes de nuestra web interactuaron nuestros usuarios`, nuestras preguntas son:

1. ¿Cuál de estas interacciones afecta a los usuarios probablemente a la compra?
2. ¿Podemos segmentar a los visitantes de ayer que no compraron? ¿para ver quiénes son los que tienen mayor probabilidad de compra?


#### ¿Qué datos usaremos?

- Tenemos un montón de columnas de enteros, cada una reflejando una acción en el sitio web.
- Y una columna de objeto, que parece un identificador de usuario.
- Tenemos 1’s o 0’s en las columnas, indicando si un usuario interactuó o no con estas áreas del sitio web. 
- La última columna muestra si el usuario ordenó o no, ésta es la importante!

# II. ENFOQUE:
El problema propuesto es de clasificación: Convierte (1) - No convierte (0)

Before we open the dataset and start working on the available features, we will see the conditions necessary to survive in a catastrophic situation.
This can be used to determine the significance of the features available (or the features needed if we start from scratch without any dataset of features)

Now we can try to organize the features within this general scheme.
We can see:
- Note that being a woman and a girl can be a disadvantage compared to a grown man in a circumstance of jungle law, but on the contrary, it can be a great advantage to survive according to the rules of a civilized world.
- There are variables that a priori are estimated that do not determine survival in a disaster situation such as the name or ticket number.  We keep them under observation until they go through the analysis process. 

### 1. The Method <- Why?
Type of problem: Quantitative (Decision-making justified by numbers) </br>
Method used: CRISP-DM (the standard of the industry for quantitative problems)

1.1. Business understanding - What exactly is the problem we are trying to solve with data <br/>

- What are my chances of survival based on my characteristics?
- What are the characteristics of people with the higher chance of survival?

1.2. Data understanding <br/>
1.3. Data preprocesing  <br/>
1.4. Modeling <br/>
1.5. Optimizing  <br/>
1.6. Deployment 

### 2. The Technique <- Why?
We will use the binary classification models of:
- Supervised Learning (Logistic Regression, SVM)
- Ensemble learning (Bagging: Random Forest)

And then select the best based on metrics.  Because the computanional cost is not too high due to the scale of the dataset <br/>

We won't use:
- Deep learning models, because the small scale of the dataset
- Unsupervised learning models, because the outputs are labeled
- Reinforcement learning models, because I haven’t studied them yet

### 3. The Tool(s) <- Why?
We will use Python (Pandas, Numpy, SKlearn) and R.  </br>
For educational purposes to practice different codes, measure response times, and to check different outputs from different libraries

#### [(Siguiente: Exploratory Data Analysis (EDA))](https://github.com/akimwong/1_OnPremise/tree/main/Journey/002/01_Classification/01_Titanic/)

