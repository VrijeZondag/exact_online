class ExactOnline::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  def add_exact_online_initializer
    copy_file "exact_online.rb", "config/initializers/exact_online.rb"
  end
end
