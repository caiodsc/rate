class RemoveTagsFromMovie < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :tags, :string
  end
end
