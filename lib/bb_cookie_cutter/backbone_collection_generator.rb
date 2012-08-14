module BbCookieCutter
  class BackboneCollectionGenerator
    attr_accessor :klass, :coffee

    def path
      "\"#{BbCookieCutter::Engine.routes.url_helpers.send "#{@klass.name.pluralize.downcase}_path"}\""
    end

    def initialize klass, coffee
      @klass  = klass
      @coffee = coffee
    end

    def build
      @coffee.puts "# Backbone Collection for #{klass.name}"
      @coffee.class "Bbcc.#{klass.name.gsub "::", "."}", "Bbcc.Collection"
      @coffee.property :url do
        @coffee.define_bound_function do
          @coffee.puts path
        end
      end

      @coffee.puts ""
    end
  end
end
