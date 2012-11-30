class CreateBackgroundJobs < ActiveRecord::Migration
  def up
  	create_table :background_jobs  do |t|
      t.string :name
      t.integer :frequance_count
      t.string :description
      t.timestamps
    end
    add_index :background_jobs, :name, :unique => true
  end

  def down
  	drop_table :background_jobs
  end
end
