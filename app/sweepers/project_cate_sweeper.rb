class ProjectCateSweeper < ActionController::Caching::Sweeper
  observe ProductCate
  
  def sweep(project_cate)
    expire_page project_cates_path
    expire_page project_cate_path(project_cate)
    #FileUtils.rm_rf "#{project_cate_cache_directory}/project_cates/project_cate"
  end
  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end