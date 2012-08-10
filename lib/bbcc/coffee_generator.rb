class BBCC
  class CoffeeGenerator
    attr_accessor :coffee, :indent_level
    INDENT_WIDTH = 2

    def initialize ind = 0
      @coffee = StringIO.new
      @indent_level = ind
    end

    def clear
      @coffee = StringIO.new
    end

    def puts string
      @coffee << (" "*@indent_level) << string << "\n"
    end

    def next_indent
      @indent_level + INDENT_WIDTH
    end

    def if exp
      g = self.class.new(next_indent)
      yield g
      puts "if #{exp}"
      @coffee << g.string
      self
    end

    def string
      @coffee.string
    end

    def self.build ind = 0
      g = self.new(ind)
      yield g
      g
    end
  end
end
