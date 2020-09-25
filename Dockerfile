FROM ruby:2.5.3

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get update -qq && \
    apt-get install -y \
    postgresql-client \
    build-essential \
    nodejs \
    nano \
    git && \
    rm -rf /var/lib/apt/lists/*
RUN npm install -g yarn
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler -v 2.0.1
RUN bundle install --jobs=4 --retry=3 
#--without development test

COPY . /app

COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]

#RUN RAILS_ENV=production SECRET_KEY_BASE=`cat config/master.key` bin/rails assets:precompile

EXPOSE 3000

CMD [ "rails", "server", "-b", "0.0.0.0"]
