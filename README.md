# README

## Setup

The following assumes you've installed `homebrew` or know another way to install these:

  0. `brew install git`
  0. `brew install ruby`
  0. `brew install postgresql`
  0. `brew install redis`
  0. `brew install imagemagick`
  0. `brew install heroku-cli`
  0. `git clone https://github.com/Poutineer/mvp.git` (Or use the ssh version)
  0. `cd mvp`
  0. `bundle install`
  0. `cp sample_env .env`
  0. `brew services start postgresql`
  0. `brew services start redis`
  0. `bin/rake db:create`
  0. `bin/postdeploy`
  0. `bin/rake db:seed`


## Using

In order to start all services run `heroku local`. In order to start the web sever run `bin/web`. In order to start the workers run `bin/worker`.

To go to the website visit `http://localhost:3000`.


## Notes

### New Content Pages

  0. Click "New File" on Github
  1. Paste this path into the name field: `app/views/pages/about.html.erb` (replace `about` with the name of your page)
  2. Add this to the top of the file:
  
  ``` erb
  <% content_for :page_title, "Poutineer - About" %>
  <% content_for :page_types, :information %>
  ```
  3. Write the HTML you need (Replace `About` with the title of your page)
  4. Scroll to the bottom and click "Create a new branch for this commit and start a pull request."
  5. Name your branch (Try `page-information-about`, replace `about` with the name of your page)
  5. Save the file
  6. Make a pull request

### Dashboards

  - Don't allow the user to see primary keys, it's not helpful and confuses things when they should be using slugs.


### Database Models

  - Public models (things that can be accessed from the outside) should have primary key of an UUIDs and slugs. Anything internal should have a bigint primary key
  - Prefer to put business logic into services instead of controllers or models
