Rails.application.routes.draw do
  mount Componeer::Engine => "/componeer"
  root to: redirect("/componeer")
end
