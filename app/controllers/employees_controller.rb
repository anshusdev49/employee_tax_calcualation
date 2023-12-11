class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy, :tax_deduction]

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
end
