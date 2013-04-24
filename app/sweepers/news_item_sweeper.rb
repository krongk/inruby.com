class NewsItemSweeper < ActionController::Caching::Sweeper
  observe NewsItem
  
  def sweep(news_item)
    expire_page news_items_path
    expire_page news_item_path(news_item)
    expire_page "/"
    #FileUtils.rm_rf "#{news_item_cache_directory}/news_items/news_item"
  end
  
  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end