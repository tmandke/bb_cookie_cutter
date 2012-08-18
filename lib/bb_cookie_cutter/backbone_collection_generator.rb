module BbCookieCutter
  class BackboneCollectionGenerator
    attr_accessor :klass, :coffee

    def self.collection_name klass
      "Bbcc.Collections.#{klass.name.gsub("::", ".").pluralize}"
    end

    def path
      "\"#{BbCookieCutter::Engine.routes.url_helpers.send "#{@klass.name.pluralize.downcase}_path"}\""
    end

    def initialize klass, coffee
      @klass  = klass
      @coffee = coffee
    end

    def build
      @coffee.puts "# Backbone Collection for #{klass.name}"
      @coffee.class self.class.collection_name(klass), "BbCookieCutter.Collection" do
        @coffee.property :model do
          @coffee.puts BackboneModelGenerator.model_name(@klass)
        end
        @coffee.property :url do
          @coffee.define_bound_function do
            @coffee.puts path
          end
        end
      end

      @coffee.puts ""
    end
  end
end
