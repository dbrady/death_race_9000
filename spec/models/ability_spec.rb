require 'rails_helper'

describe Ability do
  let(:alice) { User.new(first_name: "Alice", last_name: "Smith", email: "alice.smith@example.com", password: "superbrain").tap {|u| u.roles << :admin } }

  let(:bob) { User.new(first_name: "Bob", last_name: "Dobson", email: "bob.dobson.42@example.com", password: "The cake is a lie").tap {|u| u.roles << :employee } }

  context "when user is admin" do
    it "can edit users" do
      ability = Ability.new(alice)
      expect(ability.can?(:edit, bob)).to be_truthy
    end
  end
end
