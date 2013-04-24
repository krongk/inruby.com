class ProjectItemSweeper < ActionController::Caching::Sweeper
  observe ProductCate
  
  def sweep(project_item)
    expire_page project_items_path
    expire_page project_item_path(project_item)
    #expire_page "/"
    #FileUtils.rm_rf "#{project_item_cache_directory}/project_items/project_item"
  end
  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end