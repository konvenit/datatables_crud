require 'datatables_crud/version'

require 'rails/all'

def current_path
  File.dirname(__FILE__)
end

def include_file(filename)
  filename = filename.sub(current_path, '')
  require File.join(current_path, File.dirname(filename), File.basename(filename, '.rb'))
end

autoload_dirs = %w{datatables helpers support}

autoload_dirs.each do |dir|
  Dir.glob(File.join(current_path, 'datatables_crud', dir, '**/*.rb')).sort.each do |file|
    include_file file
  end
end

# load localizations
Dir.glob(File.join(current_path, 'datatables_crud', 'config', 'locales', '**/*.yml')).each do |locale_file|
  I18n.load_path << locale_file
end

module DatatablesCRUD

  class Railtie < ::Rails::Railtie
    initializer 'datatables_crud.init' do |app|
      Dir.glob(File.join(current_path, 'datatables_crud', 'controllers', '**/*.rb')).sort.each do |file|
        include_file file
      end
    end
  end

end