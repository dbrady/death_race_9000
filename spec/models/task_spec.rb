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
end
