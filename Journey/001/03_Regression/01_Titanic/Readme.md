(from https://www.kaggle.com/competitions/titanic)

# I. WHAT IS THE CHALLENGE?

On April 15, 1912, during her maiden voyage, the widely considered “unsinkable” RMS Titanic sank after colliding with an iceberg. Unfortunately, there weren’t enough lifeboats for everyone onboard, resulting in:
- Death: 1502
- Total passengers and crew: 2224

It seems some groups of people were more likely to survive than others.

In this challenge, `we ask you to build a predictive model that answers the question: “what sorts of people were more likely to survive?”` using passenger data (ie name, age, gender, socio-economic class, etc). 

#### What Data Will I Use in This Competition?

In this competition, you’ll gain access to two similar datasets that include passenger information like name, `age, gender, socio-economic class, etc.` One dataset is titled `train.csv` and the other is titled `test.csv`.

- `train.csv` contain the details of a subset of the passengers on board (891 to be exact) and importantly, `will reveal whether they survived or not,` also known as the “ground truth”.

- `test.csv` contains similar information but `does not disclose` the “ground truth” for each passenger. `It’s your job to predict these outcomes.`

Using the patterns you find in the train.csv data, predict whether the other 418 passengers on board (found in test.csv) survived. 


# II. APPROACH:
The proposed problem is estimated as binary classification: Survives (1) - Dies (0)

Before we open the dataset and start working on the available features, we will see the conditions necessary to survive in a catastrophic situation.
This can be used to determine the significance of the features available (or the features needed if we start from scratch without any dataset of features)

<p align="center">
  <img src="TitanicApproach1.png" width="450" height="230">
</p>

Now we can try to organize the features within this general scheme.
We can see:
- Note that being a woman and a girl can be a disadvantage compared to a grown man in a circumstance of jungle law, but on the contrary, it can be a great advantage to survive according to the rules of a civilized world.
- There are variables that a priori are estimated that do not determine survival in a disaster situation such as the name or ticket number.  We keep them under observation until they go through the analysis process. 

<p align="center">
  <img src="TitanicApproach2.png" width="450" height="230">
</p>

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
We will use and compare ALL the binary classification models (except for Deep Learning), and then select the best one based on metrics

### 3. The Tool(s) <- Why?
We will use R and Python.  </br>
For educational purposes to practice code, measure response times, and to check different outputs from different libraries

#### [(next step: Exploratory Data Analysis (EDA) ...)](https://github.com/akimwong/1_OnPremise/tree/main/Journey/002/03_Regression/01_Titanic/)



