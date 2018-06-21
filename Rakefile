require 'rake/testtask' 


namespace :spec do 

    desc 'Run all the unit test'
    Rake::TestTask.new(:unit) do |t|
        t.pattern = 'specs/unit/*_spec.rb'
        t.warning = false
    end

    
    desc 'Run all the api test'
    Rake::TestTask.new(:api) do |t|
        t.pattern = 'specs/integration/*_spec.rb'
        t.warning = false
    end
end

namespace :test do 
    desc 'it does a thing'
    task :work, [:option, :foo, :bar] do |task, args|
        puts "works", args
    end
end

task :console do
    sh 'pry -r ./specs/test_load_all'
end


namespace :newkey do
    desc 'Create sample cryptographic key for database'
    task :db do
        require './lib/secure_db.rb'
        puts "DB_KEY: #{SecureDB.generate_key}"
    end

    task :keypair do 
        require './lib/signed_request.rb'
        puts "#{SignedRequest.generate_keypair}"
    end
end


namespace :config do
    require_relative './config/environments.rb'

    app = TalkUp::Api
    task :env_var do
        puts "env: #{app.environment}"
        puts "db_filename: #{app.config.DB_FILENAME}"
    end
end

namespace :db do
    require 'sequel'

    require_relative './config/environments.rb'

    Sequel.extension :migration
    app = TalkUp::Api

    desc 'Run Migration'
    task :migrate do 
        puts "Migration #{app.environment} database to lastest"
        Sequel::Migrator.run(app.DB, 'infrastructure/database/migrations')
    end

    desc "Prints current schema version"
    task :version do    
        version = if app.DB.tables.include?(:schema_info)
        app.DB[:schema_info].first[:version]
        end || 0
        puts "Schema Version: #{version}"
    end

    desc 'Drop all table'
    task :delete do
        require_relative './config/environments.rb'
    
        app.DB[:feedbacks].delete
        app.DB[:feedback_descriptions].delete
        app.DB[:comments].delete
        app.DB[:accounts_issues].delete
        app.DB[:issues].delete
        app.DB[:accounts].delete
    end

    desc 'Reset Database'
    task reset: [:delete, :migrate]
    
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