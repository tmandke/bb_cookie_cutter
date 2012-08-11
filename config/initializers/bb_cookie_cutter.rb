puts "initializing bbcc"
ActiveRecord::Base.send :extend, BbCookieCutter
