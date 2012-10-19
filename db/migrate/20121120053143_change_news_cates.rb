class ChangeNewsCates < ActiveRecord::Migration
  def self.up
    #add_column :news_items, :summary, :text
    add_column :news_cates, :en_name, :string
  end

  def self.down
    remove_column :news_cates, :en_name
  end
end
