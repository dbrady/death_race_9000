require 'rails_helper'

describe Ability do
  let(:alice) { User.new(first_name: "Alice", last_name: "Smith", email: "alice.smith@example.com", password: "superbrain").tap {|u| u.roles << :admin } }

  let(:bob) { User.new(first_name: "Bob", last_name: "Dobson", email: "bob.dobson.42@example.com", password: "The cake is a lie").tap {|u| u.roles << :moderator } }

  let(:carol) { User.new(first_name: "Carol", last_name: "Johnson", email: "cj42@example.com", password: "redpen").tap {|u| u.roles << :editor } }

  let(:dave) { User.new(first_name: "Dave", last_name: "Brady", email: "dbrady@example.com", password: "pigtruck").tap {|u| u.roles << :user } }



  context "when user is admin" do
  end

  context "when user is moderator" do
    it "can edit users" do
      ability = Ability.new(bob)
      expect(ability.can?(:edit, alice)).to be_truthy
    end
  end
end
