# -*- encoding: utf-8 -*-
 
Gem::Specification.new do |s|
  s.name = %q{truffle-hog}
  s.version = "0.0.1"
 
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paul Dix"]
  s.date = %q{2009-09-21}
  s.email = %q{paul@pauldix.net}
  s.files = [
    "lib/truffle-hog.rb",
    "README.textile",
    "spec/spec.opts", 
    "spec/spec_helper.rb",
    "spec/truffle-hog_spec.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/pauldix/truffle-hog}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Finds RSS and Atom feed urls in html like a hog finds truffles. Tasty, delicious feeds... er, truffles.}
 
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2
 
    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end