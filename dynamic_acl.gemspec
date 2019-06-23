Gem::Specification.new do |s|
  s.name = "dynamic_acl"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Dileep Nandanam"]
  s.date = "2014-11-20"
  s.description = "gem to wright join queries on associations"
  s.email = "dileepsnandanam@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "VERSION",
    "lib/dynamic_acl/engine.rb",
    "lib/dynamic_acl/engine.rb",
    "app/controllers/dynamic_acls_controller.rb",
    "lib/tasks/create_acl.rake",
    "lib/dynamic_acl.rb",
    "dynamic_acl.gemspec"
  ]
  s.homepage = "http://github.com/dileepnandanam/dynamic_acl"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Use dynamic_acl with rails active_record"
end

