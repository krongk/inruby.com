#encoding: utf-8

class ContactMailer < ActionMailer::Base
  default from: "from@example.com"

  def notice_contact_email(contact)
    @contact = contact
    mail(:from => 'master@ainibaba.com', :to => ['77632132@qq.com'], :subject => %{#{Time.now().strftime("%Y-%m-%d")}: #{contact.name}})
    mail(:from => 'master@ainibaba.com', :to => ['2576455908@qq.com'], :subject => %{#{Time.now().strftime("%Y-%m-%d")}: #{contact.name}})
  end

  def send_resume_ad(email_arr)
  	 mail(:from => 'master@ainibaba.com', 
  	   :to => email_arr, 
  	   :subject => %{给您推荐一款保险增员帮助系统，万千简历尽在手中！})
  end
end