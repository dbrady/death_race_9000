class Customer < ActiveRecord::Base
  validates :name, uniqueness: true
end
