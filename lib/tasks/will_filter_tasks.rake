namespace :will_filter do

  desc "Sync extra files from will_filter engine."
  task :sync do
    require 'fileutils'
    gem_root = Gem::Specification.find_by_name('will_filter').gem_dir

    # Copy config files
    FileUtils.mkdir_p("#{Rails.root}/config/will_filter")
    FileUtils.cp_r("#{gem_root}/config/will_filter/.", "#{Rails.root}/config/will_filter")

    # Copy migrations
    FileUtils.mkdir_p("#{Rails.root}/db/migrate")
    FileUtils.cp_r("#{gem_root}/db/migrate/.", "#{Rails.root}/db/migrate")

    puts "Synced will_filter config and migrations to your application."
  end

end