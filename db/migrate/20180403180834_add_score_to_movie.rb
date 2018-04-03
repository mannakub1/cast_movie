class AddScoreToMovie < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :score, :integer
    add_column :movies, :num_review, :integer
  end
end
