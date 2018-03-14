FROM ruby:alpine
RUN apk --no-cache add build-base postgresql-dev nodejs tzdata yarn
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
RUN yarn init --yes
RUN yarn add react react-dom
COPY . /myapp
