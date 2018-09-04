class AddRatioToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ratio, :float
  end
end
