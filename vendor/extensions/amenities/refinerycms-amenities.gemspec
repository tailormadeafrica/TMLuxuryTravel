# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.authors           = 'Tailor Made Africa'
  s.name              = 'refinerycms-amenities'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Amenities extension for Refinery CMS'
  s.date              = '2016-03-18'
  s.summary           = 'Amenities extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]
  s.authors           = ['Perfect Circle']

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.0.3'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 2.0.3'
end
