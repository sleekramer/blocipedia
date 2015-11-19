class User < ActiveRecord::Base
  has_many :wikis
  has_many :collaborators
  has_many :wikis, through: :collaborators

  after_initialize :set_default_role

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:standard, :premium, :admin]

  def set_default_role
    self.role ||= 'standard'
  end

end
