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
        link = item.link
        next if link.include?('.html') || link.include?('.xml')

        search_result = search_results.where(link: link).first_or_initialize
        search_result.title = item.title
        search_result.html_title = item.htmlTitle
        search_result.link = link
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

  def self.find_by_name_or_id(arg)
    Tag.find_by_url_name(arg) || Tag.find(arg)
  end

  def search_results_filtered
    results = search_results.order("RANDOM()").reject do |result|
      result.link.include?('.html') || result.link.include?('.xml')
    end
    results = SearchResult.all.sample(4) if results.empty?
    results.sort { |a, b| a.url <=> b.url }.uniq { |result| result.url }.shuffle
  end
end
