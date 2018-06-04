folders = %w[entities database_repositories values policies]

folders.each do |folder|
    require_relative "#{folder}/init.rb"
end