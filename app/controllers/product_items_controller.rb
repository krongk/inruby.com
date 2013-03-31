class ProductItemsController < InheritedResources::Base
  before_filter :authenticate_admin_user!, :except => [:index, :show]
  before_filter :load_product_cate
  caches_page :index, :show
  def index
  	@product_items = params[:tag] ?
    ProductItem.where("tags regexp '#{params[:tag].strip}'").order("updated_at DESC").paginate(:page => params[:page] || 1, :per_page => 8) :
    ProductItem.order("updated_at DESC").paginate(:page => params[:page] || 1, :per_page => 8)
  end

  private
  def load_product_cate
    @product_cates = ProductCate.all
  end
end
