class NewsCatesController < InheritedResources::Base
  before_filter :authenticate_admin_user!, :except => [:index, :show]
  before_filter :load_news_cate
  
  def index
  	@news_items = params[:news_cate_id] ? 
  	  NewsItem.where(:news_cate_id => params[:news_cate_id]).order("updated_at DESC").paginate(:page => params[:page] || 1) : 
  	  NewsItem.order("updated_at DESC").paginate(:page => params[:page] || 1)
  end

  def show
    if params[:id] =~ /^\d+$/
	    @news_items = NewsCate.find(params[:id]).news_items.order("updated_at DESC").paginate(:page => params[:page] || 1)
    else
      @news_items = NewsItem.where("tags regexp '#{params[:id]}' OR title regexp '#{params[:id]}'").order("updated_at DESC").paginate(:page => params[:page] || 1)
    end
	  @news_cate = NewsCate.find_by_id(params[:id])
    @news_cate ||= NewsCate.first
  end

  private
  def load_news_cate
  	@news_cates = NewsCate.all
  end
end
