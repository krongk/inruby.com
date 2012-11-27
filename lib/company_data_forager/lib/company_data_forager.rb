# encoding: utf-8
$:.unshift(File.dirname(__FILE__))

require "company_data_forager/version"
require File.join(Rails.root, 'lib', 'base_extension', 'lib', 'base_extension')
require 'company_data_forager/record'

require 'mechanize'
require 'hpricot'
require 'open-uri'
require 'iconv'
require 'cgi'

module CompanyDataForager
  # Your code goes here...
  class ForagePageNetCn
    def run
      forage_page_net_cn
    end

    def forage_page_net_cn
      puts "forage page.net.nc"
    end
  end
end
