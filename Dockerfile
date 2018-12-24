FROM ruby:2.5.3-alpine

RUN apk add build-base bash git

RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/

RUN bundle install
EXPOSE 3300

ENTRYPOINT [ "ruby", "app.rb" ]