class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true 
  validates :name, :team, presence: true

  belongs_to :team
end
