# EXPLORATORY DATA ANALISYS (EDA)
[(extract from the article!)](https://www.itl.nist.gov/div898/handbook/eda/eda.htm) <br/>

The primary goal of EDA is to maximize the analyst's insight into a data set and into the underlying structure of a data set, while providing all of the specific items that an analyst would want to extract from a data set, such as:  <br/>
- Discover underlying patterns
- Spot anomalies
- Frame the hypothesis
- Check assumptions with the aim to find a good fitting model (if one exists)

At a more granular level:
- EDA involves understanding the relationship between variables including determining relationships among the explanatory variables; 
- Assessing the relationships between explanatory and outcome variables (direction and rough size estimates); 
- The presence of outliers; 
- A ranking of the important explanatory variables; 
- Conclusions as to whether individual explanatory variables are statistically significant.

### Categorising EDA techniques

Are either:
- Graphical (Most EDA techniques are graphical in nature with a few quantitative techniques. The reason for the heavy reliance on graphics is that by its very nature the main role of EDA is to open-mindedly explore, and graphics gives the analysts unparalleled power to do so, enticing the data to reveal its structural secrets, and being always ready to gain some new, often unsuspected, insight into the data. In combination with the natural pattern-recognition capabilities that we all possess, graphics provides, of course, unparalleled power to carry this out.)
- Quantitative (normally involve calculation of summary statistics) <br/>

(Non-graphical and graphical methods complement each other, we can see graphical methods as more qualitative (providing subjective analysis) vs quantitative methods as objective)

Each of these techniques are in turn:
- Univariate (look at one variable (data column) at a time)
- Multivariate (usually just bivariate) (look at two or more variables at a time to explore relationships).

### 1. Univariate non-graphical EDA (techniques)
Are concerned with understanding the underlying sample distribution and make observations about the population. This also involves Outlier detection.
- For univariate categorical data, we are interested in the range and the frequency.
- For quantitative data involves making preliminary assessments about the population distribution of the variable using the data from the observed sample.

The characteristics of the population distribution inferred include:
- Center
- Spread
- Modality
- Shape
-  And outliers.  

Measures of central tendency include:
- Mean (most common measure of central tendency)
- Median (for skewed distribution or when there is concern about outliers, the median may be preferred)
- Mode. 

Measures of spread (indicator of how far away from the center we are still likely to find data values) include:
- Variance
- Standard deviation
- Interquartile range 

Univariate EDA also involves finding the:
- Skewness (measure of asymmetry) 
- Kurtosis (measure of peakedness relative to a Gaussian shape).


### 2. Univariate graphical EDA
a. For graphical analysis of univariate categorical data, histograms are typically used. <br/>
- The histogram represents the frequency (count) or proportion (count/total count) of cases for a range of values. 
- Typically, between about 5 and 30 bins are chosen. 
- Histograms are one of the best ways to quickly learn a lot about your data, including central tendency, spread, modality, shape and outliers. <br/>
b. Stem and Leaf plots could also be used for the same purpose. <br/>
c. Boxplots can also be used to present information about the central tendency, symmetry and skew, as well as outliers.  <br/>
d. Quantile normal plots or QQ plots and other techniques could also be used here.

### 3. Multivariate non-graphical EDA
- Generally show the relationship between two or more variables in the form of either cross-tabulation or statistics. <br/>
- For each combination of categorical variable (usually explanatory) and one quantitative variable (usually outcome), we can create a statistic for a quantitative variables separately for each level of the categorical variable, and then compare the statistics across levels of the categorical variable. <br/>
- Comparing the means is an informal version of ANOVA. <br/>
- Comparing medians is a robust informal version of one-way ANOVA.  <br/>
- For two quantitative variables, we can calculate co-variance and/or correlation. <br/>
When we have many quantitative variables, we typically calculate the pairwise covariances and/or correlations and assemble them into a matrix.

### 4. Multivariate graphical EDA
- For categorical multivariate quantities, the most commonly used graphical technique is the barplot with each group representing one level of one of the variables and each bar within a group representing the levels of the other variable. 
- For each category, we could have side-by-side boxplots or Parallel box plots. 
- For two quantitative multivariate variables, the basic graphical EDA technique is the scatterplot which has one variable on the x-axis, one on the y-axis and a point for each case in your dataset.  Typically, the explanatory variable goes on the X axis.  Additional categorical variables can be accommodated by the use of colour or symbols.<br/>

Insight implies `detecting and uncovering underlying structure in the data.` Such underlying structure may not be encapsulated in the list of items above; such items serve as the specific targets of an analysis, `but the real insight and "feel" for a data set comes as the analyst judiciously probes and explores the various subtleties of the data`. The "feel" for the data comes almost exclusively from the application of various graphical techniques, the collection of which serves as the window into the essence of the data. Graphics are irreplaceable--there are no quantitative analogues that will give the same insight as well-chosen graphics. 

To get a "feel" for the data, `it is not enough for the analyst to know what is in the data; the analyst also must know what is not in the data,` and the only way to do that is to draw on our own human pattern-recognition and comparative abilities in the context of a series of judicious graphical techniques applied to the data. 

# Advanced exploratory data analysis (EDA)
[(extract from the article!)](https://medium.com/epfl-extension-school/advanced-exploratory-data-analysis-eda-with-python-536fa83c578a) <br/>

## Investigation of structure, quality and content

Overall, the EDA approach is very iterative. At the end of your investigation you might discover something that will require you to redo everything once more. That is normal! But to impose at least a little bit of structure, I propose the following structure for your investigations:

1. Structure investigation: Exploring the general shape of the dataset, as well as the data types of your features.
2. Quality investigation: Get a feeling for the general quality of the dataset, with regards to duplicates, missing values and unwanted entries.
3. Content investigation: Once the structure and quality of the dataset is understood, we can go ahead and perform a more in-depth exploration on the features values and look at how different features relate to each other.

## 1. Structure Investigation

Before looking at the detailed content of any dataset:
- How many columns and rows does the dataset have?
- How many different data types do those features include?

### 1.1. Structure of non-numerical features

Even though "sex" is a numerical feature, it somehow was stored as a non-numerical one. This is sometimes due to some typo in data recording. These kind of things need to be taken care of during data preparation.

Once this is taken care of, we can use the some functions to investigate:
- How many unique values each non-numerical feature has
- And with which frequency the most prominent value is present

### 1.2. Structure of numerical features

Investigate how many unique values each of these feature has. This process will give us some insights about:
- The number of binary (2 unique values)
- Ordinal (3 to ~10 unique values) 
- And continuous (more than 10 unique values) features in the dataset.

### 1.3. Conclusion of structure investigation

At the end of this first investigation, we should:
- Have a better understanding of the general structure of our dataset. 
- Number of samples and features, what kind of data type each feature has, and how many of them are binary, ordinal, categorical or continuous.

## 2. Quality Investigation

To take a look at the general quality of the dataset. <br/>
The goal is to have a global view on the dataset with regards to things like duplicates, missing values and unwanted entries or recording errors.

### 2.1. Duplicates

- Duplicates are entries that represent the same sample point multiple times. 
- Detecting such duplicates is not always easy, as each dataset might have a unique identifier features . So you might want to ignore them first. 
- And once you are aware about the number of duplicates in your dataset, you can simply drop them

### 2.2. Missing values

Having some missing values is normal. <br/>
What we want to identify at this stage are big holes in the dataset, i.e. samples or features with a lot of missing values.

#### 2.2.1. Per sample

- Some samples where more than 50% of the feature values are missing. 
- For those samples, `filling the missing values with some replacement values is probably not a good idea.` <br/> 
- `Drop samples` that have `more than 20% of missing values.` <br/> 

#### 2.2.2. Per Feature

- Identify the ratio of missing values per feature.
- Remove any feature with more than 15% of missing values.

#### 2.2.3. Small side note

- There is no strict order in removing missing values. For some datasets, tackling first the features and than the samples might be better. 
- The threshold at which you decide to drop missing values per feature or sample changes from dataset to dataset, and depends on what you intend to do with the dataset later on.
- Also, until now we only addressed the big holes in the dataset, not yet how we would fill the smaller gaps. This is content for another post.

### 2.3. Unwanted entries and recording errors

- Another source of quality issues in a dataset can be due to unwanted entries or recording errors. 
- It’s important to distinguish such samples from simple outliers. While outliers are data points that are unusual for a given feature distribution, unwanted entries or recording errors are samples that shouldn’t be there in the first place.
- Detecting such errors and unwanted entries and distinguishing them from outliers is not always straight forward and depends highly on the dataset. One approach to this is to take a global view on the dataset and see if you can identify some very unusual patterns.

#### 2.3.1. Numerical features

- Plot a global view of the dataset, at least for the numerical features
- And each subplot that represents a different feature. 

The y-axis shows the feature value, while the x-axis is the sample index. <br/>
These plots can give you a lot of ideas for data cleaning and EDA. <br/>
Usually it makes sense to invest as much time as needed until you’re happy with the output of this visualization. <br/>

#### 2.3.2. Non-numerical features

Identifying unwanted entries or recording errors on non-numerical features is a bit more tricky. Given that at this point, we only want to investigate the general quality of the dataset. So what we can do is take a general look at how many unique values each of these non-numerical features contain, and how often their most frequent category is represented. <br/>

There are multiple ways for how you could potentially streamline the quality investigation for each individual non-numerical features. None of them is perfect, and all of them will require some follow up investigation. But for the purpose of showcasing one such a solution, what we could do is loop through all non-numerical features and plot for each of them the number of occurrences per unique value. <br/>

The decision for what should be done with such rather unique entries is once more left in the the subjective hands of the person analyzing the dataset. Without any good justification for WHY, and only with the intention to show you the HOW

### 2.4. Conclusion of quality investigation

We should have a better understanding of the general quality of our dataset. <br/>
We looked at duplicates, missing values and unwanted entries or recording errors. It is important to point out that we didn’t discuss yet how to address the remaining missing values or outliers in the dataset. This is a task for the next investigation, but won’t be covered in this article.

## 3. Content Investigation

In an ideal setting, such an investigation would be done feature by feature. But this becomes very cumbersome once you have more than 20–30 features. <br/>

For this reason (and to keep this article as short as needed) we will explore three different approaches that can give you a very quick overview of the content stored in each feature and how they relate.

### 3.1. Feature distribution

Looking at the value distribution of each feature is a great way to better understand the content of your data. Furthermore, it can help to guide your EDA, and provides a lot of useful information with regards to data cleaning and feature transformation. The quickest way to do this for numerical features is using histogram plots. Luckily, pandas comes with a builtin histogram function that allows the plotting of multiple features at once.

There are a lot of very interesting things visible in this plot. For example…

Most frequent entry: Some features, such as Towing_and_Articulation or Was_Vehicle_Left_Hand_Drive? mostly contain entries of just one category. Using the .mode() of Python function, we could for example extract the ratio of the most frequent entry for each feature and visualize that information.

Skewed value distributions: Certain kind of numerical features can also show strongly non-gaussian distributions. In that case you might want to think about how you can transform these values to make them more normal distributed. For example, for right skewed data you could use a log-transformation.

### 3.2. Feature patterns

Next step on the list is the investigation of feature specific patterns. The goal of this part is two fold:

- Can we identify particular patterns within a feature that will help us to decide if some entries need to be dropped or modified?
- Can we identify `particular relationships between features that will help us to better understand our dataset?`

Before we dive into these two questions, let’s take a closer look at a few ‘randomly selected’ features.

In the top row, we can see features with continuous values (e.g. seemingly any number from the number line), while in the bottom row we have features with discrete values (e.g. 1, 2, 3 but not 2.34).

While there are many ways we could explore our features for particular patterns, let’s simplify our option by deciding that we treat features with less than 25 unique features as discrete or ordinal features, and the other features as continuous features.

#### 3.2.1. Continuous features
(for example) Whe have to visualize the relationships between these features. 

There seems to be a strange relationship between a few features in the top left corner:
- Location_Easting_OSGR and Longitude, as well as 
- Location_Easting_OSGR and Latitude <br/> 

Seem to have a very strong linear relationship.
<p align="center">
  <img src="https://github.com/akimwong/1_OnPremise/blob/main/Journey/002/plots/plot1.png" width="1000" height="1000">
</p>

Knowing that these features contain geographic information, a more in-depth EDA with regards to geolocation could be fruitful. However, for now we will leave the further investigation of this pairplot to the curious reader and continue with the exploration of the discrete and ordinal features.

#### 3.2.2. Discrete and ordinal features

Finding patterns in the discrete or ordinal features is a bit more tricky. <br/> 
- First, let’s select the columns we want to investigate.
- To spread the values out in the direction of the y-axis we need to chose one particular (hopefully informative) feature. 
- While the ‘right’ feature can help to identify some interesting patterns, usually any continuous feature should do the trick.
- The main interest in this kind of plot is to see how many samples each discrete value contains.

<p align="center">
  <img src="https://github.com/akimwong/1_OnPremise/blob/main/Journey/002/plots/plot2.png" width="900" height="1300">
</p>

There are too many things to comment here, so let’s just focus on a few. <br/> 

In particular, let’s focus on 6 features where the values appear in some particular pattern or where some categories seem to be much less frequent than others. <br/> 
And to shake things up a bit, let’s now use the Longitude feature to stretch the values over the y-axis.<br/> 
<p align="center">
  <img src="https://github.com/akimwong/1_OnPremise/blob/main/Journey/002/plots/plot3.png" width="700" height="400">
</p>

These kind of plots are already very informative, but they obscure regions where there are a lot of data points at once. <br/> 
For example, there seems to be a high density of points in some of the plots at the 52nd latitude. <br/>
So let’s take a closer look with an appropriate plot, such as violineplot ( or boxenplot or boxplot for that matter). <br/>
And to go a step further, let's also separate each visualization by Urban_or_Rural_Area.

<p align="center">
  <img src="https://github.com/akimwong/1_OnPremise/blob/main/Journey/002/plots/plot4.png" width="1000" height="500">
</p>

Interesting! We can see that some values on features are more frequent in urban, than in rural areas (and vice versa). <br/>
Furthermore, as suspected, there seems to be a high density peak at latitude 51.5. This is very likely due to the more densely populated region around London (at 51.5074°).

### 3.3. Feature relationships

Last, but not least, let’s take a look at relationships between features. <br/>
More precisely how they correlate. The quickest way to do so is via pandas’ .corr() function. <br/>
So let's go ahead and compute the feature to feature correlation matrix for all numerical features.



Note: Depending on the dataset and the kind of features (e.g. ordinal or continuous features) you might want to use the `spearman method instead of the pearson method to compute the correlation.` <br/>
Whereas the `Pearson correlation evaluates the linear relationship between two continuous variables,` the `Spearman correlation evaluates the monotonic relationship based on the ranked values for each feature.` <br/>
And to help with the interpretation of this correlation matrix, let's use seaborn's .heatmap() to visualize it.

<p align="center">
  <img src="https://github.com/akimwong/1_OnPremise/blob/main/Journey/002/plots/plot5.png" width="1000" height="1000">
</p>

This looks already very interesting. We can see a few very strong correlations between some of the features.<br/>
As you can see, the investigation of feature correlations can be very informative. <br/>
But looking at everything at once can sometimes be more confusing than helpful. <br/>
So focusing only on one feature with something like df_X.corrwith(df_X["Speed_limit"]) might be a better approach.

Furthermore, `correlations can be deceptive if a feature still contains a lot of missing values or extreme outliers.` <br/>
Therefore, `it is always important to first make sure that your feature matrix is properly prepared before investigating these correlations.`

### 3.4. Conclusion of content investigation

At the end of this third investigation:
- We should have a better understanding of the content in our dataset. 
- We looked at value distribution, feature patterns and feature correlations. <br/>

However, these are certainly not all possible content investigation and data cleaning steps you could do. <br/>
Additional steps would for example be outlier detection and removal, feature engineering and transformation, and more.

A proper and detailed EDA takes time! <br/>
It is a very iterative process that often makes you go back to the start, after you addressed another flaw in the dataset. <br/>
This is normal! It’s the reason why we often say that 80% of any data science project is data preparation and EDA.




