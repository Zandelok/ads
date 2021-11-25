class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title,      null: false
      t.string :text,       null: false
      t.json :images
    end

    add_reference :posts, :user, index: true
    add_reference :posts, :category, index: true
  end
end
