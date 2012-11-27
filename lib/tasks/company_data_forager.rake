# encoding: utf-8
# This rake file is to initialize app and prepare data for user.
# steps:
#   1. rake rails_on_web:init_all_data
#   2. rake rails_on_web:generate_all_page

# encoding: utf-8
$:.unshift(File.dirname(__FILE__))
require File.join(Rails.root, 'lib', 'company_data_forager', 'lib', 'company_data_forager')

namespace :company_data_forager do

  desc "load yaml(private method: loading site_map.yml)"
  task :load_yaml => :environment do
    puts 'loading yaml'
    CompanyDataForager::ForagePageNetCn.new.run
  end

end
