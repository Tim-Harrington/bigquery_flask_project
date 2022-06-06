import os

from flask import Flask
from flask_restful import Api
from google.cloud import bigquery


#Borrowing logic from Erin McMahon's code from week 3 demo discussion
app = Flask(__name__)
api = Api(app)

client = bigquery.Client()

@app.route("/")
def query_data():
    query = """
    SELECT *
    FROM bigquery-public-data.world_bank_health_population
    LIMIT 10
    """
    query_job = client.query(query)

    df = query_job.to_dataframe()
    json_object = df.to_json(orient='records')

    return json_object


if __name__ == "__main__":
    app.run(port=8080, host="0.0.0.0")
