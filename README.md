# Employee Managment App (for Tax calcuation)
This is Api based application allows you to calculate taxation employee salary. It's built using Ruby 2.7.8 and utilizes RVM for Ruby version management.

## 1. Prerequisites

bash```
 Bundle install
 ```
## 2. For Running the Test Suite
You can run the test suite with following command.
bash```
bundle exec rspec
```
## 3. For Testing API's
You can use postman to test API's
Step 1. Run rails s to start server.
 API to test

1) Creating Employee data.
   URL: http://localhost:3000/employees
   Method: Post
   Body:
   {
    "id": 1,
    "first_name": "John",
    "last_name": "Doe",
    "email": "john.doe@example.com",
    "phone_numbers": "1234567890",
    "doj": "2022-01-01",
    "salary": 50000
   }

2) Show Api
   URL: http://localhost:3000/employees/1
   Method:Get

3) Tax Amount API
   URL: http://localhost:3000/employees/tax_deduction
   Method: Get
