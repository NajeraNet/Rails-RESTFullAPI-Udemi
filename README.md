# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Application

* Install gem rack-cors

* Add the configuration in config/application

  ```ruby
  config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: [:get, :post, :options]
    end
  end
  ```

# Authentication System

* Install gem devise and install in the console

  > rails g devise:install

* Install the user mvc with devise

  > rails g devise User

* Run migrate

  > rails db:migrate

* Setting up the authentication token

  - install the gem simple authentication, watch this [LINK](https://github.com/gonzalo-bulnes/simple_token_authentication)

  - In the model user.rb add..

    ```ruby
      acts_as_token_authenticatable
    ```

  - And make the migration

    >rails g migration add_authentication_token_to_users "authentication_token:string{30}:uniq"

  - Run migration

  - Check in the console rails if there are the field authentication_token

    > rails c
    User.column_names

  -
