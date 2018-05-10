require 'rake/testtask'

# Configuration only --not for direct calls
task :config do
  require_relative 'config/environments.rb'
  @app = TalkUp::Api
  @config = @app.config
end

desc 'Run application console (pry)'
task :console do
  sh 'pry -r ./spec/test_load_all'
end

namespace :quality do
  CODE = '**/*.rb'

  desc 'Run Rubocop quality checks'
  task :rubocop do
    sh "rubocop #{CODE}"
  end
end

namespace :db do
  require_relative 'config/environments.rb' #load config info
  require 'sequel'

  Sequel.extension :migration
  app = TalkUp::Api

  desc 'Run migrations'
  task :migrate do
    puts "Migrating #{app.environment} database to latest"
    Sequel::Migrator.run(app.DB, 'infrastructure/database/migrations')
  end

  desc 'Drop all tables'
  task :drop do
    require_relative 'config/environments.rb'
    # Drop according to dependencies
    app.DB.drop_table :accounts
    app.DB.drop_table :issues
    app.DB.drop_table :accounts_issues
    app.DB.drop_table :comments
    app.DB.drop_table :feedbacks
    app.DB.drop_table :feedback_descriptions
  end

  desc 'Reset all database tables'
  task reset: [:drop, :migrate]

  desc 'Delete dev or test database file'
  task :wipe do
    if app.environment == :production
      puts 'Cannot wipe production database!'
      return
    end

    FileUtils.rm(app.config.DB_FILENAME)
    puts "Deleted #{app.config.DB_FILENAME}"
  end
end
