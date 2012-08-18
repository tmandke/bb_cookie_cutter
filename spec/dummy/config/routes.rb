Rails.application.routes.draw do
  root to: "main#index"
  mount BbCookieCutter::Engine => "/bbcc"
end
