# Logistic Regression Explained in 7 Minutes
- Is a model that predicts the probability of an event taking place.
- It is used to solve classification problems, which means that the dependent variable is always a class or category
- Classification problems can be divided into two types: binary (involves predicting one of two classes) and multi-class classification (to predicting one of many classes)

### How Does Logistic Regression Work?
- Can be modeled with an S-shaped curve as displayed in the example below:
<p align="center">
  <img src="logistic1.png" width="550" height="400">
</p>

- The X-axis of this graph displays the number of years in the company, which is the dependent variable. <br/>
- The Y-axis tells us the probability that a person will get promoted, and these values range from 0 to 1. <br/>
- A probability of 0 indicates that the person will not get promoted and 1 tells us that they will get promoted. <br/>
- Logistic regression returns an outcome of 0 (Promoted = No) for probabilities less than 0.5. A prediction of 1 (Promoted = Yes) is returned for probabilities greater than or equal to 0.5 <br/>

### How to Evaluate Logistic Regression Models?
- The most popular metric used to evaluate the performance of classification models is ACCURACY.
- However, accuracy ISN’T ALWAYS the most reliable indicator of a good model, which is why data scientists often use measures like PRECISION, RECALL, and the F1-SCORE instead.
- Using the dataset below that comprises information of whether a student passed an exam.
- The true data is imbalanced since 80% of students passed and 20% failed. 
- This means that the dataset is skewed to represent more of one class than another.
<p align="center">
  <img src="logistic2.png" width="300" height="350">
</p>

#### Accuracy
- Calculated using the formula
<p align="center">
  <img src="logistic3.png" width="200" height="100">
</p>
- This model has an 80% accuracy.




