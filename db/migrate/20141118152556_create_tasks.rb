class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :project, null: false, index: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
