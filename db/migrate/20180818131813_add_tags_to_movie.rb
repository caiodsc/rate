class AddTagsToMovie < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :tags, :string, array: true, default: []
  end
end
