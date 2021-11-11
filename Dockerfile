FROM ruby:2.5.1 
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /app
WORKDIR /app 
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN gem install bundler -v 2.0.1
ENV BUNDLER_VERSION 2.0.1
RUN bundle install
ADD . /app