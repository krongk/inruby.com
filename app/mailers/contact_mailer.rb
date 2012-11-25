class ContactMailer < ActionMailer::Base
  default from: "from@example.com"

  def notice_contact_email(contact)
    @contact = contact
    mail(:from => 'master@ainibaba.com', :to => ['77632132@qq.com'], :subject => %{#{Time.now().strftime("%Y-%m-%d")}: #{contact.name}})
    mail(:from => 'master@ainibaba.com', :to => ['2576455908@qq.com'], :subject => %{#{Time.now().strftime("%Y-%m-%d")}: #{contact.name}})
  end
end