class BaiduKeyWord < ActiveRecord::Base
  self.table_name = 'key_words'
end

db_config = YAML::load_file(File.join(Rails.root, 'config', 'database.yml'))
BaiduKeyWord.establish_connection db_config['baidu']
 
