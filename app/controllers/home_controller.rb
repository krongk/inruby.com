#encoding: utf-8
class HomeController < ApplicationController
  include ApplicationHelper
  cache_page :index, :sitemap
  def index
  	#redirect_to :action => :site_map

    #Baidu killed mysite cause I do this
    # unless request.host_with_port == "localhost:3000"
    #   BaiduTopWorker.perform_async
    # end
  end

  #It's a location tip, you can set lawyer => nil, and modify 'views/home/location.html.erb' to 'view/home/_location.html.erb'
  def location
  	#@ip = request.remote_id
  	@ip = '118.113.226.34'
  	@location = Rails.cache.read(@ip)
  end

  #syixia engine
  def search
    #because of 十八大
    render :text => 'yes baby!'
    return


    if params[:q].blank?
      flash[:notice] = "请输入搜索关键词！"
      render 'form'
      return
    end
    # @ic = Iconv.new('UTF-8//IGNORE', 'gb2312//IGNORE')
    # @ic2 = Iconv.new('gb2312//IGNORE', 'UTF-8//IGNORE')
    # @coder = HTMLEntities.new

    #get key word
    q = params[:q]
    #q = q.squeeze(' ').strip unless q.blank?

    #get search source <web, wenda>
    t = params[:t] || 'web'
    t = ['web', 'wenda'].include?(t) ? t : 'web'

    #get page number
    @page = params[:page].to_i || 1
    @page = (1..100).include?(@page) ? @page : 1

    #options = {:source => t.to_sym, :key_word => CGI.escape(@ic2.iconv(q)), :page => @page}
    options = {:source => t.to_sym, :key_word => q, :page => @page}
    # result = {:record_arr => [], :ext_key_arr => [], :source => 'web'}
    @result = BaiduWeb.search(options[:key_word], :per_page => 20, :page_index => options[:page])
    
    #store in database -- Baidu killed my site cause I do some dup records.
    # unless request.host_with_port == "localhost:3000"
    #   BaiduMetaSearch.perform_async(q, get_search_result_body_html(@result[:record_arr])) if @result[:record_arr].any?
    # end
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
