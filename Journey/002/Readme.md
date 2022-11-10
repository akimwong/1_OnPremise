# EXPLORATORY DATA ANALISYS (EDA)

The objectives of EDA are:
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
- Graphical (summarize the data in a diagrammatic or visual way)
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





