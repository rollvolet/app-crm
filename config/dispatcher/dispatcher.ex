defmodule Dispatcher do
  use Matcher

  define_accept_types [
    json: [ "application/json", "application/vnd.api+json" ],
    html: [ "text/html", "application/xhtml+html" ],
    any: [ "*/*" ]
  ]

  define_layers [ :static, :monolith, :services ]

  get "/assets/*path", %{ layer: :static } do
    Proxy.forward conn, path, "http://frontend/assets/"
  end

  get "/torii/redirect.html", %{ layer: :static } do
    Proxy.forward conn, [], "http://frontend/torii/redirect.html"
  end

  match "/api/*path", %{ layer: :monolith, accept: %{ any: true } } do
    Proxy.forward conn, path, "http://monolith-backend/api/"
  end

  get "/*_path", %{ layer: :services, accept: %{ html: true } } do
    Proxy.forward conn, [], "http://frontend/index.html"
  end

  match "/sessions/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://msal-login/sessions/"
  end

  match "/*_path", %{ last_call: true, accept: %{ json: true } } do
    send_resp( conn, 404, "{ \"error\": { \"code\": 404, \"message\": \"Route not found.  See config/dispatcher.ex\" } }" )
  end

  match "/*_path", %{ last_call: true } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
