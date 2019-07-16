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

# Signup API

  - Create registration controller app/controllers/api/v1/registrations_controller.rb

  - Createte the class

  ```ruby
    class Api::V1::RegistrationsController < Devise::RegistrationsController
      before_action(:ensure_params_exit, only: :create)

      def create
        #code
        user = User.new user_params
        if user.save
          render json: {
            message: "Signedup successfully",
            is_success: true,
            data: {
              user: user
            }
          }, status: :ok
        else
          render json: {
            messages: "something wrong",
            is_succeess: false,
            data: {}
          }, status: :unprocessable_entity
        end
      end

      private
      def user_params
        #code
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

      def ensure_params_exit
        #code
        return if params[:user].present?
        render json: {
          messages: "Missing params",
          is_success: false,
          data: {}
        }, status: :bad_request
      end

    end
  ```

  - Check  the list of staus ruby on rails in this [Link](https://gist.github.com/mlanett/a31c340b132ddefa9cca)

  - Config the routes in config/routes

  ```ruby
    namespace :api, defaults: {format: :json} do
      namespace :v1 do
        devise_scope :user do
          post "sign_up", to: "registrations#create"
        end
      end
    end
  ```

# Test sign up with Postman

- Refactoring the code inside of controllers/concerns/response.rb

  ```ruby
    module Response
      def json_response message, is_success, data, status
          render json: {
              messages: messages,
              is_success: is_success,
              data: data
          }, staus: status
      end
    end
  ```

  - And change the file controllers/api/v1/registratios_controller.rb

  ```ruby
    class Api::V1::RegistrationsController < Devise::RegistrationsController
      before_action :ensure_params_exit, only: :create
      skip_before_action :verify_authenticity_token

      def create
        #code
        user = User.new user_params
        if user.save
          json_response "Signed Up successfully", true, {user: user}, :ok
        else
          json_response "Something wrong", false, {}, :unprocessable_entity
        end
      end

      private
      def user_params
        #code
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

      def ensure_params_exit
        #code
        return if params[:user].present?
          json_response "Missing Params", false, {}, :bad_request
        
      end
    end
  ```

  - Got to Postman application and test the API, choose post, set the URL 'localhost:3000/api/v1/sign_up' select body and fill the camps with the information like: "user[email], user[password], user[password_confirmation]" and hit the buttom "SEND"

  


  