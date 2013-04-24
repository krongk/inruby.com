class ProductItemSweeper < ActionController::Caching::Sweeper
  observe ProductItem
  
  def sweep(product_item)
    expire_page product_items_path
    expire_page product_item_path(product_item)
    expire_page "/"
    #FileUtils.rm_rf "#{product_item_cache_directory}/product_items/product_item"
  end
  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end