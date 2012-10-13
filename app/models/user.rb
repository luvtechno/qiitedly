class User < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings

  attr_accessible :name
end
