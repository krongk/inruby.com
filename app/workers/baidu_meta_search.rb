#when user search in front page, store the result page
class BaiduMetaSearch
  include Sidekiq::Worker

  def perform(q, result)
    r = SearchItem.find_or_create_by_title(q)
    r.body = get_search_result_body_html(result[:record_arr])
    r.save!
  end
end