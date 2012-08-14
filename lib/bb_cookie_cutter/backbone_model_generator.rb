module BbCookieCutter
  class BackboneModelGenerator
    attr_accessor :klass, :coffee

    def initialize klass, coffee
      @klass  = klass
      @coffee = coffee
    end

    def build
      @coffee.puts "# Backbone Model for #{klass.name}"
      @coffee.class "Bbcc.#{klass.name.gsub "::", "."}", "Bbcc.Model"
      @coffee.puts ""
    end
  end
end
