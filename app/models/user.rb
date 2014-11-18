require 'role_model'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  VALID_STATUSES = %w(alive infected zombie dead)
  validates :status, inclusion: {in: VALID_STATUSES, message: "is not included in the list: #{VALID_STATUSES.inspect}"}

  include RoleModel
  roles :admin, :moderator, :editor, :user

  def full_name
    "#{first_name} #{last_name}"
  end
end
