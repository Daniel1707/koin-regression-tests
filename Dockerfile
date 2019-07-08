FROM ruby:2.6

RUN apt-get update && \
    apt-get install -y net-tools

# Install gems
ENV APP_HOME /Risk
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY . $APP_HOME

# Start server
CMD ["ruby", "teste.rb"]
