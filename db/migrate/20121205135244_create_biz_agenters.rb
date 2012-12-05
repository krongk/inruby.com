class CreateBizAgenters < ActiveRecord::Migration
  def change
    create_table :biz_agenters do |t|
      t.string :is_mailed, :default => 'n'
      t.string :is_called, :default => 'n'
      t.string :is_sms_sent, :default => 'n'
      t.string :cate
      t.string :bar_number
      t.string :name
      t.string :qq
      t.string :email
      t.string :mobile_phone
      t.string :tel_phone
      t.string :other_contact
      t.string :company
      t.text :description
      t.text :note

      t.timestamps
    end
    add_index :biz_agenters, :bar_number
    add_index :biz_agenters, :cate
    add_index :biz_agenters, :mobile_phone
    add_index :biz_agenters, :email
  end
end
