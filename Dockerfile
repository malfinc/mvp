FROM heroku/heroku:18-build

ENV WORKSPACE /usr/lib/resources
ENV STACK heroku-18

WORKDIR $WORKSPACE

COPY app/ app/
COPY bin/ bin/
COPY config/ config/
COPY db/ db/
COPY lib/ lib/
COPY storage/ storage/
COPY vendor/ vendor/
COPY config.ru config.ru
COPY Rakefile Rakefile
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN curl -s --location https://github.com/heroku/heroku-buildpack-ruby/archive/master.tar.gz | tar -xzC /tmp/

RUN cd /tmp/heroku-buildpack-ruby-master/ && bin/detect $WORKSPACE && bin/compile $WORKSPACE /tmp/cache /tmp/env

RUN rm /tmp/heroku-buildpack-ruby-master/

SHELL ["bin/docker-entrypoint"]

ENTRYPOINT ["bin/docker-entrypoint"]

CMD ["bin/docker-cmd"]
