class AddTagToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :tag, :string
  end
end
