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
    @employee = Employee.find(params[:id])
    deduction = @employee.tax_deduction_for_current_year

    render json: deduction
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
