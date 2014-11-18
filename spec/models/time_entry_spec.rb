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

  describe "#display_time" do
    context "with time over 1 hour" do
      let(:time_entry) { TimeEntry.new seconds: 7200 + 900 + 13 }
      it "returns 'HH:MM:SS' string" do
        expect(time_entry.display_time).to eq("2:15:13")
      end
    end

    context "with time under 10 seconds" do
      let(:time_entry) { TimeEntry.new seconds: 3 }
      it "returns 0-padded 'HH:MM:SS' string" do
        expect(time_entry.display_time).to eq("0:00:03")
      end
    end
  end

  describe "#task_name" do
    let(:task) { Task.new name: "Testy" }
    let(:time_entry) { TimeEntry.new task: task}
    it "defers to task" do
      expect(time_entry.task_name).to eq("Testy")
    end

    context "when task is missing" do
      let(:time_entry) { TimeEntry.new }
      it "returns empty string" do
        expect(time_entry.task_name).to eq("")
      end
    end
  end

  describe "#project_name" do
    let(:project) { Project.new name: "Arglebargle"}
    let(:task) { Task.new project: project }
    let(:time_entry) { TimeEntry.new task: task}
    it "defers to task" do
      expect(time_entry.project_name).to eq("Arglebargle")
    end

    context "when task is missing" do
      let(:time_entry) { TimeEntry.new }
      it "returns empty string" do
        expect(time_entry.project_name).to eq("")
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
