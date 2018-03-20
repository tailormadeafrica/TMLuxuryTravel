# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-back_links'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Back Links extension for Refinery CMS'
  s.date              = '2017-07-28'
  s.summary           = 'Back Links extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]
  s.authors           = ['Perfect Circle']

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.0.3'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 2.0.3'
end
