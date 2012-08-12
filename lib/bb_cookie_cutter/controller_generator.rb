class BbCookieCutter::ControllerGenerator
  def self.create_class(class_name, super_class, &block)
    klass = Class.new super_class, &block
    split_name = class_name.split("::").delete_if{|p|p.blank?}
    parent = split_name[0..-2].inject(Object) do |obj, name|
      obj.const_set name, Class.new unless obj.constants.include?(name.to_sym)
      obj.const_get name
    end
    parent.send :remove_const, split_name.last.to_sym if parent.constants.include? split_name.last.to_sym
    parent.const_set split_name.last, klass
  end

  def self.controller_name model
    "BbCookieCutter::#{model.name.pluralize}Controller"
  end

  def self.build model
    klass = model
    create_class controller_name(model), ::ApplicationController do
      respond_to :json
      define_method :index do
        respond_with model.all
      end

      define_method :create do
        model.create! params
      end

      define_method :show do
        model.find(params[:id])
      end

      define_method :update do
        model.find(params[:id]).update_attributes params
      end

      define_method :destroy do
        model.destroy params
      end
    end
  end
end
