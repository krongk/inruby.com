class NewsCateSweeper < ActionController::Caching::Sweeper
  observe NewsCate
  
  def sweep(news_cate)
    expire_page news_cates_path
    expire_page news_cate_path(news_cate)
    expire_page "/"
    FileUtils.rm_rf "#{page_cache_directory}/news_cates/page"
  end
  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end