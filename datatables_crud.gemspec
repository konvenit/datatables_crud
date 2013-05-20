# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "datatables_crud/version"

Gem::Specification.new do |s|
  s.name        = "datatables_crud"
  s.version     = DatatablesCRUD::VERSION
  s.author      = "HS Interactive s.r.o. - Ing. Alexander Nikolskiy"
  s.email       = "a.nikolskiy@hs-interactive.eu"
  s.homepage    = ""
  s.summary     = "Datatables CRUD"
  s.description = "Framework to simplify use of the Datatables in RoR applications"
  s.rubyforge_project = s.name
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  #s.add_dependency 'datatables'
  
  s.add_development_dependency 'rspec'
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rails",       "> 3.2"
  s.add_development_dependency "rack",        "> 1.4"
end
