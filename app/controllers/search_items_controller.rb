class SearchItemsController < InheritedResources::Base
  before_filter :authenticate_admin_user!, :except => [:index, :show]
  
  def index
  	@search_items = SearchItem.order("updated_at DESC").paginate(:per_page => 8, :page => params[:page] || 1)
  end
end
