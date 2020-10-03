FROM ruby:2.4.5
RUN apt-get update -qq && apt-get install -y build-essential nodejs default-mysql-client \
    imagemagick libmagick++-dev vim\
    locales locales-all && \
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=ja_JP.UTF-8
ENV LANG="ja_JP.UTF-8" \
    TZ="Asia/Tokyo"
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
