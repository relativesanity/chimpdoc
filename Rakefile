require "bundler/gem_tasks"

require "chimpdoc/dropbox_setup"

namespace :setup do
  namespace :dropbox do
    task :config do
      DropboxSetup.perform
    end
  end

  task :dropbox do
    Rake::Task['setup:dropbox:config'].invoke
  end
end