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
    new_seconds = elapsed_time
    update_attributes(seconds: new_seconds, timer: nil)
  end

  def task_name
    task.andand.name || ""
  end

  def project_name
    task.andand.project_name || ""
  end

  def display_time
    seconds = elapsed_time
    sec = seconds % 60
    seconds -= sec
    min = (seconds % 3600)/60
    seconds -= min * 60
    hrs = seconds / 3600
    "%d:%02d:%02d" % [hrs, min, sec]
  end

  def elapsed_time
    time = seconds || 0
    if running?
      stop = Time.now.to_i
      start = timer
      time += (stop - start)
    end
    time
  end
end
