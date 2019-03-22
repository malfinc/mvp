FROM heroku/heroku:18-build as build

ENV NODE_ENV production
ENV STACK heroku-18
ENV PORT 3000

WORKDIR /home/application/

RUN curl -s --location https://github.com/heroku/heroku-buildpack-nodejs/archive/master.tar.gz | tar -xzC .

COPY .babelrc .babelrc
COPY package.json package.json
COPY package-lock.json package-lock.json
COPY webpack.config.js webpack.config.js
COPY bin/docker-entrypoint-node bin/docker-entrypoint
COPY bin/docker-cmd-browser-client bin/docker-cmd
COPY assets/ assets/
COPY client/ client/
COPY server/ server/
COPY @internal/ @internal/

RUN heroku-buildpack-nodejs-master/bin/detect /home/application/
RUN heroku-buildpack-nodejs-master/bin/compile /home/application/ /tmp/cache /tmp/env

FROM heroku/heroku:18

ENV NODE_ENV production
ENV PORT 3000

RUN useradd --create-home application

USER application

WORKDIR /home/application/

VOLUME /home/application/

COPY --chown=application --from=build /home/application/package.json /home/application/package.json
COPY --chown=application --from=build /home/application/package-lock.json /home/application/package-lock.json
COPY --chown=application --from=build /home/application/.heroku/ /home/application/.heroku/
COPY --chown=application --from=build /home/application/bin/ /home/application/bin/
COPY --chown=application --from=build /home/application/tmp/server/ /home/application/server/
COPY --chown=application --from=build /home/application/tmp/client/ /home/application/client/
COPY --chown=application --from=build /home/application/node_modules/ /home/application/node_modules/
COPY --chown=application --from=build /home/application/.profile.d/ /home/application/.profile.d/

EXPOSE $PORT

SHELL ["bin/docker-entrypoint"]

ENTRYPOINT ["bin/docker-entrypoint"]

CMD ["bin/docker-cmd"]
