class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.references :user, null: false, index: true
      t.references :task, null: false, index: true
      t.date :worked_on, null: false
      t.integer :timer
      t.integer :seconds
      t.string :description

      t.timestamps
    end
  end
end
