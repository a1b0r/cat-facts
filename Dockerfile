FROM ruby:3.0.3-slim

ENV ENVIRONMENT development
ENV APP_HOME /app

RUN apt-get update -qq && apt-get install -y\
    build-essential\
    curl\
    locales\
    libmariadbclient-dev-compat\
    libxml2-dev\
    libxslt1-dev\
    wget\
    apt-transport-https

# Supress `Warning: apt-key output should not be parsed (stdout is not a terminal)`
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE 1

RUN echo en_US.UTF-8 UTF-8 > /etc/locale.gen
RUN locale-gen
ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list &&\
    apt-get update &&\
    apt-get install -y yarn

# No more calls to apt-get, so the lists could be deleted
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install --jobs $(nproc)

# allow any user to modify gems
RUN chmod -R go+w /usr/local/bundle/

ADD package.json yarn.lock $APP_HOME/
RUN yarn

ADD . $APP_HOME
