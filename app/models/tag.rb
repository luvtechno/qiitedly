class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :users, through: :taggings
  has_many :search_results, dependent: :destroy

  def url
    "http://qiita.com/tags/#{url_name}"
  end

  def fetch_search_results
    gcs = GoogleCustomSearch.new
    response = gcs.request(name)
    items = response.items
    if items
      items.each do |item|
        search_result = search_results.where(link: item.link).first_or_initialize
        search_result.title = item.title
        search_result.html_title = item.htmlTitle
        search_result.link = item.link
        search_result.display_link = item.displayLink
        search_result.snippet = item.snippet
        search_result.html_snippet = item.htmlSnippet
        search_result.cse_thumbnail = item.pagemap.metatags.first["og:image"]
        search_result.save!
      end
    end
    search_results.each do |search_result|
      search_result.destroy if search_result.updated_at < 1.week.ago
    end
    items
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
