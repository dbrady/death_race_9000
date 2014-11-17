require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "validations" do
    let(:user) { User.new }

    %i(first_name last_name email password).each do |required_attr|
      context "with missing #{required_attr}" do
        it "is not valid" do
          expect(user).to_not be_valid
          expect(user.errors.messages[required_attr]).to include("can't be blank")
        end
      end
    end

    context "wtih valid object" do
      it "is valid" do
        expect(User.new(first_name: "Bob", last_name: "Dobson", email: "bob.dobson.42@example.com", password: "The cake is a lie")).to be_valid
      end
    end
  end
end
