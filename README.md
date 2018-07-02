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


## Services

  - We use github for source control
  - We use heroku for our application server
  - We use logdna for logging
  - We use slack to communicate
  - The design team uses trello for features
  - The engineering team uses github projects for tasks
  - We use circle CI to run tests, check for style breaks, and security issues


## Using

In order to start all services run `heroku local`. In order to start the web sever run `bin/web`. In order to start the workers run `bin/worker`.

To go to the website visit `http://localhost:3000`.


## Notes

### Writing tests

  - Generally, if you're not sure if something works right away then write a test.
  - If it fails to work 3 times, definitely write a test.
  - Get poorly designed tests written first, then refine them after you're sure the thing works.
  - If you're dealing with the database, be sure to wrap your tests in PaperTrail configuration.


### New Content Pages

  - Click "New File" on Github
  - Paste this path into the name field: `app/views/pages/about.html.erb` (replace `about` with the name of your page)
  - Add this to the top of the file (replace "About" with your page topic):
    ``` erb
    <% content_for :page_title, "Poutineer - About" %>
    <% content_for :page_types, :information %>
    ```
  - Write the HTML you need (Replace `About` with the title of your page)
  - Scroll to the bottom and click "Create a new branch for this commit and start a pull request."
  - Name your branch (Try `page-information-about`, replace `about` with the name of your page)
  - Save the file
  - Make a pull request


### Dashboards

  - Don't allow the user to see primary keys, it's not helpful and confuses things when they should be using slugs.


### Database Models

  - Public models (things that can be accessed from the outside) should have primary key of an UUIDs and Friendly slugs.
  - Private models should have a bigint primary key.
  - Prefer to put business logic into operations (`app/operations/`) instead of controllers or models.

### Decorators

  - We prefer to wrap any user-facing models in decorators. So for HTML requests this means new, show, and edit.
  - Any sort of presentational logic should be in a decorator.

### Ephemeral/Temporary Models

  - If you're working with a resource that is "computed" then use `ApplicationComputed`. It provides some helpful methods.
  - If your computed data needs to stay around beyond a single cycle then use the `RedisBacked` concern.

### Policies

  - All policies should have scopes and those scopes should do very little work if you're not authenticated. For example, don't search the entire database if your user is not logged in!

### Controllers

  - Controllers should go through three steps (as needed):
    0. Determine authentication needs
    0. Initialize resource
    0. Authorize resource usage
