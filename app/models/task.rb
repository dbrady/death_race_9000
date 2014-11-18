class Task < ActiveRecord::Base
  belongs_to :project
  validates :project_id, presence: true, if: "project.nil?"
  validates :project, presence: true, if: "project_id.nil?"
  validates :name, presence: true

  has_many :time_entries

  def project_name
    project.andand.name || ""
  end

  def fully_qualified_name
    "%s - %s: %s" % [customer_name, project_name, name]
  end

  def project_name
    project.andand.name || "(No Project)"
  end

  def customer_name
    project.andand.customer_name || "(No Customer)"
  end
end
