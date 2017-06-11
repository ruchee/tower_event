FROM daocloud.io/ruby:2.4.1

ADD sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y --force-yes build-essential libssl-dev libpq-dev libxml2-dev libxslt1-dev nodejs git imagemagick libbz2-dev libjpeg-dev libevent-dev libmagickcore-dev libffi-dev libglib2.0-dev zlib1g-dev libyaml-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY . $APP_HOME

ENV RAILS_ENV production
ENV SECRET_KEY_BASE e172b7dec03898920543f6fe61df44a8dde0ff8e92b7a552c6e38b4db565b6160faf4b56d600cb05343641fac6bd59c12a89f920cfaceac4cb5e8f9df764b85d

# RUN bundle install
RUN bundle install --local

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
