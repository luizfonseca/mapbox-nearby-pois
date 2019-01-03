FROM ruby:2.5.3-alpine

RUN apk add build-base bash git

RUN mkdir /app
WORKDIR /app

EXPOSE 3300
COPY . /app

RUN bundle install
