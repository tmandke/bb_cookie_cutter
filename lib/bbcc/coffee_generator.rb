module BBCC
  class CoffeeGenerator
    attr_accessor :coffee, :indent_level

    class IndentCache
      INDENT_WIDTH = 2
      @@cache = []
      def self.[] i
        @@cache[i] = " "*(i*INDENT_WIDTH) if @@cache[i].nil?
        @@cache[i]
      end
    end

    def initialize ind = 0
      @coffee = StringIO.new
      @indent_level = ind
    end

    def string
      @coffee.string
    end

    def write string
      @coffee << indent_str << string
    end

    def puts string
      write "#{string}\n"
    end

    def indent cmd = nil
      puts cmd if cmd
      @indent_level += 1
      yield if block_given?
      @indent_level -= 1
      self
    end

    def class name, extends="", &block
      if @indent_level == 0
        #@nameSpaceManager.add name
        indent "class #{name}#{" extends #{extends}" unless extends.blank?}", &block
      else
        raise "Sorry, indented classes not supported yet"
      end
    end

    def property name
      raise "only supports attributes with no spaces" if name.to_s.split.length != 1
      write "#{name}: "
      yield if block_given?
      self
    end

    def define_bound_function *params, &block
      indent "(#{params.join(", ")}) =>", &block
    end

    def define_unbound_function *params, &block
      indent "(#{params.join(", ")}) ->", &block
    end

    def if exp, &block
      raise "if statements need a block" unless block_given?
      indent "if #{exp}", &block
    end

    def else &block
      raise "else statements need a block" unless block_given?
      indent "else", &block
    end

    protected
    def indent_str
      IndentCache[@indent_level]
    end
  end
end
