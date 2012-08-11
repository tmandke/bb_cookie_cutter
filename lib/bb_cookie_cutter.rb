require "bb_cookie_cutter/engine"
require "bbcc"

module BbCookieCutter
  @@backbonify = []
  def backbonify
    self.send :extend, BBCC::ClassMethods
    @@backbonify << self
  end
end
