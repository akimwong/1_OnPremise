# TIME SERIES

## DEFINITIONS

#### TIME SERIES
Is a series of data points indexed (or listed or graphed) in `time order`. Most commonly, a time series is a sequence taken at successive `equally spaced` points in time.  To study in depht a time series forecasting it MUST be breakdown into its elements (Trend + Seasonality + Cycle + Random)

`Time series analysis` is a method used for analysing time series data in order to `extract meaningful statistical information` from the data. `Time series forecasting` however, is all about `predicting future values` based on previously observed values over time

#### TREND
Shows the general tendency of the data to `increase or decrease` during a `long period` of time
#### SEASONALITY
Is the presence of `variations` that occur at specific `regular intervals less than a year`
#### CYCLE
`Recurrent variations` in time series that in generally `last longer than a year`
#### RANDOM OR IRREGULAR VARIATIONS
`Not regular` variations that are purely random or irregular. These fluctuations are `unforeseen`, `uncontrollable`, `unpredictable`, and are `erratic`

## DATASET
The dataset that will be used is [here](/Journey/001/TimeSeries/Readme.md)

## TOOLS & LIBRARIES
1. R - ts (up to days)
2. R - zoo (up to hours, minutes, seconds)
3. R - lubridate (up to hours, minutes, seconds)
4. Python - Prophet
5. Python - XGboost
