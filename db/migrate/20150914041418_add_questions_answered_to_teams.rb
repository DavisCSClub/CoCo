class AddQuestionsAnsweredToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :questions_answered, :integer
  end
end
