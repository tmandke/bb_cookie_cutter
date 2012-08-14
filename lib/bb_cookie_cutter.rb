require "bbcc"
require "bb_cookie_cutter/engine"
require "bb_cookie_cutter/coffee_generator"
require "bb_cookie_cutter/backbone_model_generator"
require "bb_cookie_cutter/backbone_collection_generator"
require "bb_cookie_cutter/controller_generator"
require "bb_cookie_cutter/routes_generator"

module BbCookieCutter
  @@to_backbonify = []
  def self.backbonify *models
    @@to_backbonify = models if models.any?
  end

  def self.build_all
    build_controllers
    build_backbone
  end

  def self.build_controllers
    @@to_backbonify.each do |model|
      BbCookieCutter::ControllerGenerator.build model
    end
  end

  def self.build_routes router
    @@to_backbonify.each do |model|
      BbCookieCutter::RoutesGenerator.build model, router
    end
  end

  def self.build_backbone
    generator = CoffeeGenerator.new
    @@to_backbonify.each do |model|
      BbCookieCutter::BackboneModelGenerator.new(model, generator).build
      BbCookieCutter::BackboneCollectionGenerator.new(model, generator).build
    end

    f = File.open("#{BbCookieCutter::Engine.root}/app/assets/javascripts/bbcc/generated.js.coffee", "w")
    f.write generator.string
    f.close
  end
end
