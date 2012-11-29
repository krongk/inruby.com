#encoding: utf-8

# This rake is to crawl top key words from: http://i.top.baidu.com/buzz?b=1
# and forage the key words baidu searching result and store in badu database.

# require 'mechanize'
# require 'hpricot'
# require 'chinese_pinyin'

namespace :baidu_top do

  desc "crawl baidu.com top key words and store on baidu.key_words, forage key words result"
  task :forager => :environment do
    puts 'crawl key words'
    
    agent = Mechanize.new
    page = agent.get("http://i.top.baidu.com/buzz?b=1")
    page.links.each do |link|
      if link.href =~ /\/detail\?b=\d+&w=/
        puts link.display
        title = link.display.to_s.force_encoding("utf-8")
        puts title
        @ic2 = Iconv.new('gb2312//IGNORE', 'UTF-8//IGNORE')
        puts @ic2.iconv(title)
        puts title.blank?

        next if title.blank?
        k = BaiduKeyWord.find_or_create_by_name(title)
        k.en_name = link.href
        k.save!
      end
    end
    # doc = Hpricot(page.body)
    # table = doc.at("//table.list-table")
    # raise "conflict table list" if table.nil?

    # table.search("//a.list-title").each do |item|
    #   @ic2 = Iconv.new('gb2312//IGNORE', 'UTF-8//IGNORE')
    #   #title = @ic2.iconv(item.innerHTML)
    #   #title = item.inner_text.force_encoding("gb2312").encode("utf-8", replace: nil)
    #   #inner_text will occur an error on windows pc.
    #   title = item.innerHTML.encode("UTF-8", replace: nil)
    #   title = title.force_encoding("UTF-8")
    #   k = BaiduKeyWord.find_or_create_by_name(title)
    #   if k.en_name.blank?
    #     k.en_name = Pinyin.t(title)
    #     k.save!
    #   end
    #   puts title
    # end
    # puts 'done'
  end

end
