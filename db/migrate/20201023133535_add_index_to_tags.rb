class AddIndexToTags < ActiveRecord::Migration[5.2]
  def change
    add_index :tags, [:tag], unique: true
  end
end
