#encoding: utf-8
ActiveAdmin.register ProductCate do
  menu :label => '产品中心', :priority  => 4
  menu :label => "产品分类", :parent => "产品中心"

  sidebar :"帮助中心" do
  	ul do
  	  li "本页保存产品的分类信息！"
  	end
  end
end