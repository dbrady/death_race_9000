class TimeEntry < ActiveRecord::Base
  belongs_to :person
  belongs_to :task

  validates :person_id, presence: true, if: "person.nil?"
  validates :person, presence: true, if: "person_id.nil?"
  validates :task_id, presence: true, if: "task.nil?"
  validates :task, presence: true, if: "task_id.nil?"

  validates :description, presence: true

end
