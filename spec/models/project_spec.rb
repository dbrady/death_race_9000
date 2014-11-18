require 'rails_helper'

RSpec.describe Project, :type => :model do
  let(:customer) { Customer.new }
  let(:project) { Project.new customer: customer, name: "Test Project" }

  context "validations" do
    %i(customer name).each do |attr|
      it "requires #{attr}" do
        project.send "#{attr}=", nil
        expect(project).to_not be_valid
        expect(project.errors.messages[attr]).to include("can't be blank")
      end
    end
  end
end
