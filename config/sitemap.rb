# encoding: utf-8
# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.inruby.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
  add '/search', :priority => 0.7, :changefreq => 'daily'
  add '/contact', :priority => 0.7

  Page.find_each do |item|
    add page_path(item), :lastmod => item.updated_at, :priority => 0.9
  end
  NewsCate.find_each do |item|
    add news_cate_path(item), :priority => 0.8
  end
  index = 0
  NewsItem.find_each do |item|
    if index < 50
      add news_item_path(item), :lastmod => item.updated_at, :priority => 0.8
    else
      add news_item_path(item), :lastmod => item.updated_at, :priority => 0.4
    end
    index += 1
    break if index > 500000
  end
  ProductCate.find_each do |item|
    add product_cate_path(item), :priority => 0.9
  end
  ProductItem.find_each do |item|
    add product_item_path(item), :priority => 0.9
  end
  ProjectCate.find_each do |item|
    add project_cate_path(item)
  end
  ProjectItem.find_each do |item|
    add project_item_path(item)
  end
end


#How to use sitemap
# 1. Add the gem to your Gemfile:

#   gem 'sitemap_generator'

# 2. Run: rake sitemap:install
#    will create a config/sitemap.rb file which is your sitemap configuration and contains everything needed to build your sitemap. 

# 3. Run: rake sitemap:refresh 
#     will create or rebuild your sitemap files as needed. Sitemaps are generated into the public/ folder and by default are named sitemap_index.xml.gz, sitemap1.xml.gz, sitemap2.xml.gz, etc. As you can see they are automatically gzip compressed for you.
#     rake sitemap:refresh will output information about each sitemap that is written including its location, how many links it contains and the size of the file.
# 4. 怎样添加百度sitemap
#     baidu Sitemap 内容和形式可以和 Google Sitemap 完全一样。但因为百度还没开通类似 Google 网站管理员工具的提交后台，所以，我们需要采用以下方式提交"baidu Sitemap" 。
#     我们可以通过在 robots.txt 文件中添加以下代码行来告诉搜索引擎 Sitemap 的存放位置。包括 XML Sitemap 和 文本形式的 Sitemap。

#     Sitemap:<sitemap_location>

#     <sitemap_location> 填写 Sitemap 的完整网址
#     如：http://www.example.com/sitemap.xml. http://www.example.com/sitemap.txt