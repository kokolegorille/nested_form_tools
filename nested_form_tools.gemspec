$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nested_form_tools/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nested_form_tools"
  s.version     = NestedFormTools::VERSION
  s.authors     = ["koko"]
  s.email       = ["koko.le.gorille@gmail.com"]
  #s.homepage    = "none"
  s.summary     = "Summary of NestedFormTools."
  s.description = "Description of NestedFormTools."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  #s.add_dependency "rails", "~> 3.2.6"
  s.add_dependency "rails", ">= 3.0.0"

  s.add_development_dependency "sqlite3"
end
