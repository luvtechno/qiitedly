class AddAttributesToUser < ActiveRecord::Migration
  def change
    change_column :users, :name, :string, null: true
    add_column :users, :url_name, :string
    add_column :users, :profile_image_url, :string
    add_column :users, :url, :string
    add_column :users, :description, :string
    add_column :users, :website_url, :string
    add_column :users, :organization, :string
    add_column :users, :location, :string
    add_column :users, :facebook, :string
    add_column :users, :linkedin, :string
    add_column :users, :twitter, :string
    add_column :users, :followers, :integer, default: 0
    add_column :users, :following_users, :integer, default: 0
    add_column :users, :items, :integer, default: 0
  end
end

