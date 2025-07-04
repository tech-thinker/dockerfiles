FROM ruby:2.7
LABEL maintainer="Tech Thinker <https://techthinker.js.org>"

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler -v 2.1.4
RUN bundle install
