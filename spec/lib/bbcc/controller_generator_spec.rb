require "spec_helper"

describe BBCC::ControllerGenerator do

  describe "#index" do
    before :all do
      @subject = BBCC::ControllerGenerator.create_class "BBCC::Leroy::Jenkins", ApplicationController
    end

    it "should create full chain of constants" do
      lambda {BBCC::Leroy::Jenkins}.should_not raise_error NameError
    end

    it "should create the Jenkins class" do
      BBCC::Leroy::Jenkins.should be_an_instance_of(Class)
    end

    it "should raise error if sameclass is built twice" do
      lambda { BBCC::ControllerGenerator.create_class "BBCC::Leroy::Jenkins", ApplicationController }.should raise_error
    end

    it "should be a ApplicationController" do
      BBCC::Leroy::Jenkins.new.should be_a ApplicationController
    end
  end

  describe "#build" do
    before :all do
      @subject = BBCC::ControllerGenerator.build(Post).new
    end

    it "should build a controller with the name BBCC::PostsController" do
      @subject.should be_a ApplicationController
    end

    it "should inherit form ApplicationController" do
      @subject.should be_a ApplicationController
    end

    it "should respond_to ICRUD" do
      @subject.should respond_to :index, :create, :show, :update, :destroy
    end
  end
end
