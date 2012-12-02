class CreateSearchItems < ActiveRecord::Migration
  def change
    create_table :search_items do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
