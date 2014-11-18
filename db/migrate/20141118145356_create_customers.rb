class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name, null: false, unique: true
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :city
      t.string :state, limit: 2
      t.string :zip, limit: 10
      t.string :phone1, limit: 24
      t.string :phone2, limit: 24
      t.string :fax1, limit: 24
      t.string :fax2, limit: 24
      t.string :email
      t.string :website

      t.timestamps
    end
  end
end
