defmodule Dispatcher do
  use Matcher

  define_accept_types [
    json: [ "application/json", "application/vnd.api+json" ],
    html: [ "text/html", "application/xhtml+html" ],
    any: [ "*/*" ]
  ]

  define_layers [ :static, :frontend, :api ]

  @json_service %{ layer: :api, accept: %{ json: true } }
  @any_service %{ layer: :api, accept: %{ any: true } }
  @html_pages %{ layer: :frontend, accept: %{ html: true } }

  get "/assets/*path", %{ layer: :static } do
    Proxy.forward conn, path, "http://frontend/assets/"
  end

  get "/torii/redirect.html", %{ layer: :static } do
    Proxy.forward conn, [], "http://frontend/torii/redirect.html"
  end

  get "/*_path", @html_pages do
    Proxy.forward conn, [], "http://frontend/index.html"
  end

  match "/sessions/*path", @json_service do
    Proxy.forward conn, path, "http://msal-login/sessions/"
  end

  match "/api/*path", @any_service do
    Proxy.forward conn, path, "http://monolith-backend/api/"
  end

  match "/*_path", %{ last_call: true, accept: %{ json: true } } do
    send_resp( conn, 404, "{ \"error\": { \"code\": 404, \"message\": \"Route not found.  See config/dispatcher.ex\" } }" )
  end

  match "/*_path", %{ last_call: true } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
