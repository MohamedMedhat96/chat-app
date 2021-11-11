FROM ruby:2.6.8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /app
WORKDIR /app 
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN gem install bundler -v 2.2.31
ENV BUNDLER_VERSION 2.2.31
RUN bundle install
ADD . /app
RUN chmod +x bin/entry.sh