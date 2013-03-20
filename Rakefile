require "bundler/gem_tasks"

require "chimpdoc/dropbox_setup"

namespace :setup do
  namespace :dropbox do
    task :config do
      DropboxSetup.perform do |setup|
        setup.prompt_for_app_credentials

        setup.authorise

        setup.config
      end
    end
  end

  task :dropbox do
    Rake::Task['setup:dropbox:config'].invoke
  end
end