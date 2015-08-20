# -*- encoding: utf-8 -*-
# stub: uservoice-ruby 0.0.11 ruby lib

Gem::Specification.new do |s|
  s.name = "uservoice-ruby"
  s.version = "0.0.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Raimo Tuisku"]
  s.date = "2012-12-05"
  s.description = "The gem provides Ruby-bindings to UserVoice API and helps generating Single-Sign-On tokens."
  s.email = ["dev@usevoice.com"]
  s.homepage = "http://developer.uservoice.com/docs/api/ruby-sdk/"
  s.rubyforge_project = "uservoice-ruby"
  s.rubygems_version = "2.4.8"
  s.summary = "Client library for UserVoice API"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.0.5"])
      s.add_runtime_dependency(%q<ezcrypto>, [">= 0.7.2"])
      s.add_runtime_dependency(%q<json>, [">= 1.7.5"])
      s.add_runtime_dependency(%q<oauth>, [">= 0.4.7"])
    else
      s.add_dependency(%q<rspec>, [">= 1.0.5"])
      s.add_dependency(%q<ezcrypto>, [">= 0.7.2"])
      s.add_dependency(%q<json>, [">= 1.7.5"])
      s.add_dependency(%q<oauth>, [">= 0.4.7"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.0.5"])
    s.add_dependency(%q<ezcrypto>, [">= 0.7.2"])
    s.add_dependency(%q<json>, [">= 1.7.5"])
    s.add_dependency(%q<oauth>, [">= 0.4.7"])
  end
end
