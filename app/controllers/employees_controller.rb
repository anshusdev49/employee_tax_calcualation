class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      render json: @employee, status: :created
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @employee
  end

  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    head :no_content
  end

  def tax_deduction
    employees = Employee.where('doj <= ?', Date.today.end_of_month)
    result = []

    employees.each do |employee|
      total_salary = employee.total_salary
      tax_amount = calculate_tax(total_salary)
      cess_amount = total_salary > 2500000 ? total_salary * 0.02 : 0

      result << {
        id: employee.id,
        first_name: employee.first_name,
        last_name: employee.last_name,
        yearly_salary: total_salary,
        tax_amount: tax_amount,
        cess_amount: cess_amount
      }
    end

    render json: result
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :doj, :salary, :phone_numbers => [])
  end

  def calculate_tax(salary)
    case salary
    when 0..250000
      0
    when 250001..500000
      (salary - 250000) * 0.05
    when 500001..1000000
      (500000 * 0.05) + (salary - 500000) * 0.1
    else
      (500000 * 0.05) + (500000 * 0.1) + (salary - 1000000) * 0.2
    end
  end
end
