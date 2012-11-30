class BaiduTopWorker
  include Sidekiq::Worker

  def perform
  	bt = BackgroundJob.find_or_create_by_name('baidu_top')
  	#fetch baidu top onice a day
  	if (Time.now - bt.updated_at > 86400)
  	  system "rake baidu_top:forager"
  	  bt.frequance_count += 1
  	  bt.save!
  	end
  end
end