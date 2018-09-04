class AddTotalDislikesToMovie < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :total_dislikes, :integer
  end
end
