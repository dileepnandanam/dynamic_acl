require 'dynamic_acl/engine'

ActiveRecord::Base.class_eval do
  def can?(action, object)
    DynamicAcl.can?(self, action, object)
  end
end

class Acl < ActiveRecord::Base

end