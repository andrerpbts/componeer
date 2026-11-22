Componeer::Engine.routes.draw do
  root "docs#show", page: "getting_started"
  get ":page", to: "docs#show", as: :doc, constraints: { page: /[a-z_]+/ }
end
