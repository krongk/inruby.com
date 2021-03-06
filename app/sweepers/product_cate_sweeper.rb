class ProductCateSweeper < ActionController::Caching::Sweeper
  observe ProductCate
  
  def sweep(product_cate)
    
    expire_page product_cates_path
    expire_page product_cate_path(product_cate)
    expire_page "/"
    FileUtils.rm_rf "#{product_cate_cache_directory}/product_cates/product_cate"
  end
  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end