require "bbcc/coffee_generator"
module BBCC
  ExtendsModel        = "Backbone.RelationalModel"
  ExtendsCollection   = "Backbone.Collection"

  module ClassMethods

    def coffee_name
      @@coffee_name ||= ("BBCC::"+self.name).gsub("::",  ".")
    end

    def to_coffee
      g = CoffeeGenerator.new
      g.model self.coffee_name do
        g.attribute :url do
          g.define_bound_function do
            g.puts "alert 'Hell Yes Url can be called'"
          end
        end
      end
    end
  end
end
