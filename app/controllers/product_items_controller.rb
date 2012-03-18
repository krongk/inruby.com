class ProductItemsController < InheritedResources::Base
  before_filter :authenticate_admin_user!, :except => [:index, :show]
  before_filter :load_project_cate
  include ApplicationHelper

  def index
  	@project_items = params[:tag] ?
    ProjectItem.where("tags regexp '#{params[:tag].strip}'").paginate(:page => params[:page] || 1) :
    ProjectItem.paginate(:page => params[:page] || 1)
  end

  private
  def load_project_cate
    @project_cates = ProjectCate.all
  end
end
