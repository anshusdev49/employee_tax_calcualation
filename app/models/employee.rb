class Employee < ApplicationRecord
  validates :first_name, :last_name, :email, :phone_numbers, :doj, :salary, presence: true
  validate :validate_phone_numbers


  def total_salary
    total_months = (Date.today.year * 12 + Date.today.month) - (doj.year * 12 + doj.month)
    (total_months * salary).to_f
  end

  def loss_of_pay_per_day
    (salary / 30).to_f
  end

  def tax_deduction_for_current_year
    months_worked = (Date.current.year * 12 + Date.current.month) - (doj.year * 12 + doj.month)
    total_salary = salary * months_worked

    # Calculate tax based on slabs
    tax_slabs = [
      { range: 250000, rate: 0.05 },
      { range: 500000, rate: 0.1 },
      { range: 1000000, rate: 0.2 }
    ]

    tax_amount = 0
    remaining_salary = total_salary

    tax_slabs.each do |slab|
      if remaining_salary > 0
        slab_salary = [remaining_salary, slab[:range]].min
        tax_amount += slab_salary * slab[:rate]
        remaining_salary -= slab_salary
      end
    end

    # Collect additional 2% cess for the amount more than 2500000
    additional_cess = [0, (total_salary - 2500000) * 0.02].max

    {
      employee_id: id,
      first_name: first_name,
      last_name: last_name,
      yearly_salary: total_salary,
      tax_amount: tax_amount,
      cess_amount: additional_cess
    }
  end

  private

  def validate_phone_numbers
    if phone_numbers.any? { |number| !number.match?(/\A\d{10}\z/) }
      errors.add(:phone_numbers, 'should be valid 10-digit phone numbers')
    end
  end
end
