class DynamicAclsController < ActionController::Base
  def index
    @object = params[:type].camelize.constantize
    @acls = Acl.where(object_type: params[:type]).all
    render inline: ERB.new(File.open("/#{__FILE__.split('controllers').first}views/index.erb").read).result(binding), type: 'text/html'
  end

  def set
    if @acl.present?
      @acl = Acl.where(user_type: params[:user_type], user_id: params[:user_id], action: params[:action], object_type: params[:object_type], status: params[:status]).first_or_create
    else
      @acl.delete
    end
  end
end