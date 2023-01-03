The [datasets](https://www.kaggle.com/competitions/godaddy-microbusiness-density-forecasting/data) used for this analysis are from a KAGGLE competition called "GoDaddy - Microbusiness Density Forecasting".

## *** THE NEXT DESCRIPTION IS A COPY FROM KAGGLE... ***

- Your challenge in this competition is to `forecast microbusiness activity` across the United States, as `measured by the density of microbusinesses in US counties`.
- Microbusiness activity may be correlated with other economic indicators of general interest.
- This is a forecasting competition.
- A great deal of data is publicly available about counties and `we have not attempted to gather it all here`. You are `strongly encouraged to use external data sources` for features.

### train.csv

    row_id - An ID code for the row.
    cfips - A unique identifier for each county using the Federal Information Processing System*.
    county_name - The written name of the county.
    state_name - The name of the state.
    first_day_of_month - The date of the first day of the month.
    microbusiness_density - Microbusinesses per 100 people over the age of 18 in the given county**. 
    active - The raw count of microbusinesses in the county. Not provided for the test set.

(*) The first two digits correspond to the state FIPS code, while the following 3 represent the county.
(**) This is the target variable. The population figures used to calculate the density are on a two-year lag due to the pace of update provided by the U.S. Census Bureau, which provides the underlying population data annually. 2021 density figures are calculated using 2019 population figures, etc.

### sample_submission.csv A valid sample submission. This file will remain unchanged throughout the competition.

    row_id - An ID code for the row.
    microbusiness_density - The target variable.

### test.csv Metadata for the submission rows. This file will remain unchanged throughout the competition.

    row_id - An ID code for the row.
    cfips - A unique identifier for each county using the Federal Information Processing System.
    first_day_of_month - The date of the first day of the month.

census_starter.csv Examples of useful columns from the Census Bureau's American Community Survey (ACS) at data.census.gov. The percentage fields were derived from the raw counts provided by the ACS. All fields have a two year lag to match what information was avaiable at the time a given microbusiness data update was published.

    pct_bb_[year] - The percentage of households in the county with access to broadband of any type. Derived from ACS table B28002: PRESENCE AND TYPES OF INTERNET SUBSCRIPTIONS IN HOUSEHOLD.
    cfips - The CFIPS code.
    pct_college_[year] - The percent of the population in the county over age 25 with a 4-year college degree. Derived from ACS table S1501: EDUCATIONAL ATTAINMENT.
    pct_foreign_born_[year] - The percent of the population in the county born outside of the United States. Derived from ACS table DP02: SELECTED SOCIAL CHARACTERISTICS IN THE UNITED STATES.
    pct_it_workers_[year] - The percent of the workforce in the county employed in information related industries. Derived from ACS table S2405: INDUSTRY BY OCCUPATION FOR THE CIVILIAN EMPLOYED POPULATION 16 YEARS AND OVER.
    median_hh_inc_[year] - The median household income in the county. Derived from ACS table S1901: INCOME IN THE PAST 12 MONTHS (IN 2021 INFLATION-ADJUSTED DOLLARS).
