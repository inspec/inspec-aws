FROM ruby:2.5

COPY Gemfile .

RUN bundle install \
    && gem list && apt-get update \
    && apt-get install unzip

WORKDIR /app

CMD ["rake"]