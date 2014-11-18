class DropStatusFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :status, :string
  end
end
