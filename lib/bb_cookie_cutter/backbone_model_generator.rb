module BbCookieCutter
  class BackboneModelGenerator < CoffeeGenerator
    attr_accessor :klass

    def initialize klass
      @klass  = klass
    end
  end
end
