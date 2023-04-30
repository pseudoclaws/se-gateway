FROM --platform=linux/amd64 ruby:3.2.2 AS assets

WORKDIR /app

ADD https://dl.yarnpkg.com/debian/pubkey.gpg /tmp/yarn-pubkey.gpg
RUN bash -c "set -o pipefail && apt-get update \
  && apt-get install -y --no-install-recommends build-essential curl git libpq-dev ca-certificates \
  && apt-key add /tmp/yarn-pubkey.gpg \
  && rm /tmp/yarn-pubkey.gpg"

RUN bash -c "curl https://deb.nodesource.com/setup_18.x | bash \
  && echo 'deb https://dl.yarnpkg.com/debian/ stable main' | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y --no-install-recommends nodejs yarn \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean \
  && mkdir /node_modules"

COPY Gemfile* ./
RUN bundle config set force_ruby_platform true
RUN bundle install --without development test --jobs "$(nproc)"

COPY package.json yarn.lock ./
RUN yarn install

#ARG RAILS_ENV="production"
#ARG NODE_ENV="production"
#ENV RAILS_ENV="${RAILS_ENV}" \
#    NODE_ENV="${NODE_ENV}"
#    PATH="${PATH}:/home/deploy/.local/bin:/node_modules/.bin"

COPY . .

RUN if [ "${RAILS_ENV}" != "development" ]; then \
  SECRET_KEY_BASE=dummyvalue rails assets:precompile; fi

CMD ["bash"]

###############################################################################

FROM --platform=linux/amd64 ruby:3.2.2 AS app

WORKDIR /app

ADD https://dl.yarnpkg.com/debian/pubkey.gpg /tmp/yarn-pubkey.gpg
RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential curl libpq-dev ca-certificates \
  && apt-key add /tmp/yarn-pubkey.gpg \
  && rm /tmp/yarn-pubkey.gpg \
  && curl https://deb.nodesource.com/setup_18.x | bash \
  && apt-get update && apt-get install -y --no-install-recommends nodejs yarn \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean

ARG RAILS_ENV="production"
ENV RAILS_ENV="${RAILS_ENV}" \
    PATH="${PATH}:/home/deploy/.local/bin"

COPY --chown=deploy:deploy --from=assets /usr/local/bundle /usr/local/bundle
COPY --chown=deploy:deploy --from=assets /app/public /public
COPY --chown=deploy:deploy . .
RUN chmod 0755 bin/*

ENTRYPOINT ["/app/bin/docker-entrypoint-web"]

EXPOSE ${DOCKER_WEB_PORT:-5000}

# Configure the main process to run when running the image
CMD ./docker-entrypoint.sh
