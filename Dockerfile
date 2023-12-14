FROM ruby:3.2.2-alpine

# Update system
RUN apk update && apk upgrade

# Install dependencies
RUN apk add --no-cache \
  build-base \
  git \
  tzdata

# Copy files
COPY . /app
WORKDIR /app

# Install disco_llama
RUN bundle install && bundle exec rake install

# Run disco_llama
CMD ["disco-llama"]
