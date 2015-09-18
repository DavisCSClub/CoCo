class Question < ActiveRecord::Base
  validates :title, :body, :answer, presence: true, uniqueness: true
end
