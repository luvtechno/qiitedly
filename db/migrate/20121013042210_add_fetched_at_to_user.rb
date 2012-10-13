class AddFetchedAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :fetched_at, :datetime
  end
end
