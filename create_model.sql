CREATE OR REPLACE MODEL `my_models.annual_temp`
OPTIONS
  (model_type='ARIMA_PLUS',
  time_series_timestamp_col = 'year_dt',
  time_series_data_col = 'avg_temp',
  auto_arima = TRUE,
  data_frequency = "AUTO_FREQUENCY",
  decompose_time_series = TRUE
  ) AS

select
avg(arithmetic_mean) as avg_temp
,CAST(CONCAT(CAST(year as STRING), '-01-01') AS DATE) AS year_dt
FROM `bigquery-public-data.epa_historical_air_quality.air_quality_annual_summary`
where
parameter_name = 'Outdoor Temperature'
and metric_used = 'Observed Values'
and completeness_indicator = "Y"
and year between 1990 and 2020
group by
year_dt
order by
year_dt
