class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :phone_numbers
      t.date :doj
      t.decimal :salary

      t.timestamps
    end
  end
end
