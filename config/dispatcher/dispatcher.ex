defmodule Dispatcher do
  use Matcher

  define_accept_types [
    json: [ "application/json", "application/vnd.api+json" ],
    html: [ "text/html", "application/xhtml+html" ],
    any: [ "*/*" ]
  ]

  define_layers [ :static, :services ]

  ## Static frontend resources of all kinds

  get "/favicon.ico", %{ layer: :static } do
    Proxy.forward conn, [], "http://frontend/favicon.ico"
  end

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

  post "/api/cases/current/contact-and-building", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, [], "http://monolith-backend/api/cases/contact-and-building"
    # Proxy.forward conn, [], "http://172.17.0.1:5010/api/cases/contact-and-building"
  end


  ## Resources
  ## TODO remove /api-prefixed routes to resources once monolith-backend is phased out

  match "/api/cases/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/cases/"
  end

  match "/cases/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/cases/"
  end

  get "/api/concepts/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/concepts/"
  end

  get "/concepts/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/concepts/"
  end

  get "/api/concept-schemes/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/concept-schemes/"
  end

  get "/concept-schemes/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/concept-schemes/"
  end

  get "/api/vat-rates/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/vat-rates/"
  end

  get "/vat-rates/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/vat-rates/"
  end

  get "/api/countries/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/countries/"
  end

  get "/countries/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/countries/"
  end

  get "/api/telephone-types/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/telephone-types/"
  end

  get "/telephone-types/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/telephone-types/"
  end

  get "/api/employees/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/employees/"
  end

  get "/employees/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/employees/"
  end

  match "/api/telephones/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/telephones/"
  end

  match "/telephones/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/telephones/"
  end

  match "/api/offerlines/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/offerlines/"
  end

  match "/offerlines/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/offerlines/"
  end

  match "/api/calculation-lines/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/calculation-lines/"
  end

  match "/calculation-lines/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/calculation-lines/"
  end

  # match "/api/invoices/*path", %{ layer: :services, accept: %{ json: true } } do
  #   Proxy.forward conn, path, "http://cache/invoices/"
  # end

  # match "/invoices/*path", %{ layer: :services, accept: %{ json: true } } do
  #   Proxy.forward conn, path, "http://cache/invoices/"
  # end

  match "/api/invoicelines/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/invoicelines/"
  end

  match "/invoicelines/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/invoicelines/"
  end

  match "/api/technical-work-activities/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/technical-work-activities/"
  end

  match "/technical-work-activities/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/technical-work-activities/"
  end

  post "/api/calendar-events/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://ms-calendar/calendar-events/"
  end

  patch "/api/calendar-events/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://ms-calendar/calendar-events/"
  end

  delete "/api/calendar-events/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://ms-calendar/calendar-events/"
  end

  get "/calendar-events/:id/ms-event", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, [], "http://ms-calendar/calendar-events/" <> id <> "/ms-event"
  end

  get "/api/calendar-events/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/calendar-events/"
  end

  get "/calendar-events/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/calendar-events/"
  end

  get "/api/files/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/files/"
  end

  get "/files/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/files/"
  end

  get "/api/remote-files/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/remote-files/"
  end

  get "/remote-files/*path", %{ layer: :services, accept: %{ json: true } } do
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
