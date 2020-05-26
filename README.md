# Kollegorna asdf Docker Image

This docker image(s) are used in our development environments. We use [asdf](https://asdf-vm.com/) to be able to switch node/yarn versions with ease.

## Dockerfile

Here is the standardized `Dockerfile` (it changes between language and projects though) we use here at [Kollegorna](https://kollegorna.se):

```Docker
FROM docker.pkg.github.com/kollegorna/asdf-docker/ruby:2.7.1

# Setup environment variables that will be available to the instance
ARG GITHUB_ACCESS_TOKEN
ARG DEBIAN_FRONTEND=noninteractive
ENV APP_HOME /app
ENV GEM_HOME /asdf/.gems
ENV GEM_PATH /asdf/.gems

USER root
RUN apt-get update
RUN apt-get install -y tzdata
RUN apt-get install -y libv8-dev pkg-config libpq-dev
RUN mkdir -p $APP_HOME
RUN chown -R asdf:asdf $APP_HOME

# CD the folder
USER asdf
WORKDIR $APP_HOME

# Add any missing tools
ADD .tool-versions $APP_HOME
RUN cd $APP_HOME
RUN asdf install
RUN asdf current

# Fix gem path
RUN mkdir -p "$GEM_PATH" && chown asdf:asdf "$GEM_PATH"
RUN gem install bundler

# Needs to be run inside of the folder that has .tool-versions
RUN npm config set @kollegorna:registry https://npm.pkg.github.com/
RUN bundle config github.com ${GITHUB_ACCESS_TOKEN}:x-oauth-basic
RUN bundle config rubygems.pkg.github.com ${GITHUB_ACCESS_TOKEN}:x-oauth-basic
RUN echo "//npm.pkg.github.com/:_authToken=${GITHUB_ACCESS_TOKEN}" >> ~/.npmrc

# Needed due to docker volumes only give you root:root chown by default.
RUN mkdir -p "$APP_HOME/tmp/cache" && chown asdf:asdf "$APP_HOME/tmp/cache"
RUN mkdir -p "$APP_HOME/node_modules" && chown asdf:asdf "$APP_HOME/node_modules"
```

## NodeJS

Use our standardized `Dockerfile` and it should grab the version from `.tool-versions` on build.

If you change the version at anytime you will have to rebuild the image as that is built on build.

## Ruby images

Ruby doesn't provide a good way of just downloading an executable like how NodeJS does it. So we have several images with different ruby versions that have Ruby pre-compiled.

A new project **should always** use the latest Rails-supported version.

### Versions

Currently supported versions:

* 2.4.9 (end of life march 2020)
* 2.6.4
* 2.6.5
* 2.6.6
* 2.7.1