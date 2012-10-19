class ChangeNewsItems < ActiveRecord::Migration
  def self.up
    #add_column :news_items, :summary, :text
    #add_column :news_items, :tags, :string
    #add_column :news_items, :meta_keywords, :string
    #add_column :news_items, :meta_description, :string
    add_column :news_items, :en_title, :string
  end

  def self.down
    remove_column :news_items, :summary
    remove_column :news_items, :tags
    remove_column :news_items, :meta_keywords
    remove_column :news_items, :meta_description
    remove_column :news_items, :en_title
  end
end
