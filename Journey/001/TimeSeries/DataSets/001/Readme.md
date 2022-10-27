The [datasets](https://www.kaggle.com/c/recruit-restaurant-visitor-forecasting/data) used for this analysis are from a KAGGLE competition called "Recruit Restaurant Visitor Forecasting".

## *** THE NEXT DESCRIPTION IS A COPY FROM KAGGLE... ***

The objective: Predict how many future visitors a restaurant will receive
In this competition, you are provided a time-series forecasting problem centered around restaurant visitors. The data comes from two separate sites:

    - Hot Pepper Gourmet (hpg): similar to Yelp, here users can search restaurants and also make a reservation online
    - AirREGI / Restaurant Board (air): similar to Square, a reservation control and cash register system

You must use the reservations, visits, and other information from these sites to forecast future restaurant visitor totals on a given date. The `training data` covers the dates `from 2016 until April 2017.` The `test set` covers the `last week of April and May of 2017.` The test set is split based on time (the public fold coming first, the private fold following the public) and covers a chosen subset of the air restaurants. Note that the test set intentionally spans a holiday week in Japan called the "Golden Week." (form April-29th to May-5th)

There are days in the test set where the restaurant were closed and had no visitors. These are ignored in scoring. `The training set omits days where the restaurants were closed.`
File Descriptions

This is a relational dataset from two systems. Each file is prefaced with the source (either air_ or hpg_) to indicate its origin. Each restaurant has a unique air_store_id and hpg_store_id. Note that not all restaurants are covered by both systems, and that you have been provided data beyond the restaurants for which you must forecast. Latitudes and Longitudes are not exact to discourage de-identification of restaurants.

### air_reserve.csv
This file contains reservations made in the air system. Note that the reserve_datetime indicates the time when the reservation was created, whereas the visit_datetime is the time in the future where the visit will occur (92.378 observ.)

    air_store_id - the restaurant's id in the air system (air_877f79706adbfb06)
    visit_datetime - the time of the reservation (2016-01-01 19:00:00)
    reserve_datetime - the time the reservation was made (2016-01-01 16:00:00)
    reserve_visitors - the number of visitors for that reservation (1)

### hpg_reserve.csv
This file contains reservations made in the hpg system (2.000.320 observ.)

    hpg_store_id - the restaurant's id in the hpg system (hpg_c63f6f42e088e50f)
    visit_datetime - the time of the reservation (2016-01-01 11:00:00)
    reserve_datetime - the time the reservation was made (2016-01-01 09:00:00)
    reserve_visitors - the number of visitors for that reservation (1)

### air_store_info.csv
This file contains information about select air restaurants. Column names and contents are self-explanatory (829 observ.)

    air_store_id (air_0f0cdeee6c9bf3d7)
    air_genre_name (Italian/French)
    air_area_name (Hyōgo-ken Kōbe-shi Kumoidōri)
    latitude (34.69512)
    longitude (135.1979)

Note: latitude and longitude are the latitude and longitude of the area to which the store belongs

### hpg_store_info.csv
This file contains information about select hpg restaurants. Column names and contents are self-explanatory (4.690 observ.)

    hpg_store_id (hpg_6622b62385aec8bf)
    hpg_genre_name (Japanese style)
    hpg_area_name (Tōkyō-to Setagaya-ku Taishidō)
    latitude (35.64367)
    longitude (139.6682)

Note: latitude and longitude are the latitude and longitude of the area to which the store belongs

### store_id_relation.csv
This file allows you to join select restaurants that have both the air and hpg system (150 observ.)

    hpg_store_id (hpg_4bc649e72e2a239a)
    air_store_id (air_63b13c56b7201bd9)

### air_visit_data.csv
This file contains historical visit data for the air restaurants (252.108 observ.)

    air_store_id (air_ba937bf13d40fb24)
    visit_date - the date (2016-01-13)
    visitors - the number of visitors to the restaurant on the date (25)

### sample_submission.csv
This file shows a submission in the correct format, including the days for which you must forecast (32.019 observ).

    id - the id is formed by concatenating the air_store_id and visit_date with an underscore (air_00a91d42b08b08d9_2017-04-23)
    visitors- the number of visitors forecasted for the store and date combination (0)

### date_info.csv
This file gives basic information about the calendar dates in the dataset (517 observ.)

    calendar_date (2016-01-01)
    day_of_week (Friday)
    holiday_flg - is the day a holiday in Japan (1)

