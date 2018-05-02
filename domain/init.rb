folders = %w[entities database_repositories values]

folders.each do |folder|
    require_relative "#{folder}/init.rb"
end