[(the datasets comes from...)](https://github.com/akimwong/1_OnPremise/tree/main/Journey/001/03_Regression/01_Titanic/)

## 1. Structure Investigation

- Number of columns and rows:
- Number of data types that those features include:

### 1.1. Structure of non-numerical features

(Even though "sex" is a numerical feature, it somehow was stored as a non-numerical one. This is sometimes due to some typo in data recording. These kind of things need to be taken care of during data preparation.)

- Number of unique values each non-numerical feature has
- Frequency the most prominent value is present

### 1.2. Structure of numerical features

How many unique values each of these feature has. This process will give us some insights about:

- Number of binary (2 unique values)
- Number of Ordinal (3 to ~10 unique values)
- Number of continuous (more than 10 unique values) features in the dataset.

### 1.3. Conclusion of structure investigation

Have a better understanding of the general structure of our dataset.
Number of samples and features, what kind of data type each feature has, and how many of them are binary, ordinal, categorical or continuous.

## 2. Quality Investigation

Have a global view on the dataset with regards to things like duplicates, missing values and unwanted entries or recording errors.

### 2.1. Duplicates

- Duplicates?:
- Some reason?:

### 2.2. Missing values

#### 2.2.1. Per sample

- Samples where more than 50% of the feature values are missing (filling the missing values with some replacement values is probably not a good idea)
- Drop samples that have more than 20% of missing values.

#### 2.2.2. Per Feature

- Identify the ratio of missing values per feature.
- Remove any feature with more than 15% of missing values.

#### 2.2.3. Small side note

- There is no strict order in removing missing values. For some datasets, tackling first the features and than the samples might be better.
- The threshold at which you decide to drop missing values per feature or sample changes from dataset to dataset, and depends on what you intend to do with the dataset later on.

### 2.3. Unwanted entries and recording errors

- Another source of quality issues in a dataset can be due to unwanted entries or recording errors.
- It’s important to distinguish such samples from simple outliers. While outliers are data points that are unusual for a given feature distribution, unwanted entries or recording errors are samples that shouldn’t be there in the first place.
- Detecting such errors and unwanted entries and distinguishing them from outliers is not always straight forward and depends highly on the dataset. One approach to this is to take a global view on the dataset and see if you can identify some very unusual patterns.

#### 2.3.1. Numerical features

- Plot a global view of the dataset, at least for the numerical features
- And each subplot that represents a different feature.

The y-axis shows the feature value, while the x-axis is the sample index.
These plots can give you a lot of ideas for data cleaning and EDA.
Usually it makes sense to invest as much time as needed until you’re happy with the output of this visualization.

#### 2.3.2. Non-numerical features

Identifying unwanted entries or recording errors on non-numerical features is a bit more tricky. Given that at this point, we only want to investigate the general quality of the dataset. So what we can do is take a general look at how many unique values each of these non-numerical features contain, and how often their most frequent category is represented.

There are multiple ways for how you could potentially streamline the quality investigation for each individual non-numerical features. None of them is perfect, and all of them will require some follow up investigation. But for the purpose of showcasing one such a solution, what we could do is loop through all non-numerical features and plot for each of them the number of occurrences per unique value.

The decision for what should be done with such rather unique entries is once more left in the the subjective hands of the person analyzing the dataset. Without any good justification for WHY, and only with the intention to show you the HOW

### 2.4. Conclusion of quality investigation

We should have a better understanding of the general quality of our dataset.
We looked at duplicates, missing values and unwanted entries or recording errors. It is important to point out that we didn’t discuss yet how to address the remaining missing values or outliers in the dataset. This is a task for the next investigation, but won’t be covered in this article.

## 3. Content Investigation

In an ideal setting, such an investigation would be done feature by feature. But this becomes very cumbersome once you have more than 20–30 features.

For this reason (and to keep this article as short as needed) we will explore three different approaches that can give you a very quick overview of the content stored in each feature and how they relate.

### 3.1. Feature distribution

Looking at the value distribution of each feature is a great way to better understand the content of your data. Furthermore, it can help to guide your EDA, and provides a lot of useful information with regards to data cleaning and feature transformation. The quickest way to do this for numerical features is using histogram plots. Luckily, pandas comes with a builtin histogram function that allows the plotting of multiple features at once.

There are a lot of very interesting things visible in this plot. For example…

Most frequent entry: Some features, such as Towing_and_Articulation or Was_Vehicle_Left_Hand_Drive? mostly contain entries of just one category. Using the .mode() of Python function, we could for example extract the ratio of the most frequent entry for each feature and visualize that information.

Skewed value distributions: Certain kind of numerical features can also show strongly non-gaussian distributions. In that case you might want to think about how you can transform these values to make them more normal distributed. For example, for right skewed data you could use a log-transformation.

### 3.2. Feature patterns

Next step on the list is the investigation of feature specific patterns. The goal of this part is two fold:

    Can we identify particular patterns within a feature that will help us to decide if some entries need to be dropped or modified?
    Can we identify particular relationships between features that will help us to better understand our dataset?

Before we dive into these two questions, let’s take a closer look at a few ‘randomly selected’ features.

In the top row, we can see features with continuous values (e.g. seemingly any number from the number line), while in the bottom row we have features with discrete values (e.g. 1, 2, 3 but not 2.34).

While there are many ways we could explore our features for particular patterns, let’s simplify our option by deciding that we treat features with less than 25 unique features as discrete or ordinal features, and the other features as continuous features.

#### 3.2.1. Continuous features

(for example) Whe have to visualize the relationships between these features.



