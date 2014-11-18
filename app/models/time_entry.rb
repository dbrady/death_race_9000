class TimeEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  validates :user_id, presence: true, if: "user.nil?"
  validates :user, presence: true, if: "user_id.nil?"
  validates :task_id, presence: true, if: "task.nil?"
  validates :task, presence: true, if: "task_id.nil?"

  validates :description, presence: true

end
