#official lightweight Python image.
# https://hub.docker.com/_/python
FROM python:3.9-slim

RUN mkdir -p /app
COPY . main.py /app/
WORKDIR /app

# Install production dependencies.
RUN pip install -r requirements.txt
EXPOSE 8080
# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
CMD [ "main.py" ]
ENTRYPOINT [ "python" ]
