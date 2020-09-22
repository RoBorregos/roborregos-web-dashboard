FROM ruby:2.5.3

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN mkdir /app

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler -v 2.0.1
RUN bundle install --jobs=4 --retry=3 --without development test

COPY . /app

COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]

EXPOSE 3000

CMD [ "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
