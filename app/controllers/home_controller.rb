#encoding: utf-8
class HomeController < ApplicationController
  def index
  	#redirect_to :action => :site_map
  end

  #It's a location tip, you can set lawyer => nil, and modify 'views/home/location.html.erb' to 'view/home/_location.html.erb'
  def location
  	#@ip = request.remote_id
  	@ip = '118.113.226.34'
  	@location = Rails.cache.read(@ip)
  end

  def site_map
  end

  #成功案例（news_cate_id = 5, and has image_path)
  def case
    @news_cate = NewsCate.find_by_name("成功案例")
    @news_items = @news_cate.news_items.paginate(:page => params[:page] || 1, :per_page => 8)
  end
end