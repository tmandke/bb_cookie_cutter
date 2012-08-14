module BbCookieCutter
  class Engine < ::Rails::Engine
    isolate_namespace Bbcc
    config.to_prepare do
      Rails.application.reload_routes!
      BbCookieCutter.build_all
    end
  end
end
