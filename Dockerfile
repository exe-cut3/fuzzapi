FROM ruby:2.3.0 

RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 1.16.6 && bundle install --jobs 20 --retry 5

COPY . ./

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]

RUN bundle exec rake db:migrate

CMD ["rails", "server", "-b", "0.0.0.0"]
