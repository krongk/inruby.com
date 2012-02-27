class ContactsController < InheritedResources::Base
  before_filter :authenticate_admin_user!, :except => [:index, :show, :new, :create]
end
