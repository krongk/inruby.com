#encoding: utf-8
load 'forager.rb'

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

  #syixia engine
  def search
    if params[:q].blank?
      flash[:notice] = "请输入搜索关键词！"
      render 'form', :layout => false
      return
    end
    @ic = Iconv.new('UTF-8//IGNORE', 'gb2312//IGNORE')
    @ic2 = Iconv.new('gb2312//IGNORE', 'UTF-8//IGNORE')
    @coder = HTMLEntities.new

    #get key word
    q = params[:q]
    q = q.squeeze(' ').strip unless q.blank?

    #get search source <web, wenda>
    t = params[:t] || 'web'
    t = ['web', 'wenda'].include?(t) ? t : 'web'

    #get page number
    @page = params[:page].to_i || 1
    @page = (1..100).include?(@page) ? @page : 1

    options = {:source => t.to_sym, :key_word => CGI.escape(@ic2.iconv(q)), :page => @page}
    # result = {:record_arr => [], :ext_key_arr => [], :source => 'web'}
    @result = Forager.get_result(options)
  end

  def sitemap
    static_urls = [ 
      {:type => 'static', :title => '联系我们', :url => '/contact',      :updated_at => Time.now},
      {:type => 'static', :title     => '关于我们', :url       => '/about',       :updated_at => Time.now},
      {:type => 'static', :title     => '搜索', :url       => '/search',      :updated_at => Time.now} ] 
    @pages_to_visit = static_urls
    @pages_to_visit += Page.all.collect{|a| {:type => 'page', :title => a.title, :url => page_path(a) ,  :updated_at => I18n.l(a.updated_at || Time.now, :format => :w3c)} }
    @pages_to_visit += NewsCate.all.collect{|a| {:type => 'news_cate', :title => a.name, :url => news_cate_path(a) ,  :updated_at => I18n.l(Time.now, :format => :w3c)} }
    @pages_to_visit += NewsItem.limit(20).collect{|a| {:type => 'news_item', :title => a.title, :url => news_item_path(a) ,  :updated_at => I18n.l(a.updated_at || Time.now, :format => :w3c)} }
    @pages_to_visit += ProductCate.all.collect{|a| {:type => 'product_cate', :title => a.name, :url => product_cate_path(a) ,  :updated_at => I18n.l(Time.now, :format => :w3c)} }
    @pages_to_visit += ProductItem.limit(20).collect{|a| {:type => 'product_item', :title => a.title, :url => product_item_path(a) ,  :updated_at => I18n.l(a.updated_at || Time.now, :format => :w3c)} }
    @pages_to_visit += ProjectCate.all.collect{|a| {:type => 'project_cate', :title => a.name, :url => project_cate_path(a) ,  :updated_at => I18n.l(Time.now, :format => :w3c)} }
    @pages_to_visit += ProjectItem.limit(20).collect{|a| {:type => 'project_item', :title => a.title, :url => project_item_path(a) ,  :updated_at => I18n.l(a.updated_at || Time.now, :format => :w3c)} }

    respond_to do |format|
      format.xml
      format.html
    end
  end
end
