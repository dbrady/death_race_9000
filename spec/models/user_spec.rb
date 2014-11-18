require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:bob) { User.new(first_name: "Bob", last_name: "Dobson", email: "bob.dobson.42@example.com", password: "The cake is a lie", status: "alive") }

  describe "validations" do
    let(:invalid_user) { User.new }

    %i(first_name last_name email password).each do |required_attr|
      context "with missing #{required_attr}" do
        it "is not valid" do
          expect(invalid_user).to_not be_valid
          expect(invalid_user.errors.messages[required_attr]).to include("can't be blank")
        end
      end
    end

    context "wtih valid object" do
      it "is valid" do
        expect(bob).to be_valid
      end
    end
  end

  describe "#status" do
    %w(alive infected zombie dead).each do |status|
      context "with valid status '#{status}'" do
        it "is valid" do
          bob.status = status
          expect(bob).to be_valid
        end
      end

      %w(sick crazy healthy funny).each do |status|
        context "with invalid status '#{status}'" do
          it "is not valid" do
            bob.status = status
            expect(bob).to_not be_valid
            expect(bob.errors.messages[:status].any? { |msg| msg.starts_with? "is not included in the list"}).to be_truthy
          end
        end
      end
    end
  end

  describe "#full_name" do
    it "returns first_name last_name" do
      expect(bob.full_name).to eq("Bob Dobson")
    end
  end

  describe "roles management" do
    it "starts with no roles set by default" do
      expect(bob).to_not have_role :admin
    end

    context "with admin and editor roles set" do
      it "knows which roles are set" do
        bob.roles = [:admin, :editor]
        expect(bob).to have_role :admin
        expect(bob).to have_role :editor
        expect(bob).to have_all_roles :admin, :editor
      end
    end
  end
end
