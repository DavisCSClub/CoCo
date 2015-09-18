class Team < ActiveRecord::Base
  validates :name,     presence: true, uniqueness: true
  validates :password, presence: true

  has_many :users, dependent: :destroy
end
