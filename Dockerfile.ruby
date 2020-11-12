FROM docker.pkg.github.com/kollegorna/asdf-docker/ubuntu:latest

ENV RUBY_VERSION="2.5.0"

USER root
RUN apt-get update
RUN apt-get install -y pkg-config libpq5 libpq-dev postgresql-client
RUN apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev

USER asdf
RUN echo "bundler" >> /asdf/.default-gems
RUN echo "legacy_version_file = yes" >> /asdf/.asdfrc

# install plugins
RUN asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
RUN asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
RUN asdf plugin-add yarn https://github.com/twuni/asdf-yarn.git

# Install nodejs keyring
RUN chmod +x /asdf/.asdf/plugins/nodejs/bin/import-release-team-keyring
RUN bash /asdf/.asdf/plugins/nodejs/bin/import-release-team-keyring

# install versions
RUN asdf install ruby $RUBY_VERSION

# globalize
RUN asdf global ruby $RUBY_VERSION

# Works?
RUN ruby -v

CMD ["/bin/bash"]
