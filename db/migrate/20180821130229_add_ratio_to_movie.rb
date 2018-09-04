class AddRatioToMovie < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :ratio, :float
  end
end
