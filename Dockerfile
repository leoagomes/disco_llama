FROM ruby:3.2.2-alpine

# Update system
RUN apk update && apk upgrade

# Install dependencies
# no dependencies yet

# Copy files
COPY . /app
WORKDIR /app

# Install disco_llama
RUN bundle exec rake install

# Run disco_llama
CMD ["disco_llama"]
