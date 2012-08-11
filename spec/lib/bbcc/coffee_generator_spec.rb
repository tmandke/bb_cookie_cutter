require 'spec_helper'

describe BBCC::CoffeeGenerator do
  before do
    @g = BBCC::CoffeeGenerator.new
  end
  describe "#initialize" do
    it "should create itself with the correct number of indents" do
      BBCC::CoffeeGenerator.new.indent_level.should eq(0)
      BBCC::CoffeeGenerator.new(1).indent_level.should eq(1)
      BBCC::CoffeeGenerator.new(10).indent_level.should eq(10)
    end
  end

  describe "#string" do
    it "should call string on the @coffee" do
      @g.coffee.should_receive(:string).once
      @g.string
    end
  end

  describe "#write" do
    it "should write a string without adding newline" do
      @g.write "No New Line At The End"
      @g.string.should eq("No New Line At The End")
    end
  end

  describe "#puts" do
    it "should write a string ending with newline" do
      @g.puts "No New Line At The End"
      @g.string.should eq("No New Line At The End\n")
    end
  end

  describe "#indent" do
    it "should increase indent for the block and bring it back down after" do
      il = @g.indent_level
      @g.indent do
        @g.indent_level.should eq(il+1)
      end
      @g.indent_level.should eq(il)
    end

    it "should also puts command if given" do
      @g.indent "you are awesome"
      @g.string.should eq ("you are awesome\n")
    end
  end

  describe "#class" do
    it "should construct class without extend and indent the block" do
      il = @g.indent_level
      @g.class "Leroy" do
        @g.indent_level.should eq(il+1)
      end
      @g.string.should eq("class Leroy\n")
    end

    it "should construct class with extend and indent the block" do
      il = @g.indent_level
      @g.class "Leroy", "Jenkins"do
        @g.indent_level.should eq(il+1)
      end
      @g.string.should eq("class Leroy extends Jenkins\n")
    end
  end

  describe "#property" do
    it "should produce buya property and not indent in the block" do
      il = @g.indent_level
      @g.property "buya" do
        @g.indent_level.should eq(il)
      end
      @g.string.should eq("buya: ")
    end
  end

  describe "#define_bound_function" do
    it "should produce a bound function with 3 parameters and indent the block" do
      il = @g.indent_level
      @g.define_bound_function :i, :am, :bound do
        @g.indent_level.should eq(il+1)
      end
      @g.string.should eq("(i, am, bound) =>\n")
    end
  end

  describe "#define_unbound_function" do
    it "should produce a unbound function with 3 parameters and indent the block" do
      il = @g.indent_level
      @g.define_unbound_function :i, :am, :unbound do
        @g.indent_level.should eq(il+1)
      end
      @g.string.should eq("(i, am, unbound) ->\n")
    end
  end

  describe "#if" do
    it "should produce if block with the expression and be indent the block" do
      il = @g.indent_level
      @g.if "x > y" do
        @g.indent_level.should eq(il+1)
      end
      @g.string.should eq("if x > y\n")
    end

    it "should raise expression if a block is not provided" do
      lambda { @g.if "x > y" }.should raise_error
    end
  end

  describe "#else" do
    it "should produce a else block and indent the block" do
      il = @g.indent_level
      @g.else do
        @g.indent_level.should eq(il+1)
      end
      @g.string.should eq("else\n")
    end

    it "should raise expression if a block is not provided" do
      lambda { @g.else }.should raise_error
    end
  end
end
