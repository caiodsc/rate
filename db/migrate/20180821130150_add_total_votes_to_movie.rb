class AddTotalVotesToMovie < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :total_votes, :integer
  end
end
