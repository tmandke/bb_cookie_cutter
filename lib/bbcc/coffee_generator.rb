module BBCC
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

    def write string
      @coffee << (" "*@indent_level) << string
    end

    def puts string
      write "#{string}\n"
    end

    def indent cmd
      puts cmd
      @indent_level += INDENT_WIDTH
      yield
      @indent_level -= INDENT_WIDTH
      self
    end

    def string
      @coffee.string
    end

    def class name, extends, &block
      if @indent_level == 0
        #@nameSpaceManager.add name
        indent "class #{name} extend #{}", &block
      else
        raise "Sorry, indented classes not supported yet"
      end
    end

    def model name, &block
      self.class name, BBCC::ExtendsModel, &block
    end

    def collection name, &block
      self.class name, BBCC::ExtendsCollection, &block
    end

    def attribute name, &block
      raise "only supports attributes with no spaces" if name.to_s.split.length != 1
      write "#{name}: "
      yield
      self
    end

    def define_bound_function *params, &block
      indent "(#{params.join(", ")}) =>", &block
    end

    def define_unbound_function *params, &block
      indent "(#{params.join(", ")}) ->", &block
    end

    def if exp, &block
      indent "if #{exp}", &block
    end

    def else &block
      indent "else", &block
    end
  end
end
