class AddVotesUpCountToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :total_likes, :integer
  end
end
