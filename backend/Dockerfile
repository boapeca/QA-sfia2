FROM python:3.7

WORKDIR ./app
# RUN apt-get update && apt-get install -y python3-pip && apt-get install python3-pymysql

COPY . .
#RUN pip install Flask
#RUN pip install Flask-SQLAlchemy
#RUN pip install PyMySQL[rsa]
RUN pip install -r requirements.txt
# RUN pip install cryptography
EXPOSE 5001
# Run 'python app.py' on container start-up. This is the main process.
ENTRYPOINT ["/usr/local/bin/python", "app.py"]
