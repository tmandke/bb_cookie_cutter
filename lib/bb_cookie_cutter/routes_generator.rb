module BbCookieCutter::RoutesGenerator
  def self.build model, router
    router.resources model.table_name.to_sym, :only => [:index, :create, :show, :update, :destroy], :controller => model.name.downcase.pluralize.to_sym
  end
end
