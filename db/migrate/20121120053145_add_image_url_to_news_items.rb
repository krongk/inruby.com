class AddImageUrlToNewsItems < ActiveRecord::Migration
  def self.up
    #add_column :news_items, :summary, :text
    #add_column :news_items, :tags, :string
    #add_column :news_items, :meta_keywords, :string
    #add_column :news_items, :meta_description, :string
    add_column :news_items, :image_url, :string
  end

  def self.down
    remove_column :news_items, :image_url
  end
end
