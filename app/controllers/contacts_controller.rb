#encoding: utf-8
class ContactsController < InheritedResources::Base
  before_filter :authenticate_admin_user!, :except => [:show, :new, :create]

  # def create
  #   if params[:contact][:name].blank?
  #     return
  #   end
  #   flash[:notice] = "信息提交成功！ 请等待我们的联系."
  #   super
  # end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.phone !~ /^1[3,5,8,9]\d{9}$/ || @contact.message !~ /[\u4e00-\u9fa5]+/ #must contains chinese
      flash[:notice] = "信息提交失败, 请重新填写！是否手机号码有误？或者内容没有填写"
      redirect_to new_contact_path
      return
    end
    respond_to do |format|
      if @contact.save
        #mail notification
        ContactMailer.notice_contact_email(@contact).deliver

        format.html { redirect_to @contact, notice: '信息提交成功，请等待我们的回复！' }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

end
