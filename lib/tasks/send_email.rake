#encoding: utf-8

# This rake is to send email by ad
namespace :send_email do
  desc "send email to insurance, ten emails onice a time"
  task :biz_agenter => :environment do
  	flag = true
  	mail_arr = []
    BizAgenter.where(:is_mailed => 'n').find_each do |item|
      begin
      	if flag
      		mail_arr << 'master@inruby.com'
      		flag = false
      	end
      	item.email = item.email.to_s.strip
      	if item.email !~ /^[\_a-z\d]+(\.[\_a-z\d]+)*@([\da-z](-[\da-z])?)+(\.[a-z]+)+$/i
      	  item.is_mailed = 'bad email'
	        item.save!
	        next
      	end
		mail_arr << item.email
		if mail_arr.size > 10
		  ContactMailer.send_resume_ad(mail_arr).deliver
		  puts "seend to: #{mail_arr.join(',')}"
		mail_arr = []
		end
		item.is_mailed = 'y'
		item.save!
	  rescue => ex
	  	puts ex.message
	  	item.is_mailed = ex.message
	    item.save!
	    raise ex.message
	  end
    end
    puts "done!"
  end
end