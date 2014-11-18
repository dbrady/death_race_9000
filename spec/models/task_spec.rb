require 'rails_helper'

RSpec.describe Task, :type => :model do
  let(:project) { Project.new }
  let(:task) { Task.new project: project, name: "Test Task" }

  context "validations" do
    %i(project name).each do |attr|
      it "requires #{attr}" do
        task.send "#{attr}=", nil
        expect(task).to_not be_valid
        expect(task.errors.messages[attr]).to include("can't be blank")
      end
    end
  end

  # Temp hack until I can get Customer -> Project -> Task selection working
  describe "#fully_qualified_name" do
    let(:customer) { Customer.new name: "ABC" }
    let(:project) { Project.new customer: customer, name: "The Project" }
    let(:task) { Task.new project: project, name: "Do A Thing" }

    it "concats customer - project - task together" do
      expect(task.fully_qualified_name).to eq("ABC - The Project: Do A Thing")
    end
  end
end
