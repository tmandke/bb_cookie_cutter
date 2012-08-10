require "bbcc/coffee_generator"
class BBCC
  def self.to_coffee
    CoffeeGenerator.build do |g|
      g.puts "hell ya"
      g.if "this works" do |g|
        g.puts "I am leaving for work"
      end
    end.string
  end
end
