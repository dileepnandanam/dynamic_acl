class DynamicAclsController < ActionController::Base
  skip_before_action :verify_authenticity_token
  def show
    @object = params[:id].camelize.constantize
    @acls = Acl.where(object_type: @object.name).all
    @rules = rules
    render inline: ERB.new(File.open("/#{__FILE__.split('controllers').first}views/index.erb").read).result(binding), type: 'text/html'
  end

  def set
    @acl = Acl.where(params.require(:acl).permit(:object_type, :user_type, :state, :action, :user_id)).first
    if @acl.present?
      Acl.destroy(@acl.id)
    else
      @acl = Acl.create(params.require(:acl).permit(:object_type, :user_type, :state, :action, :user_id))
    end

    @object = params[:acl][:object_type].camelize.constantize
    @acls = Acl.where(object_type: @object.name).all
    
    render inline: rules
  end

  protected

  def rules
    @rules = @acls.sort_by(&:user_type).map{|acl| "#{acl.user_type} can #{acl.action} #{acl.state} #{acl.object_type}"}.join('</br>')
    @rules = @rules.blank? ? 'Good, nobody is permitted to do anything' : @rules
  end
end