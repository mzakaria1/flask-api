FROM python:3.6


ENV SECRET_KEY $SECRET_KEY
ENV FLASK_CONFIG "development"
ENV DATABASE_URL $DATABASE_URL

WORKDIR /app
COPY . /app

RUN pip install -r requirements.txt

RUN python manage.py db init
RUN python manage.py db migrate
RUN python manage.py db upgrade

CMD python manage.py runserver
