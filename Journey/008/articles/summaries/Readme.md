# Logistic Regression Explained in 7 Minutes
- Is a model that predicts the probability of an event taking place.
- It is used to solve classification problems, which means that the dependent variable is always a class or category
- Classification problems can be divided into two types: binary (involves predicting one of two classes) and multi-class classification (to predicting one of many classes)

#### How Does Logistic Regression Work?
- Can be modeled with an S-shaped curve as displayed in the example below:
<p align="center">
  <img src="logistic1.png" width="550" height="230">
</p>
- The X-axis of this graph displays the number of years in the company, which is the dependent variable. 
- The Y-axis tells us the probability that a person will get promoted, and these values range from 0 to 1.
- A probability of 0 indicates that the person will not get promoted and 1 tells us that they will get promoted.
- Logistic regression returns an outcome of 0 (Promoted = No) for probabilities less than 0.5. A prediction of 1 (Promoted = Yes) is returned for probabilities greater than or equal to 0.5


