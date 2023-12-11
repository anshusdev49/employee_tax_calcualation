class Employee < ApplicationRecord
  validates :first_name, :last_name, :email, :phone_numbers, :doj, :salary, presence: true
  validate :validate_phone_numbers

  private

  def total_salary
    total_months = (Date.today.year * 12 + Date.today.month) - (doj.year * 12 + doj.month)
    (total_months * salary).to_f
  end

  def loss_of_pay_per_day
    (salary / 30).to_f
  end

  def validate_phone_numbers
    if phone_numbers.any? { |number| !number.match?(/\A\d{10}\z/) }
      errors.add(:phone_numbers, 'should be valid 10-digit phone numbers')
    end
  end
end
