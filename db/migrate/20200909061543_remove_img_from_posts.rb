class RemoveImgFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :img, :string
  end
end
