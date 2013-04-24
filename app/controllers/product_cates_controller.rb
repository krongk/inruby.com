class ProductCatesController < InheritedResources::Base
  before_filter :authenticate_admin_user!, :except => [:index, :show]
  
  caches_page :show
  caches_action :index, :cache_path => Proc.new { |c| c.params }
  cache_sweeper :product_cate_sweeper
  
  def show
    @project_cate = ProjectCate.find(params[:id] || 1)
    @project_items = @project_cate.project_items.paginate(:page => params[:page] || 1)
  end
end
