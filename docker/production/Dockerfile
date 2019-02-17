FROM heroku/heroku:18-build

ARG RAILS_MASTER_KEY
ARG DATABASE_URI
ARG REDIS_SIDEKIQ_URI
ARG REDIS_OBJECTS_URI
ARG REDIS_CACHE_URI
ARG REDIS_LOCK_URI

ENV WORKDIR /var/www/application/
ENV STACK heroku-18
ENV RAILS_ENV production
ENV PORT 3000

WORKDIR $WORKDIR

VOLUME $WORKDIR

EXPOSE $PORT

COPY config.ru config.ru
COPY Rakefile Rakefile
COPY Gemfile.lock Gemfile.lock
COPY Gemfile Gemfile
COPY bin/ bin/
COPY vendor/ vendor/
COPY lib/ lib/
COPY config/ config/
COPY db/ db/
COPY app/ app/

RUN curl -s --location https://github.com/heroku/heroku-buildpack-ruby/archive/master.tar.gz | tar -xzC /tmp/

RUN cd /tmp/heroku-buildpack-ruby-master/ && bin/detect $WORKDIR && bin/compile $WORKDIR /tmp/cache /tmp/env

RUN rm -r /tmp/heroku-buildpack-ruby-master/

RUN apt-get clean

SHELL ["bin/docker-entrypoint"]

ENTRYPOINT ["bin/docker-entrypoint"]

CMD ["bin/docker-cmd"]
