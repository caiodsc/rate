class AddTotalLikesToMovie < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :total_likes, :integer
  end
end
