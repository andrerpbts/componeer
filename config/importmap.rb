pin "componeer", to: "componeer/index.js"
pin "componeer/docs", to: "componeer/docs.js"
pin_all_from Componeer::Engine.root.join("app/javascript/componeer/controllers"),
  under: "componeer/controllers", to: "componeer/controllers"
