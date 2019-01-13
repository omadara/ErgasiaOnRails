# ErgasiaOnRails
Project made for Ruby On Rails course

### Steps to run locally

ErgasiaOnRails requires Ruby version 2+ and Rails 5+ (tested on those only).

Install required gems from Gemfile:
```
bundle install
```

Create database and seed it with seeds.rb file:

```
rake db:setup
```

Optional: To support login and register features with Google+ account set the environment variables 
GOOGLE_CLIENT_ID GOOGLE_CLIENT_SECRET to you got from your [Google Cloud Platform](https://console.cloud.google.com) project.
You can set them on terminal before running rails server (see below) or creating `config/app_environment_variables.rb` like so:
```ruby
ENV["GOOGLE_CLIENT_ID"] = "....."
ENV["GOOGLE_CLIENT_SECRET"] = "....."
```

Start Rails server:
```
rails server -b 127.0.0.1 -p 3000 -e development
```

Browse `localhost:3000` and ready to go!