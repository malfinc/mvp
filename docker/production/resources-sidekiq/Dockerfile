FROM heroku/heroku:18-build as build

ARG RAILS_MASTER_KEY

ENV RAILS_ENV production
ENV STACK heroku-18
ENV PORT 3000

WORKDIR /home/application/

RUN curl -s --location https://github.com/heroku/heroku-buildpack-ruby/archive/master.tar.gz | tar -xzC .

COPY config.ru config.ru
COPY Rakefile Rakefile
COPY Gemfile.lock Gemfile.lock
COPY Gemfile Gemfile
COPY bin/rails bin/rails
COPY bin/rake bin/rake
COPY bin/docker-entrypoint-ruby bin/docker-entrypoint
COPY bin/docker-cmd-resources-sidekiq bin/docker-cmd
COPY bin/sidekiq bin/sidekiq
COPY lib/ lib/
COPY config/ config/
COPY db/ db/
COPY app/ app/
COPY vendor/ vendor/

RUN heroku-buildpack-ruby-master/bin/detect /home/application/
RUN heroku-buildpack-ruby-master/bin/compile /home/application/ /tmp/cache /tmp/env

FROM heroku/heroku:18

ENV RAILS_ENV production
ENV PORT 3000

RUN useradd --create-home application

USER application

WORKDIR /home/application/

VOLUME /home/application/

COPY --chown=application --from=build /home/application/ /home/application/

EXPOSE $PORT

SHELL ["bin/docker-entrypoint"]

ENTRYPOINT ["bin/docker-entrypoint"]

CMD ["bin/docker-cmd"]
