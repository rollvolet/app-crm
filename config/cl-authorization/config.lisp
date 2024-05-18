;;;;;;;;;;;;;;;;;;;
;;; delta messenger
(in-package :delta-messenger)

(add-delta-logger)
(add-delta-messenger "http://delta-notifier/")

;;;;;;;;;;;;;;;;;
;;; configuration
(in-package :client)
(setf *log-sparql-query-roundtrip* t)
(setf *backend* "http://virtuoso:8890/sparql")

(in-package :server)
(setf *log-incoming-requests-p* t)

;;;;;;;;;;;;;;;;;
;;; access rights

(in-package :acl)

(defparameter *access-specifications* nil
  "All known ACCESS specifications.")

(defparameter *graphs* nil
  "All known GRAPH-SPECIFICATION instances.")

(defparameter *rights* nil
  "All known GRANT instances connecting ACCESS-SPECIFICATION to GRAPH.")

(define-prefixes
  :adms "http://www.w3.org/ns/adms#"
  :crm "http://data.rollvolet.be/vocabularies/crm/"
  :dct "http://purl.org/dc/terms/"
  :dossier "https://data.vlaanderen.be/ns/dossier#"
  :ext "http://mu.semte.ch/vocabularies/ext/"
  :foaf "http://xmlns.com/foaf/0.1/"
  :frapo "http://purl.org/cerif/frapo/"
  :gebouw "https://data.vlaanderen.be/ns/gebouw#"
  :generiek "https://data.vlaanderen.be/ns/generiek#"
  :nco "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#"
  :nfo "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#"
  :ncal "http://www.semanticdesktop.org/ontologies/2007/04/02/ncal#"
  :p2podocument "https://purl.org/p2p-o/document#"
  :p2poinvoice "https://purl.org/p2p-o/invoice#"
  :p2poprice "https://purl.org/p2p-o/price#"
  :person "http://www.w3.org/ns/person#"
  :price "http://data.rollvolet.be/vocabularies/pricing/"
  :prov "http://www.w3.org/ns/prov#"
  :schema "http://schema.org/"
  :session "http://mu.semte.ch/vocabularies/session/"
  :skos "http://www.w3.org/2004/02/skos/core#"
  :vcard "http://www.w3.org/2006/vcard/ns#")

(type-cache::add-type-for-prefix "http://mu.semte.ch/sessions/" "http://mu.semte.ch/vocabularies/session/Session")

(define-graph public ("http://mu.semte.ch/graphs/public")
  ("skos:ConceptScheme" -> _))

(define-graph codelists ("http://mu.semte.ch/graphs/public")
  ("price:VatRate" -> _)
  ("crm:PostalCode" -> _)
  ("schema:Country" -> _)
  ("schema:Language" -> _)
  ("vcard:TelephoneType" -> _)
  ("skos:Concept" -> _))

(define-graph users ("http://mu.semte.ch/graphs/users")
  ("foaf:Person" -> _)
  ("foaf:OnlineAccount" -> _)
  ("foaf:Group" -> _))

(define-graph sessions ("http://mu.semte.ch/graphs/sessions")
  ("session:Session" -> _))

(define-graph employees ("http://mu.semte.ch/graphs/rollvolet")
  ("person:Person" -> _))

(define-graph crm ("http://mu.semte.ch/graphs/rollvolet")
  ("vcard:VCard" -> _)
  ("gebouw:Gebouw" -> _)
  ("nco:Contact" -> _)
  ("crm:CustomerProfile" -> _)
  ("vcard:Address" -> _)
  ("vcard:Email" -> _)
  ("vcard:Telephone" -> _)
  ("crm:Intervention" -> _)
  ("crm:Request" -> _)
  ("schema:Offer" -> _)
  ("crm:Offerline" -> _)
  ("crm:CalculationLine" -> _)
  ("p2podocument:PurchaseOrder" -> _)
  ("p2poinvoice:E-FinalInvoice" -> _)
  ("p2poinvoice:PrePaymentInvoice" -> _)
  ("p2podocument:E-Invoice" -> _)
  ("crm:Invoiceline" -> _)
  ("crm:TechnicalWork" -> _)
  ("crm:CustomerSnapshot" -> _)
  ("crm:ContactSnapshot" -> _)
  ("crm:BuildingSnapshot" -> _)
  ("nfo:FileDataObject" -> _)
  ("nfo:RemoteDataObject" -> _)
  ("dossier:Dossier" -> _)
  ("generiek:GestructureerdeIdentificator" -> _)
  ("ncal:NcalDateTime" -> _)
  ("ncal:Calendar" -> _)
  ("ncal:Event" -> _)
  ("crm:AccountancyExport" -> _)
  ("prov:Activity" -> _))

(supply-allowed-group "public")

(supply-allowed-group "logged-in"
  :parameters ()
  :query "PREFIX session: <http://mu.semte.ch/vocabularies/session/>
      PREFIX foaf: <http://xmlns.com/foaf/0.1/>
      PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
      SELECT ?account WHERE {
          <SESSION_ID> session:account ?account .
      } LIMIT 1")

(supply-allowed-group "admin"
  :parameters ()
  :query "PREFIX session: <http://mu.semte.ch/vocabularies/session/>
      PREFIX foaf: <http://xmlns.com/foaf/0.1/>
      PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
      SELECT ?account WHERE {
          <SESSION_ID> session:account ?account .
          ?user foaf:account ?account ; foaf:member <http://data.rollvolet.be/user-groups/admin> .
      } LIMIT 1")

(grant (read)
  :to-graph (public codelists)
  :for-allowed-group "public")

(grant (read)
  :to-graph (sessions employees users)
  :for-allowed-group "logged-in")

(grant (write)
  :to-graph (crm)
  :for-allowed-group "logged-in")

(grant (write)
  :to-graph (codelists employees users)
  :for-allowed-group "admin")
