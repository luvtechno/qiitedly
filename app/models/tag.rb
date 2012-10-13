class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :users, through: :taggings

  def url
    "http://qiita.com/tags/#{url_name}"
  end
end
