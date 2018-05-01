 
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
        Sequel::Migrator.run(app.DB, 'infrastructure/database/migrations')
    end

end