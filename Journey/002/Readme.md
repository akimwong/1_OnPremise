# EXPLORATORY DATA ANALISYS (EDA)
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
