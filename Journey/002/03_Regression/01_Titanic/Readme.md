[(the datasets comes from...)](https://github.com/akimwong/1_OnPremise/tree/main/Journey/001/03_Regression/01_Titanic/)

## The Challenge:
Build a predictive model that answers the question: “what sorts of people were more likely to survive?”

## Approach:
The proposed problem is estimated as binary estimation: Survives (1) - Dies (0)

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



### 2. The Technique <- Why?


### 3. The Tool(s) <- Why?


1. Structure Investigation

Before looking at the detailed content of any dataset:

    How many columns and rows does the dataset have?
    How many different data types do those features include?

1.1. Structure of non-numerical features

Even though "sex" is a numerical feature, it somehow was stored as a non-numerical one. This is sometimes due to some typo in data recording. These kind of things need to be taken care of during data preparation.

Once this is taken care of, we can use the some functions to investigate:

    How many unique values each non-numerical feature has
    And with which frequency the most prominent value is present

1.2. Structure of numerical features

Investigate how many unique values each of these feature has. This process will give us some insights about:

    The number of binary (2 unique values)
    Ordinal (3 to ~10 unique values)
    And continuous (more than 10 unique values) features in the dataset.

1.3. Conclusion of structure investigation

At the end of this first investigation, we should:

    Have a better understanding of the general structure of our dataset.
    Number of samples and features, what kind of data type each feature has, and how many of them are binary, ordinal, categorical or continuous.
