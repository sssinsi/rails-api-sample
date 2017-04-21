FROM ruby:2.4.1

RUN apt-get update && apt-get install -y mysql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/lib/mysql && touch /var/lib/mysql/mysql.sock
ADD ./containers/mysql/my.cnf /etc/

RUN mkdir /myapp
WORKDIR /myapp

COPY ./rails-api/Gemfile /myapp/Gemfile
COPY ./rails-api/Gemfile.lock /myapp/Gemfile.lock

RUN bundle install

COPY ./rails-api /myapp

EXPOSE 3000