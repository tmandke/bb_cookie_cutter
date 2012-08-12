module BbCookieCutter
  class BackboneCollectionGenerator < CoffeeGenerator
    attr_accessor :klass

    def initialize klass
      @klass  = klass
    end
  end
end
