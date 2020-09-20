from ruby:2.7.1

LABEL maintainer="raphaelmueller06@gmail.com"

RUN apt-get update -qq \
  && apt-get install -y \
  curl \
  build-essential \
  libpq-dev && \
  curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn \
  && apt-get clean autoclean && apt-get autoremove -y \
  && rm -rf /var/lib/apt /var/lib/dpkg /var/lib/cache /var/lib/log


RUN mkdir /app
WORKDIR /app

# Gems
ADD Gemfile /app/
ADD Gemfile.lock /app/
RUN gem update bundler
RUN bundle install --jobs 5

COPY . /app

EXPOSE 80

CMD ["bin/rails", "s", "--binding", "0.0.0.0", "--port", "80"]
