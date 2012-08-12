class BBCC::ControllerGenerator
  def self.create_class(class_name, super_class, &block)
    klass = Class.new super_class, &block
    split_name = class_name.split("::")
    parent = split_name[0..-2].inject(Object) do |obj, name|
      obj.const_set name, Class.new unless obj.constants.include?(name.to_sym)
      obj.const_get name
    end
    raise "can not override existing class" if parent.constants.include? split_name.last.to_sym
    parent.const_set split_name.last, klass
  end

  def self.build model
    create_class "BBCC::#{model.name.pluralize}Controller", ::ApplicationController do
      def index
        puts "in index of #{self.class.name}"
      end

      def create
        puts "in create of #{self.class.name}"
      end

      def show
        puts "in show of #{self.class.name}"
      end

      def update
        puts "in update of #{self.class.name}"
      end

      def destroy
        puts "in destroy of #{self.class.name}"
      end
    end
  end
end
