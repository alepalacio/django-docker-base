# syntax=docker/dockerfile:1
FROM python:3.9.7-buster
EXPOSE 8000
ENV PYTHONUNBUFFERED=1
WORKDIR /code
COPY requirements.txt /code/
RUN apt-get update && apt-get install nano && pip install -r requirements.txt
COPY . /code/

