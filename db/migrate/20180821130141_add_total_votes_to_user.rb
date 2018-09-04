class AddTotalVotesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :total_votes, :integer
  end
end
