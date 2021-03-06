class NewsItemsController < InheritedResources::Base
  before_filter :authenticate_admin_user!, :except => [:index, :show]
  before_filter :load_news_cate

  caches_page :show
  caches_page :index, :cache_path => Proc.new { |c| c.params }
  cache_sweeper :news_item_sweeper

  def index
  	@news_items = params[:news_cate_id] ? 
  	  NewsItem.where(:news_cate_id => params[:news_cate_id]).order("updated_at DESC").paginate(:per_page => 5, :page => params[:page] || 1) : 
  	  NewsItem.order("updated_at DESC").paginate(:per_page => 5, :page => params[:page] || 1)
  end

  private
  def load_news_cate
  	@news_cates = NewsCate.all
  end
end
