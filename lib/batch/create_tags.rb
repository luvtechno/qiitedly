Qiita.tags(per_page: 100).each do |raw_tag|
  tag = Tag.where(name: raw_tag.name).first_or_initialize
  tag.url_name = raw_tag.url_name
  tag.icon_url = raw_tag.icon_url
  tag.item_count = raw_tag.item_count
  tag.follower_count = raw_tag.follower_count
  tag.save!
  puts "Saved #{tag.name}"
end
