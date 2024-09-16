## Yellow Demo App

Creates a simple app with the following functionality:
- Create a customer and conduct validity checks
- Associate valid customers with a IMEI number
- Allow for payment for the new phone (successful or unsuccessful)

#### Running the app

Requirements:
- Postgres 12 or higher, running on your computer
- Ruby 3.2.2 (Available through `rvm` or `rbenv`)

To install the app:
- `git clone` this repo
- `cd yellow-demo`
- `bundle` (installs dependencies)
- `rails db:create` and `rails db:migrate` (sets up the database)
- `rails server` (runs the server)
- visit `localhost:3000` in the browser

#### Models & tables

There are 3 models and associated tables. The fields for each model are annotated in each file. The validations are visible in the code itself.

- [Customer](https://github.com/khannotations/yellow-demo/blob/main/app/models/customer.rb)
- [Phone](https://github.com/khannotations/yellow-demo/blob/main/app/models/phone.rb)
- [Payment](https://github.com/khannotations/yellow-demo/blob/main/app/models/payment.rb)


#### Controllers

Each flow through the app is managed by a controller corresponding to each model. 

- [CustomersController](https://github.com/khannotations/yellow-demo/blob/main/app/controllers/customers_controller.rb)
- [PhonesController](https://github.com/khannotations/yellow-demo/blob/main/app/controllers/phones_controller.rb)
- [PaymentsController](https://github.com/khannotations/yellow-demo/blob/main/app/controllers/payments_controller.rb)

The customer and phones controller support POST requests to create the associated models, while the payments controller supports both a POST request to create a payment, as well as a PUT request to update the status of the payment (which the payment provider would call back to).

Additionally, the phones and payments functionality is blocked unless the associated user is approved, which only happens with the presence of KYC info and a valid birthday (and any other characteristics we might determine in the future).

#### Tests

Tests are conducted with `rspec` and live in the `spec` folder. Currently, the codebase has 99% test coverage.
<img width="558" alt="Test coverage" src="https://github.com/user-attachments/assets/e955bba2-7361-4114-8cef-c22753f4a8bc">

To run the tests, simply execute `rspec spec` from the main directory. (`bundle exec rspec spec` may be necessary in some cases.)

#### Deployment

Currently, the app is deployed to [https://yellow-demo.fly.dev](https://yellow-demo.fly.dev).

