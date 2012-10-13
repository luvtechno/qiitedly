class CreateSearchResults < ActiveRecord::Migration
  def change
    create_table :search_results do |t|
      t.references :tag
      t.string :title
      t.string :html_title
      t.string :link
      t.string :display_link
      t.text :snippet
      t.text :html_snippet
      t.string :cse_thumbnail
      t.timestamps
    end
  end
end
