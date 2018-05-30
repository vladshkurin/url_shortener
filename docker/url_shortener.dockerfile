FROM ruby:2.4.1
MAINTAINER shkurinvlad@gmail.com
# Install essentials

RUN apt-get update && apt-get install -y wget curl && apt-get install nodejs


RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install
