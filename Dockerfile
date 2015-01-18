FROM ruby:2.1.5

RUN mkdir -p /code
WORKDIR /code
COPY Gemfile /code/
COPY Gemfile.lock /code/

RUN bundle install
ADD . /code
