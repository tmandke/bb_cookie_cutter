require "bb_cookie_cutter/engine"
require "bbcc"
require "debugger"

module BbCookieCutter
  module Sprockets
    def find_assets path, options
      raise "woot got here"
      debugger
      asset = super path, options
      if asset.nil?
        nil
      else
        asset
      end
    end
  end
end
