$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bb_cookie_cutter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bb_cookie_cutter"
  s.version     = BbCookieCutter::VERSION
  s.authors     = ["Tejas Ravindra Mandke"]
  s.email       = ["tejas.mandke@gmail.com"]
  s.homepage    = "https://github.com/tmandke/bb_cookie_cutter"
  s.summary     = "Automates Backbone ICRUD and more"
  s.description = "Automates Backbone ICRUD and more"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.3"

  s.add_development_dependency "sqlite3"
end
