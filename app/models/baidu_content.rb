class BaiduContent < ActiveRecord::Base
  self.table_name = 'search_records'
end

db_config = YAML::load_file(File.join(Rails.root, 'config', 'database.yml'))
BaiduContent.establish_connection db_config['baidu']
 
