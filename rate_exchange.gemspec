$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rate_exchange/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rate_exchange"
  s.version     = RateExchange::VERSION
  s.authors     = ["Cesar Palafox"]
  s.email       = ["cpaguila1@gmail.com"]
  s.homepage    = "https://github.com/cpalafox"
  s.summary     = "Summary of RateExchange."
  s.description = "Description of RateExchange."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
end
