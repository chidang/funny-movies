FROM ruby:2.4.3

RUN apt-get update -q && \
    apt-get install -y build-essential libpq-dev apt-transport-https

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && apt-get install -y nodejs

RUN mkdir /funny_movies
WORKDIR /funny_movies

ADD Gemfile /funny_movies/Gemfile
ADD Gemfile.lock /funny_movies/Gemfile.lock

RUN bundle install

ADD . /funny_movies

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]