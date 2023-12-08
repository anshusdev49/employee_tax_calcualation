class Employee < ApplicationRecord
  validates :first_name, :last_name, :email, :phone_numbers, :doj, :salary, presence: true

  def total_salary
    total_months = (Date.today.year * 12 + Date.today.month) - (doj.year * 12 + doj.month)
    (total_months * salary).to_f
  end

  def loss_of_pay_per_day
    (salary / 30).to_f
  end
end
