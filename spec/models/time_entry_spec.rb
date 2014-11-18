require 'rails_helper'

RSpec.describe TimeEntry, :type => :model do
  let(:person) { Person.new }
  let(:task) { Task.new }
  let(:time_entry) { TimeEntry.new }

  context "validations" do
    %i(person task description).each do |attr|
      it "requires #{attr}" do
        time_entry.send "#{attr}=", nil
        expect(time_entry).to_not be_valid
        expect(time_entry.errors.messages[attr]).to include("can't be blank")
      end
    end
  end
end