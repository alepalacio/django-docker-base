# Quickstart for Django and PostgreSQL using Docker.
---
1. First install Docker and Docker Compose.

    [Docker](https://docs.docker.com/engine/install/)

    [Docker Compose](https://docs.docker.com/compose/install/)

2. Create an empty project directory/folder.

3. Create a new file called `Dockerfile` in your project directory.

4. Add the following content to the `Dockerfile`

```
# syntax=docker/dockerfile:1
FROM python:3
ENV PYTHONUNBUFFERED=1
WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt
COPY . /code/

```
5. Save and close the `Dockerfile`

6. Create a `requirements.txt` in your project directory.

7. Add the required software in the file.

```
Django>=3.0,<4.0
psycopg2-binary>=2.8

```
8. Create a file called `docker-compose.yml` in your project directory.

9. Add the following configuration to the file.

```
version: "3.9"
   
services:
  db:
    image: postgres
    volumes:
      - ./data/db:/var/lib/postgresql/data
    environment:
      - POSTGRES_DB=postgres
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
  web:
    build: .
    command: python manage.py runserver 0.0.0.0:8000
    volumes:
      - .:/code
    ports:
      - "8000:8000"
    depends_on:
      - db


```
10. Save and close the `docker-compose.yml` file.

11. Change to the root of your project directory.

12. Create the Django project by running the docker-compose run command as follows.

```
$ sudo docker-compose run web django-admin startproject composeexample .
```

13. After the docker-compose command completes, list the contents of your project.

```
$ ls -l
```

14. In your project directory, settings.py, replace the DATABASES = ... with the following:

```
# settings.py
   
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'postgres',
        'USER': 'postgres',
        'PASSWORD': 'postgres',
        'HOST': 'db',
        'PORT': 5432,
    }
}

```

15. Save and close the file.    

16. Run the `docker-compose up` command from the top level directory for your project.

17. At this point, your Django app should be running at port 8000 on your Docker host. On Docker Desktop for Mac and Docker Desktop for Windows, go to http://localhost:8000 on a web browser to see the Django welcome page.

18. Django running from a Docker container is done!