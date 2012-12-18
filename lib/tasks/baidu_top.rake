#encoding: utf-8

# This rake is to crawl top key words from: http://i.top.baidu.com/buzz?b=1
# and forage the key words baidu searching result and store in badu database.

require 'open-uri'
require 'baidu_web'
namespace :baidu_top do

  desc "crawl baidu.com top key words and store on baidu.key_words, forage key words result"
  task :forager => :environment do
    puts 'crawl key words'
    forage_top_key_words
    puts 'search result'
    forage_search_result
    puts 'done'
  end

  def forage_top_key_words
    url = "http://i.top.baidu.com/buzz?b=1"
    html = open(url).read
    html.force_encoding("gbk")
    html.encode!("utf-8")
    doc = Hpricot(html)
    table = doc.at("//table.list-table")
    raise "conflict table list" if table.nil?

    table.search("//a.list-title").each do |item|
      title = item.inner_text
      k = BaiduKeyWord.find_or_create_by_name(title)
      if k.en_name.blank?
        k.en_name = Pinyin.t(title)
        k.save!
      end
    end
  end

  def forage_search_result
    BaiduKeyWord.where(:is_processed => 'n').each_with_index do |key, index|
      if BaiduContent.where(:key_word_id => key.id).any?
        key.is_processed = 'd'
        key.processed_at = Time.now
        key.save!
        next
      end

      flag = 'y'
      #options = {:source => t.to_sym, :key_word => CGI.escape(@ic2.iconv(q)), :page => @page}
      # result = {:record_arr => [], :ext_key_arr => [], :source => 'web'}
      result = BaiduWeb.search(key.name, :per_page => 40, :page_index => 1)

      list_arr = []
      result[:record_arr].each_with_index do |r, index|
        next if r.nil?
        str = ""
        str += %{<div class="search_item" id="search_item_#{index}">}
        str += %{<h3 class="item_title" ><a href="#{r.url}" target="_blank">#{encode(r.title)}</a></h3>}
        #str += %{#{link_to r.url[0..30], r.url} <br/>}
        str += encode(r.summary)
        str += "</div>"
        list_arr << str
      end
      content = list_arr.sort_by{|a| a.length}.reverse.join

      #save to search result
      bc = BaiduContent.new
      bc.key_word_id = key.id
      bc.content = content
      bc.save!

      #save to News_items
      more_titles = [result[:record_arr][0], result[:record_arr][1], result[:record_arr][2]].compact.map{|r| r.title}.join(", ")
      
      news_cate = NewsCate.find_by_name("百度热点关注")
      raise "News cate not has 百度热点关注" if news_cate.nil?
      news_item = NewsItem.new
      news_item.news_cate_id = news_cate.id
      news_item.title = key.name
      news_item.body = content
      news_item.summary = [list_arr[0], list_arr[1]].join
      news_item.tags = "#{key.name} 热点关注 Inruby"
      news_item.meta_keywords = "#{key.name}, #{more_titles}, 热点新闻, 成都红宝石信息技术, 网站建设, 网络推广，网络营销, 网络公关"
      news_item.meta_description = "#{key.name}, #{more_titles}, Ruby on Rails, 红宝石网站开发，红宝石企业建站, 红宝石科技"
      news_item.save!

      key.is_processed = flag
      key.processed_at = Time.now
      key.save!
      break if index > 500
    end
  end

  def encode(html)
    html
    # html.force_encoding("gbk")
    # html.encode!("utf-8")
  end
end
