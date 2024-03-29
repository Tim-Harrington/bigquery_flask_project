
#Using Erin Mcmahon's Dash-App code as a baseline from her repo here https://github.com/erinmcmahon26/Dash-App/blob/main/main.py
import dash
from dash import Dash, dcc, html
from google.cloud import bigquery
import pandas as pd
import plotly
import plotly.express as px

app = dash.Dash(__name__)
server = app.server

# constructing a BQ client object
client = bigquery.Client()

query = """
    SELECT *
    FROM ML.EXPLAIN_FORECAST(MODEL my_models.annual_temp,
            STRUCT(15 AS horizon, 0.60 AS confidence_level))
"""

query_job = client.query(query) # make an API request

df = query_job.to_dataframe()

fig = px.line(df, x='time_series_timestamp', y ='time_series_data')

app.layout = html.Div(children = [
    html.H1("US Annual Avg Temperature Forecast"),
    html.Div(children ='''An app to see what the expected US avg yearly temperatures might be over the next 15 years.'''),
    dcc.Graph(
        id = 'US Annual Avg Temp Graph',
        figure = fig
    )
])

if __name__ == '__main__':
    app.run_server(debug=True, host="0.0.0.0", port=8080)