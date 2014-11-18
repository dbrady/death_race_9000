class Task < ActiveRecord::Base
  belongs_to :project
  validates :project_id, presence: true, if: "project.nil?"
  validates :project, presence: true, if: "project_id.nil?"
  validates :name, presence: true
end
