class User < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings

  attr_accessible :url_name

  after_save :fetch_qiita_data

  def fetch_qiita_data
    raw_user = Qiita.user url_name
    logger.info raw_user
    raw_user.each do |key, value|
      self[key.to_sym] = value
    end
    self.fetched_at = Time.now
    save!
  end

  def valid_qiita_user?
    !!fetched_at
  end
end
