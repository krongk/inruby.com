#encoding: utf-8
#remember to install: gem install sms_bao

require 'rubygems'
require 'active_record'
require 'sms_bao'

class LocalBase < ActiveRecord::Base
    self.abstract_class = true
    self.pluralize_table_names = false
    self.store_full_sti_class = false
end
LocalBase.establish_connection({
  :adapter => 'mysql2',
  :encoding => 'utf8',
  :reconnect => false,
  :pool => 5,
  :host => '127.0.0.1',
  :port => 3303,
  :username => 'root',
  :password => 'kenrome001',
  :database => 'business'
})
LocalBase.connection.execute("set names 'utf8'")

class Company < LocalBase
  self.table_name = 'insurance_phone'
end


class TestSms

  def run
    puts "total sms acount:"
    puts SmsBao.query('inruby', 'kenrome001')
    puts "total reocrds: " + Company.count.to_s
    puts "starting........"
    Company.where(:is_sms_processed => 'n').each_with_index do |item, index|
      flag = 'y'
      content = "HR您好,如果您的招聘增员效果不理想的话,可以考虑一下我们提供的海量人才库,访问：http://www.inruby.com/resume/index.html"
      phone = item.mobile_phone.to_s.strip
      #phone = '15928661802'
      if phone =~ /^1\d{10}$/
         flag = SmsBao.send('inruby', 'kenrome001', phone, content)
      else
        flag = 'bad_phone'
      end
      item.is_sms_processed = flag
      item.processed_at = Time.now
      item.sms_content = content
      item.save!
      puts "#{phone.ljust(11, ' ')}: #{flag}"
      break if index > 500
    end
    puts "remain sms acount:"
    puts SmsBao.query('inruby', 'kenrome001')
  end
end


TestSms.new.run if __FILE__ == $0