class NewsItem < ActiveRecord::Base
  belongs_to :news_cate

  def self.recent(count, cate = 0, image = false)
    conditions = cate > 0 ? "news_cate_id = #{cate}" : "true"
    conditions += " AND image_path IS NOT NULL" if image
    NewsItem.where(conditions).order("updated_at DESC").limit(count)
  end

end
