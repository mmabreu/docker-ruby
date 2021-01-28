FROM ruby:2.5

# Install apt based dependencies required to run Rails as 
# well as RubyGems. As the Ruby image itself is based on a 
# Debian image, we use apt-get to install those.
RUN apt-get update && apt-get install -y \ 
  git build-essential nodejs vim-tiny locales

RUN echo 'en_US.UTF-8 UTF-8' >/etc/locale.gen && /usr/sbin/locale-gen

WORKDIR /
RUN git clone https://bitbucket.org/smart6internet/zbxapi.git

# Configure the main working directory. This is the base 
# directory used in any further RUN, COPY, and ENTRYPOINT 
# commands.
RUN mkdir -p /app 
WORKDIR /app

# Workaround for illegal instruction due to heavy optimization on sassc gem
# https://github.com/sass/sassc-ruby/issues/146#issuecomment-542288556
ENV BUNDLE_BUILD__SASSC=--disable-march-tune-native
