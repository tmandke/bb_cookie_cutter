module BbCookieCutter
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

    class NamespaceManager
      @namespaces
      def initialize
        @namespaces = {}
      end
      def add str
        str.split(".").inject(@namespaces){|namespaces, part|
          puts namespaces
          puts part
          namespaces[part] ||= {}
          namespaces[part]
        }
      end
      def string
        if @namespaces.keys.any?
          c = CoffeeGenerator.new
          puts @namespaces
          @namespaces.each do |key, val|
            c.write "window.#{key} = "
            c.coffee_it val
            c.puts ""
          end
          c.string
        else
          ""
        end
      end
    end

    def initialize ind = 0
      @coffee = StringIO.new
      @indent_level = ind
      @namespace_manager = NamespaceManager.new
    end

    def string
      @namespace_manager.string + @coffee.string
    end

    def write string
      if @ignore_indents_next
        @ignore_indents_next = false
      else
        @coffee << indent_str
      end
      @coffee << string
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
        @namespace_manager.add name
        indent "class #{name}#{" extends #{extends}" unless extends.blank?}", &block
      else
        raise "Sorry, indented classes not supported yet"
      end
    end

    def property name
      raise "only supports attributes with no spaces" if name.to_s.split.length != 1
      write "#{name}: "
      @ignore_indents_next = true
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

    def coffee_it item
      if item.is_a? Array
        array item
      elsif item.is_a? Hash
        hash item
      elsif item.is_a?(String) || item.is_a?(Symbol)
        puts "\"#{item}\""
      else
        puts item.to_s
      end
    end

    def array arr
      indent "[" do
        arr.each do | item |
          if block_given?
            yield item
          else
            coffee_it item
          end
        end
      end
      puts "]"
    end

    def hash hash
      indent "{" do
        hash.each do | key, item |
          if block_given?
            yield key, item
          else
            property key do
              coffee_it item
            end
          end
        end
      end
      puts "}"
    end

    protected
    def indent_str
      IndentCache[@indent_level]
    end
  end
end
