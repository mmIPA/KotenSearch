class CreatePostCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :post_categories do |t|
      t.bigint :post_id, null: false
      t.bigint :category_id, null: false

      t.timestamps
    end
  end
end
