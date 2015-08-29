class User < ActiveRecord::Base
  validates :name, presence: true
  validates :team, presence: true
  validates :email, presence: true
end
