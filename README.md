# README

## Setup

  1. install git
  2. install ruby
  3. install postgresql
  4. install redis
  5. install imagemagick
  6. install heroku cli
  7. clone this repository
  8. run `bundle install`
  9. run `bin/rake db:create`
  10. run `bin/postdeploy`


## Using

In order to start all services run `heroku local`. In order to start the web sever run `bin/web`. In order to start the workers run `bin/worker`.

To go to the website visit `http://localhost:3000`.
