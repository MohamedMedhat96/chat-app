FROM ruby:2.6.8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs && apt-get install -y dos2unix
RUN apt-get install bash
RUN mkdir /app
WORKDIR /app 
ADD . /app
ADD Gemfile /Gemfile
ADD Gemfile.lock /Gemfile.lock
RUN gem install bundler -v 2.2.31
ENV BUNDLER_VERSION 2.2.31
RUN bundle install
COPY bin/wait-for-it.sh /app/bin/wait-for-it.sh
RUN dos2unix bin/docker-start
RUN dos2unix bin/wait-for-it.sh
RUN chmod +x bin/docker-start
RUN chmod 755 bin/wait-for-it.sh