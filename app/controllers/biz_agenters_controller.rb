class BizAgentersController < InheritedResources::Base
  before_filter :authenticate_admin_user!, :except => [:show, :index]
end
