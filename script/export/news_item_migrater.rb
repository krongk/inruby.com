#encoding: utf-8
# == Usage
# > ruby migrate_data.rb 
# this script use to migrate local data to common.
# steps:
# 1. check local db
#		 format contenet to huxun/wenba_post_format
# => 	 add column is_exported to xx_post_format
# 2. run migrater.rb 

$:.unshift(File.dirname(__FILE__))
require "rubygems"
require "local_tables"
require "common_tables"
require "pp"
require 'chinese_pinyin'

class Migrator
	def initialize
	end
  
	def migrate(mod, l_post)
	  begin
	  	if ForagerCommon::NewsItem.find_by_external_path(l_post.url)
	  		mod.update(l_post.id, :is_exported => 'd-url')
	  		print 'dup '
	  		return
	  	end
	  	if ForagerCommon::NewsItem.find_by_title(l_post.title)
	  		mod.update(l_post.id, :is_exported => 'd-title')
	  		print 'dup '
	  		return
	  	end
	  	
	  	if l_post.description.nil?
	  	  mod.update(l_post.id, :is_exported => 'blank')
	  		print 'blank '
	  		return
	    end

		c_category              = ForagerCommon::NewsCate.find_or_create_by_name(l_post.cate)
		if c_category.en_name.nil?
		  c_category.en_name = Pinyin.t(c_category.name)
		  c_category.save!
		end

		c_post                  = ForagerCommon::NewsItem.new
		c_post.news_cate_id     = c_category.id
		c_post.title            = l_post.title
		c_post.external_path    = l_post.url
		c_post.en_title         = Pinyin.t(l_post.title)
		# img_path = '/assets/news1/' + (l_post.img_path =~ /[0-9]jpeg$/ ? l_post.img_path.gsub(/jpeg$/, '.jpeg') : l_post.img_path)
		# c_post.image_path       = img_path
		# c_post.image_url  			= l_post.img_url
		# c_post.tags             = l_post.tags
		# c_post.summary          = l_post.summary
		# c_post.meta_keywords    = "#{l_post.title} -- www.inruby.com(#{l_post.tags}, 成都，ruby, ruby on rails, 网站建设，软件开发，数据采集)"
		# c_post.meta_description = "#{l_post.title} -- www.inruby.com(#{l_post.tags}, Ruby on Rails 网站建设，Web应用开发， 数据采集)成都都红宝石企业网站建设为企业提供网站策划、开发、推广、运维一站式服务！"
		
		#site_image              = %{<div class="news_img"><span class="site_img"><img title="#{l_post.site_name}--inruby.com" src="/assets/news1/#{img_path}"/></span><span class="site_name">#{l_post.site_name}</span></div>}
		#c_post.body             = l_post.content.sub(/(:|：|。)\n/, "。\n#{site_image}\n")
		c_post.body             = l_post.description.sub(/\n([一二三四五六七八九十]、.*)\n/, '<li>\1</li>')
		c_post.body             = c_post.body.sub(/\naa(.*)\n/, '<h3>\1</h3>')
		c_post.body             = c_post.body.sub(/\n(.*：)\n\n/, '<h3>\1</h3>')
		#c_post.body  = l_post.respond_to?(:content) ? l_post.content : %{<div class='best_answer'><span class='d_t'>回答：</span>#{l_post.best_answer.to_s.gsub(/\n{2,}/, '<br>').gsub(/\n/, '<br>')}</div>\n#{l_post.formated_all_answer.to_s.gsub(/<div id='answer(\d+)' class='answer_d'>/, '<div id="answer\1" class="answer_d"><span class="d_t">\1</span>')}}
		#c_post.summary = l_post.respond_to?(:question) ? l_post.question.to_s.gsub(/\n{2,}/, '<br>').gsub(/\n/, '<br>') : nil
		c_post.save!

		mod.update(l_post.id, :is_exported => 'y')
		print l_post.id
		print ' '
	   rescue => ex
		   puts ex.message
       mod.update(l_post.id, :is_exported => 'f')
       raise ex
	   end
	end

	def run
		puts 'start post...'
		count = 0
		['Post'].each do |klass|
			mod = eval "ForagerLocal::#{klass}"
			loop  do
				result = mod.where(:is_exported => 'n').limit(500)
				
				break if result.size == 0
			  result.each do |l_post|
				  migrate(mod, l_post)
			  end
		  end
		end
		puts 'done...'
	end
end

if __FILE__ == $0
  Migrator.new.run
end