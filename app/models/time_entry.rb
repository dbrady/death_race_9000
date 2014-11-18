class TimeEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  validates :user_id, presence: true, if: "user.nil?"
  validates :user, presence: true, if: "user_id.nil?"
  validates :task_id, presence: true, if: "task.nil?"
  validates :task, presence: true, if: "task_id.nil?"

  validates :description, presence: true

  before_create :set_the_fricking_worked_on_param_already_i_mean_seriously

  def set_the_fricking_worked_on_param_already_i_mean_seriously
    self.worked_on ||= Date.today
  end

  def running?
    timer
  end

  def start!
    update_attribute(:timer, Time.now.to_i)
  end

  def stop!
    accumulated_seconds = timer
    current_time = Time.now.to_i
    start_time = timer
    # binding.pry
    new_seconds = accumulated_seconds + current_time - start_time
    update_attributes(seconds: new_seconds, timer: nil)
  end

end
