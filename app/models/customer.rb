class Customer < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :projects
end
