FROM ruby:2.5.3-alpine

RUN apk add build-base bash git

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/
COPY Gemfile.lock /app

RUN bundle install

EXPOSE 3300
COPY . /app

