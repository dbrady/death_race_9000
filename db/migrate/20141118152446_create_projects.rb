class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :customer, null: false, index: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
