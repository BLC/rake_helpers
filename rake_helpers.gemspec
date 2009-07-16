# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rake_helpers}
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["moneypools"]
  s.date = %q{2009-07-16}
  s.email = %q{support@mymoneypools.com}
  s.files = [
    ".gitignore",
     "History.txt",
     "Rakefile",
     "VERSION",
     "lib/rake_helpers.rb",
     "lib/rake_helpers/config.rb",
     "lib/rake_helpers/erb_helper.rb",
     "rake_helpers.gemspec",
     "script/console",
     "script/destroy",
     "script/generate",
     "spec/rake_helpers_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "tasks/rspec.rake"
  ]
  s.homepage = %q{http://github.com/moneypools/rake_helpers}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Some extensions to sprout}
  s.test_files = [
    "spec/rake_helpers_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
