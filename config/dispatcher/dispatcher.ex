defmodule Dispatcher do
  use Matcher

  define_accept_types [
    json: [ "application/json", "application/vnd.api+json" ],
    pdf: [ "application/pdf" ],
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


  ## Document generation

  post "/requests/:id/documents", %{ layer: :services, accept: %{ pdf: true } } do
    Proxy.forward conn, [], "http://documents/requests/" <> id <> "/documents"
  end

  post "/invoices/:id/documents", %{ layer: :services, accept: %{ pdf: true } } do
    Proxy.forward conn, [], "http://documents/invoices/" <> id <> "/documents"
  end

  post "/invoices/:id/files", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, [], "http://ms-files/invoices/" <> id <> "/files"
  end

  post "/deposit-invoices/:id/documents", %{ layer: :services, accept: %{ pdf: true } } do
    Proxy.forward conn, [], "http://documents/deposit-invoices/" <> id <> "/documents"
  end

  ## Monolith exceptions (to be phased out in the long run)

  post "/api/cases/current/contact-and-building", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, [], "http://monolith-backend/api/cases/contact-and-building"
    # Proxy.forward conn, [], "http://172.17.0.1:5010/api/cases/contact-and-building"
  end


  ## Resources
  ## TODO remove /api-prefixed routes to resources once monolith-backend is phased out

  match "/cases/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/cases/"
  end

  get "/concepts/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/concepts/"
  end

  get "/concept-schemes/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/concept-schemes/"
  end

  get "/vat-rates/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/vat-rates/"
  end

  get "/countries/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/countries/"
  end

  get "/languages/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/languages/"
  end

  get "/postal-codes/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/postal-codes/"
  end

  get "/telephone-types/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/telephone-types/"
  end

  get "/employees/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/employees/"
  end

  match "/activities/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/activities/"
  end

  get "/users/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/users/"
  end

  match "/telephones/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/telephones/"
  end

  match "/emails/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/emails/"
  end

  match "/offerlines/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/offerlines/"
  end

  match "/calculation-lines/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/calculation-lines/"
  end

  get "/interventions/:id/visit", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, [], "http://resource/interventions/" <> id <> "/visit"
  end

  match "/interventions/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/interventions/"
  end

  get "/requests/:id/visit", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, [], "http://resource/requests/" <> id <> "/visit"
  end

  match "/requests/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/requests/"
  end

  match "/offers/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/offers/"
  end

  match "/orders/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/orders/"
  end

  get "/deposit-invoices/:id/document", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, [], "http://resource/deposit-invoices/" <> id <> "/document"
  end

  match "/deposit-invoices/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/deposit-invoices/"
  end

  get "/invoices/:id/document", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, [], "http://resource/invoices/" <> id <> "/document"
  end

  match "/invoices/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/invoices/"
  end

  match "/customers/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/customers/"
  end

  match "/contacts/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/contacts/"
  end

  match "/buildings/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/buildings/"
  end

  match "/customer-snapshots/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/customer-snapshots/"
  end

  match "/contact-snapshots/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/contact-snapshots/"
  end

  match "/building-snapshots/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/building-snapshots/"
  end

  match "/addresses/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/addresses/"
  end

  match "/invoicelines/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/invoicelines/"
  end

  match "/technical-work-activities/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/technical-work-activities/"
  end

  post "/calendar-events/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://ms-calendar/calendar-events/"
  end

  patch "/calendar-events/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://ms-calendar/calendar-events/"
  end

  delete "/calendar-events/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://ms-calendar/calendar-events/"
  end

  get "/calendar-events/:id/ms-event", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, [], "http://ms-calendar/calendar-events/" <> id <> "/ms-event"
  end

  get "/calendar-events/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/calendar-events/"
  end

  get "/files/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/files/"
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

  match "/mock-sessions/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://mock-login/sessions/"
  end

  get "/accounts/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/accounts/"
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
