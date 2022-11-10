(from https://www.kaggle.com/competitions/titanic)

#### What is the challenge?

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
