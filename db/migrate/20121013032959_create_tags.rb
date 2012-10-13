class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.string :url_name, null: false
      t.string :icon_url, null: false
      t.integer :item_count, nill: false, default: 0
      t.integer :follower_count, nill: false, default: 0
    end
  end
end
