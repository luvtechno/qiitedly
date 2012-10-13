class SearchResult < ActiveRecord::Base
  belongs_to :tag

  def url
    utm = { utm_campaign: :qiitedly }
    "#{link}?#{utm.to_param}"
  end
end
