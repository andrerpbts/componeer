Componeer::Engine.routes.draw do
  root "docs#show", slug: "getting_started"
  get "screens/:screen", to: "docs#screen", as: :screen, constraints: { screen: /[a-z_]+/ }
  get ":slug", to: "docs#show", as: :doc, constraints: { slug: /[a-z_]+/ }
end
