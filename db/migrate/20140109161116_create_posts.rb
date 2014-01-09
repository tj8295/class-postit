class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, :url
      t.text :description
      t.integer :user_id
    end
  end

  # def up
  #   create_table :posts do |t|
  #   end
  # end

  # def down
  #   drop_table :posts do |t|
  #   end
  # end
end
