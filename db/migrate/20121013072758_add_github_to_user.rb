class AddGithubToUser < ActiveRecord::Migration
  def change
    add_column :users, :github, :string
  end
end
