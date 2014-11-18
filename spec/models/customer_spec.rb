require 'rails_helper'

RSpec.describe Customer, :type => :model do
  context "validations" do
    it "name must be unique" do
      Customer.create! name: "Bob's Burgers"
      customer = Customer.new name: "Bob's Burgers"
      expect(customer).to_not be_valid
      expect(customer.errors[:name]).to include("has already been taken")
    end
  end
end
