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
  self.tabe_name = 'company_01'
end


class TestSms

  def run
    puts Company.count
    Company.where(:is_sms_processed => 'n').find_each do |item|
      #13980669356
      flag = 'y'
      phone = item.mobile_phone.to_s.strip
      if phone =~ /^1\d{10}$/
         flag = SmsBao.send('inruby', 'kenrome001', phone, content)
      else
        flag = 'bad_phone'
      end
      item.is_sms_processed = flag
      item.sms_processed_at = Time.now
      item.sms_content = content
      item.save!
    end
  end
end


TestSms.new.run if __FILE__ == $0