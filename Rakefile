 
task :spec do
   ruby "./spec/*_spec.rb"
end


task :console do
    sh 'pry -r ./spec/test_load_all'
end


namespace :newkey do
    desc 'Create sample cryptographic key for database'
    task :db do
        require './lib/secure_db.rb'
        puts "DB_KEY: #{SecureDB.generate_key}"
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
        Sequel::Migrator.run(app.DB, 'infrastructure/database/migrations', allow_missing_migration_files: true)
    end

    desc "Prints current schema version"
    task :version do    
        version = if app.DB.tables.include?(:schema_info)
        app.DB[:schema_info].first[:version]
        end || 0
        puts "Schema Version: #{version}"
    end

    desc 'Drop all table'
    task :drop do
        require_relative './config/environments.rb'

        app.DB.drop_table :issues
        app.DB.drop_table :comments
    end

    desc 'Reset Database'
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