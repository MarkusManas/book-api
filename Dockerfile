FROM ruby:3.1.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /book-api

WORKDIR /book-api

COPY Gemfile /book-api/Gemfile
COPY Gemfile.lock /book-api/Gemfile.lock

RUN bundle install
COPY . /book-api
