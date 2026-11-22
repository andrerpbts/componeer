Componeer::Engine.routes.draw do
  root "docs#show", page: "getting_started"
  get "screens/:screen", to: "docs#screen", as: :screen, constraints: { screen: /[a-z_]+/ }
  get ":page", to: "docs#show", as: :doc, constraints: { page: /[a-z_]+/ }
end
