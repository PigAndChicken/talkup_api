Dir.glob("#{FILE.dirname(__FILE__)}/*.rb").each do |file|
    require file
end