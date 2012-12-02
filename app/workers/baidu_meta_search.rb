#when user search in front page, store the result page
class BaiduMetaSearch
  include Sidekiq::Worker

  def perform(q, body)
    r = SearchItem.find_or_create_by_title(q)
    r.body = body
    r.save!
  end
end