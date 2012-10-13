class User < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :search_results, through: :tags

  validates :url_name, uniqueness: true

  attr_accessible :url_name

  # after_save :fetch_qiita_data

  def fetch_qiita_data
    raw_user = Qiita.user url_name
    logger.info raw_user
    raw_user.each do |key, value|
      self[key.to_sym] = value
    end
    self.fetched_at = Time.now
    save!

    new_tags = [ Tag.find_by_url_name('Qiita') ]

    # raw_items = Qiita.user_items url_name
    # logger.info raw_items
    # raw_items.each do |raw_item|
    #   raw_item.tags.each do |raw_tag|
    #     new_tags << Tag.find_by_url_name(raw_tag.url_name)
    #   end
    # end

    raw_tags = Qiita.user_following_tags url_name
    logger.info raw_tags
    raw_tags.each do |raw_tag|
      new_tags << Tag.find_by_url_name(raw_tag.url_name)
    end

    new_tags.compact!
    new_tags.uniq!

    self.tags = new_tags
  end

  def fetched?
    !!fetched_at
  end

  def valid_qiita_user?
    !!fetched_at
  end

  def url
    "http://qiita.com/users/#{url_name}"
  end

  def self.find_by_name_or_id(arg)
    User.find_by_url_name(arg) || User.find(arg)
  end

  def search_results_filtered
    search_results.order("RANDOM()").reject { |result| result.link.include?('.html') }
  end
end
