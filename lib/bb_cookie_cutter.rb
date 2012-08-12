require "bb_cookie_cutter/engine"
require "bbcc/coffee_generator"
require "bbcc/backbone_model_generator"
require "bbcc/backbone_collection_generator"
require "bbcc/controller_generator"

module BbCookieCutter
  @@to_backbonify = []
  def self.backbonify *models
    @@to_backbonify = models
    build_controllers
  end

  def self.build_controllers
    @@to_backbonify.each do |model|
      BBCC::ControllerGenerator.build model
    end
  end
end
