module DynamicAcl
  class Engine < ::Rails::Engine
  end
  
  def self.can?(record, action, object, user_id=nil)
    ::Acl.where(user_type: record.user_type, user_id: user_id, action: action, object_type: object.class.name, state: object.state).first.present?
  end
end