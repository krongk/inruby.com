class BaiduTopWorker
  include Sidekiq::Worker

  def perform
  	puts 'backgroud job start'
  	Site.creat(:name => "a#{rand}", :value => Time.now)
  	system "rake baidu_top:forager"
  	puts 'bj end'
  end
end