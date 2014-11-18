class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.references :user, null: false, index: true
      t.references :task, null: false, index: true
      t.date :worked_on, null: false
      t.timestamp :timer
      t.decimal :hours, :decimal, precision: 6, scale: 2, default: 0.0
      t.string :description

      t.timestamps
    end
  end
end
