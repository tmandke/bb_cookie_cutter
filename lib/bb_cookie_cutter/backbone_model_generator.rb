module BbCookieCutter
  class BackboneModelGenerator
    attr_accessor :klass, :coffee

    def self.model_name klass
      "Bbcc.Models.#{klass.name.gsub "::", "."}"
    end

    def initialize klass, coffee
      @klass  = klass
      @coffee = coffee
    end

    def build
      @coffee.puts "# Backbone Model for #{klass.name}"
      @coffee.class self.class.model_name(klass), "BbCookieCutter.Model" do
        build_associations
      end
      @coffee.puts "#{self.class.model_name(klass)}.setup()"

      @coffee.puts ""
    end

    def build_associations
      @coffee.property :relations do
        @coffee.array klass.reflect_on_all_associations do | rel|
          send rel.macro, rel

        end
      end
    end

    def has_many rel
      @coffee.puts "# has_many #{rel.klass}"
      @coffee.hash({
        type: "HasMany",
        key: rel.name,
        relatedModel: BackboneModelGenerator.model_name(rel.klass),
        collectionType: BackboneCollectionGenerator.collection_name(rel.klass),
        reverseRelation: {
          key: rel.foreign_key
        }
      })
    end

    def has_one rel
      @coffee.puts "# has_one #{rel.klass}"
      @coffee.hash({
        type:             "HasOne",
        key:              rel.name,
        relatedModel:     BackboneModelGenerator.model_name(rel.klass)
      })
    end

    def belongs_to rel
      @coffee.puts "# belongs_to #{rel.klass}"
      @coffee.hash({
        type:             "HasOne",
        key:              rel.name,
        relatedModel:     BackboneModelGenerator.model_name(rel.klass)
      })
    end
  end
end
