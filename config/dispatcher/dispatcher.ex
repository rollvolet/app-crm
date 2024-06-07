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


  ## Authentication / login

  match "/sessions/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://msal-login/sessions/"
  end

  match "/mock-sessions/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://mock-login/sessions/"
  end

  get "/accounts/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://resource/accounts/"
  end


  ## File upload and download

  post "/cases/:id/attachments", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, [], "http://ms-files/cases/" <> id <> "/attachments"
  end

  post "/cases/:id/production-tickets", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, [], "http://ms-files/cases/" <> id <> "/production-tickets"
  end

  delete "/files/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://ms-files/files/"
  end

  get "/files/:id/download", %{ layer: :services, accept: %{ any: true } } do
    Proxy.forward conn, [], "http://ms-files/files/" <> id <> "/download"
  end

  get "/downloads/*path", %{ layer: :services, accept: %{ any: true } } do
    Proxy.forward conn, path, "http://ms-files/downloads/"
  end

  delete "/downloads/*path", %{ layer: :services, accept: %{ any: true } } do
    Proxy.forward conn, path, "http://ms-files/downloads/"
  end

  get "/files/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/files/"
  end

  get "/remote-files/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/remote-files/"
  end


  ## Document generation

  post "/requests/:id/documents", %{ layer: :services, accept: %{ pdf: true } } do
    Proxy.forward conn, [], "http://documents/requests/" <> id <> "/documents"
  end

  post "/interventions/:id/documents", %{ layer: :services, accept: %{ pdf: true } } do
    Proxy.forward conn, [], "http://documents/interventions/" <> id <> "/documents"
  end

  post "/offers/:id/documents", %{ layer: :services, accept: %{ pdf: true } } do
    Proxy.forward conn, [], "http://documents/offers/" <> id <> "/documents"
  end

  post "/orders/:id/documents", %{ layer: :services, accept: %{ pdf: true } } do
    Proxy.forward conn, [], "http://documents/orders/" <> id <> "/documents"
  end

  post "/orders/:id/delivery-notes", %{ layer: :services, accept: %{ pdf: true } } do
    Proxy.forward conn, [], "http://documents/orders/" <> id <> "/delivery-notes"
  end

  post "/deposit-invoices/:id/documents", %{ layer: :services, accept: %{ pdf: true } } do
    Proxy.forward conn, [], "http://documents/deposit-invoices/" <> id <> "/documents"
  end

  post "/invoices/:id/documents", %{ layer: :services, accept: %{ pdf: true } } do
    Proxy.forward conn, [], "http://documents/invoices/" <> id <> "/documents"
  end

  post "/cases/:id/production-ticket-templates", %{ layer: :services, accept: %{ pdf: true } } do
    Proxy.forward conn, [], "http://documents/cases/" <> id <> "/production-ticket-templates"
  end

  post "/cases/:id/watermarked-production-tickets", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, [], "http://documents/cases/" <> id <> "/watermarked-production-tickets"
  end


  ## Calendar events

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


  ## Accountancy exports service

  post "/accountancy-exports/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://accountancy-export/accountancy-exports/"
  end

  get "/accountancy-exports/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/accountancy-exports/"
  end

  get "/accountancy-export-warnings/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://accountancy-export/accountancy-export-warnings/"
  end


  ## Reporting service

  post "/revenue-reports/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://reporting/revenue-reports/"
  end

  post "/error-notifications/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://reporting/error-notifications/"
  end


  ## Search
  get "/:index/search", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, [], "http://search/" <> index <> "/search"
  end


  ## Sequence numbers
  post "/sequence-numbers/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://sequence-numbers/sequence-numbers/"
  end


  ## Regular resources

  match "/cases/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/cases/"
  end

  match "/concepts/*path", %{ layer: :services, accept: %{ json: true } } do
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

  match "/employees/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/employees/"
  end

  match "/activities/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/activities/"
  end

  match "/users/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/users/"
  end

  get "/user-groups/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/user-groups/"
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

  match "/customer-profiles/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/customer-profiles/"
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

  match "/structured-identifiers/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/structured-identifiers/"
  end

  match "/time-slots/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/time-slots/"
  end

  match "/calendar-days/*path", %{ layer: :services, accept: %{ json: true } } do
    Proxy.forward conn, path, "http://cache/calendar-days/"
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
