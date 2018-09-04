class RemoveTotalLikesAndTotalDislikesAndTotalVotesAndRatioFromMovie < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :total_likes, :integer
    remove_column :movies, :total_dislikes, :integer
    remove_column :movies, :total_votes, :integer
    remove_column :movies, :ratio, :float
  end
end
