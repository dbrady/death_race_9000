require 'rails_helper'

RSpec.describe TimeEntry, :type => :model do
  # BARF BARF BARF BARF BARF BARF
  let(:user) { User.create! first_name: "A", last_name: "Tester", email: "barf@example.com", password: "barfbarfbarf" }
  let(:customer) { Customer.create! name: "Slow Test Suites Inc"}
  let(:project) { Project.create! customer: customer, name: "Top Sekrit Mobile Appz"}
  let(:task) { Task.create! project: project, name: "Worky work work" }
  let(:time_entry) { TimeEntry.create! user: user, task: task, timer: 15.minutes.ago, description: "Surfed YouTube" }

  context "validations" do
    %i(user task description).each do |attr|
      it "requires #{attr}" do
        time_entry.send "#{attr}=", nil
        expect(time_entry).to_not be_valid
        expect(time_entry.errors.messages[attr]).to include("can't be blank")
      end
    end
  end

  describe "#start!" do
    let(:time_entry) { TimeEntry.create! user: user, task: task, timer: nil, description: "Surfed YouTube" }

    it { expect(time_entry).to_not be_running }

    context "when timer is stopped" do
      it "starts the timer" do
        time_entry.start!
        expect(time_entry).to be_running
      end
    end
  end

  require 'pry'

  describe "#stop!" do

    it { expect(time_entry).to be_running }

    context "when timer is running" do
      it "stops the timer" do
        time_entry.stop!
        expect(time_entry).to_not be_running
      end

      it "accumulates accrued time" do
        expect {
          time_entry.stop!
        }.to change(time_entry, :seconds) # .by.at_least(900)
      end
    end
  end

  describe "#running?" do
    let(:time_entry) { TimeEntry.new timer: Time.now }

    it { expect(time_entry).to be_running }

    context "when timer is started" do
      it "is running" do
        expect(time_entry).to be_running
      end
    end

    context "when timer is stopped" do
      it "is not running" do
        time_entry.timer = nil
        expect(time_entry).to_not be_running
      end
    end
  end

  # describe "#elapsed_time"
end
