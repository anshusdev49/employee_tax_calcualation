# spec/factories/employees.rb

FactoryBot.define do
  factory :employee do
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'john.doe@example.com' }
    phone_numbers { '1234567890' }
    doj { '2022-01-01' }
    salary { 50000 }
  end
end
