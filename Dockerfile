FROM ruby:3.0.2-alpine

RUN apk add --update --virtual \
  runtime-deps \
  postgresql-client \
  build-base \
  libxml2-dev \
  libxslt-dev \
  nodejs \
  yarn \
  libffi-dev \
  readline \
  build-base \
  postgresql-dev \
  libc-dev \
  linux-headers \
  readline-dev \
  file \
  imagemagick \
  git \
  tzdata \
  && rm -rf /var/cache/apk/*

WORKDIR /app
COPY . /app/

ENV BUNDLE_PATH /gems
RUN yarn install
RUN bundle install
#RUN bundle exec rake webpacker:install
#RUN ruby bin/rails webpacker:install

#ENTRYPOINT ["bin/rails"]
#CMD ["s", "-b", "0.0.0.0"]
CMD ruby bin/rails server -b 0.0.0.0

EXPOSE 3000