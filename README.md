# README

## Setup

The following assumes you've installed `homebrew` or know another way to install these:

  0. `brew install git`
  0. `brew install ruby`
  0. `brew install postgresql`
  0. `brew install redis`
  0. `brew install imagemagick`
  0. `brew install heroku cli`
  0. `git clone https://github.com/Poutineer/mvp.git` (Or use the ssh version)
  0. `cd mvp`
  0. `bundle install`
  0. `bin/rake db:create`
  0. `bin/postdeploy`


## Using

In order to start all services run `heroku local`. In order to start the web sever run `bin/web`. In order to start the workers run `bin/worker`.

To go to the website visit `http://localhost:3000`.
