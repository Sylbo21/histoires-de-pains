class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :role
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :address
      t.string :npa
      t.string :city

      t.timestamps
    end
  end
end
