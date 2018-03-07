FROM ruby:2.4-alpine
RUN apk --no-cache add build-base postgresql-dev nodejs tzdata
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp
