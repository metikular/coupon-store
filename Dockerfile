FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y postgresql-client

WORKDIR /app
ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_SERVE_STATIC_FILES=true
ENV SECRET_KEY_BASE=tmp

COPY Gemfile /app
COPY Gemfile.lock /app
RUN bundle config set --local without 'development test'; bundle install

ARG CODE_VERSION
ENV CODE_VERSION=${CODE_VERSION:-development}

COPY . /app
RUN bin/rails assets:precompile

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 80

CMD ["rails", "server", "-b", "0.0.0.0", "--port=80"]
