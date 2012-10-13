class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :users, through: :taggings
  has_many :search_results

  def url
    "http://qiita.com/tags/#{url_name}"
  end

  def fetch_search_results
    gcs = GoogleCustomSearch.new
    response = gcs.request(name)
    response.items.each do |item|
      search_result = search_results.build
      search_result.title = item.title
      search_result.html_title = item.htmlTitle
      search_result.link = item.link
      search_result.display_link = item.displayLink
      search_result.snippet = item.snippet
      search_result.html_snippet = item.htmlSnippet
      search_result.cse_thumbnail = item.pagemap.cse_thumbnail.first.src
      search_result.save!
    end
  end
end


      # t.references :tag
      # t.string :title
      # t.string :html_title
      # t.string :link
      # t.string :display_link
      # t.text :snippet
      # t.text :html_snippet
      # t.string :cse_thumbnail
