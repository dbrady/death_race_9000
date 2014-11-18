class Project < ActiveRecord::Base
  belongs_to :customer
  validates :customer_id, presence: true, if: "customer.nil?"
  validates :customer, presence: true, if: "customer_id.nil?"
  validates :name, presence: true

  has_many :tasks

  def customer_name
    customer.andand.name || "(No Customer)"
  end
end
