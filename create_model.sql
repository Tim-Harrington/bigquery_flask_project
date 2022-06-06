CREATE OR REPLACE MODEL `my_models.annual_temp`
OPTIONS
  (model_type='ARIMA_PLUS',
  time_series_timestamp_col = 'YEAR',
  time_series_data_col = 'avg_temp_CS',
  auto_arima = TRUE,
  data_frequency = "AUTO_FREQUENCY",
  decompose_time_series = TRUE
  ) AS

select
avg(arithmetic_mean) as avg_temp_CS
,YEAR
FROM `bigquery-public-data.epa_historical_air_quality.air_quality_annual_summary`
where
parameter_name = 'Average Ambient Temperature'
and metric_used = 'observed_values'
and completeness_indicator = "Y"
and year between 1990 and 2020
group by
YEAR
order by
YEAR
