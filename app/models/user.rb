class User < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings

  attr_accessible :name

  def fetch_user_item
    Qiita.user
  end

end
