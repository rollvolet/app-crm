defmodule Dispatcher do
  use Matcher

  define_accept_types [
    json: [ "application/json", "application/vnd.api+json" ],
    html: [ "text/html", "application/xhtml+html" ],
    any: [ "*/*" ]
  ]

  define_layers [ :static, :services ]

  ## Static frontend resources of all kinds

  get "/assets/*path", %{ layer: :static } do
    Proxy.forward conn, path, "http://frontend/assets/"
  end

  get "/torii/redirect.html", %{ layer: :static } do
    Proxy.forward conn, [], "http://frontend/torii/redirect.html"
  end


  ## MS Files service

  post "/cases/:id/attachments", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, [], "http://ms-files/cases/" <> id <> "/attachments"
  end

  delete "/files/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://ms-files/files/"
  end

  get "/files/:id/download", %{ layer: :services, accept: %{ any: true } } do
    Proxy.forward conn, [], "http://ms-files/files/" <> id <> "/download"
  end


  ## Monolith exceptions (to be phased out in the long run)

  match "/api/cases/current/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://monolith-backend/api/cases/"
  end


  ## Resources
  ## TODO remove /api prefix of all routes to resources once monolith-backend is phased out

  get "/api/cases/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/cases/"
  end

  match "/api/calculation-lines/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/calculation-lines/"
  end

  get "/api/files/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/files/"
  end

  get "/api/remote-files/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/remote-files/"
  end

  match "/api/*path", %{ layer: :services, accept: %{ any: true } } do
    Proxy.forward conn, path, "http://monolith-backend/api/"
    # Proxy.forward conn, path, "http://172.17.0.1:5010/api/"
  end


  ## Authentication / login

  match "/sessions/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://msal-login/sessions/"
  end


  ## Fallback

  get "/*_path", %{ layer: :services, accept: %{ html: true } } do
    Proxy.forward conn, [], "http://frontend/index.html"
  end

  match "/*_path", %{ last_call: true, accept: %{ json: true } } do
    send_resp( conn, 404, "{ \"error\": { \"code\": 404, \"message\": \"Route not found.  See config/dispatcher.ex\" } }" )
  end

  match "/*_path", %{ last_call: true } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
