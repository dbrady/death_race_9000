class AddStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :string, index: true, default: :alive
  end
end
