## COMMENTS ABOUT THE PROBLEM AND THE [DATASETS](/001/TimeSeries)

- To make the forecast "air_visit_data.csv" is the main dataset, but it includes the information of many restaurants
- The submission request only two values composed by "restaurant-date" & "number of visitors".  To explain in an easy way the time series theory, I will select the information of only 1 restaurant that opens more days per year
- "date_info.csv" is used to find out the influence of holidays on the arrival of visitors
- "air_reserve.csv", "hpg_reserve.csv" and "store_id_relation.csv" are good input to try to predict around at what hour the visitors will arrive to the restaurants but to predict the total number of visitors per day the "air_visit_data.csv" is still better
- "air_store_info.csv" and "hpg_store_info.csv" can be used to make different comparisons between restaurants (for example, what style of food has more visitors depending on the neighborhood) but not to individually determine the number of visitors per restaurant per day
