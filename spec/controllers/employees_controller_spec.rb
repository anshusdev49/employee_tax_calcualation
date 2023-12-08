# spec/controllers/employees_controller_spec.rb

require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  describe 'POST #create' do
    it 'creates a new employee' do
      employee_params = {
        id: 1,
        first_name: 'John',
        last_name: 'Doe',
        email: 'john.doe@example.com',
        phone_numbers: '1234567890',
        doj: '2022-01-01',
        salary: 50000
      }

      post :create, params: { employee: employee_params }
      expect(response).to have_http_status(:created)

      created_employee = JSON.parse(response.body)
      expect(created_employee['first_name']).to eq('John')
    end
  end

  describe 'GET #show' do
    it 'returns details of a specific employee' do
      employee = FactoryBot.create(:employee)

      get :show, params: { id: employee.id }
      expect(response).to have_http_status(:ok)

      returned_employee = JSON.parse(response.body)
      expect(returned_employee['id']).to eq(employee.id)
    end
  end

  describe 'PATCH #update' do
    it 'updates details of a specific employee' do
      employee = FactoryBot.create(:employee)

      updated_params = { first_name: 'UpdatedName' }

      patch :update, params: { id: employee.id, employee: updated_params } # Change employee_id to id
      expect(response).to have_http_status(:ok)

      updated_employee = JSON.parse(response.body)
      expect(updated_employee['first_name']).to eq('UpdatedName')
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a specific employee' do
      employee = FactoryBot.create(:employee)

      delete :destroy, params: { id: employee.id } # Change employee_id to id
      expect(response).to have_http_status(:no_content)

      expect(Employee.exists?(employee.id)).to be_falsey
    end
  end

  describe 'GET #tax_deduction' do
    it 'calculates tax deduction for employees' do
      FactoryBot.create(:employee, doj: '2022-01-01', salary: 30000)
      employee = FactoryBot.create(:employee, doj: '2022-06-01', salary: 750000)

      get :tax_deduction
      expect(response).to have_http_status(:ok)

      tax_deductions = JSON.parse(response.body)

      tax_deduction = tax_deductions.last
      expect(tax_deduction['id']).to eq(employee.id)
      expect(tax_deduction['tax_amount']).to eq(2575000.0)
    end
  end
end
