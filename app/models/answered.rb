class Answered < ActiveRecord::Base
  validates :questionID, :teamID, presence: true
  validates_uniqueness_of :questionID, :scope => [:teamID]
end
