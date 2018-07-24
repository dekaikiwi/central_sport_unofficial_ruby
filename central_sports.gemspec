lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)



Gem::Specification.new do |s|
  s.name        = 'central_sports'
  s.version     = '0.0.0'
  s.date        = '2010-04-28'
  s.summary     = "Central Sports API!"
  s.description = "An unofficial wrapper for the schedule API for Central Sports"
  s.authors     = ["Jonathan Glassey"]
  s.email       = 'jonofilms@gmail.com'
  s.files       = Dir['lib/**/*.rb']
  s.license     = 'MIT'
  s.add_dependency 'httparty', '~> 0.15.6'
  s.add_dependency 'oj', '~> 3.4', '>= 3.4.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency "minitest"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
end
