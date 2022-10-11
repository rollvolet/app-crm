(in-package :mu-cl-resources)

(defparameter *supply-cache-headers-p* t
  "when non-nil, cache headers are supplied.  this works together with mu-cache.")
(defparameter *include-count-in-paginated-responses* t
  "when non-nil, all paginated listings will contain the number
   of responses in the result object's meta.")
(defparameter *cache-count-queries* t)
(defparameter *cache-model-properties* t)
(defparameter *log-delta-clear-keys* t)
(defparameter sparql:*experimental-no-application-graph-for-sudo-select-queries* t)

(read-domain-file "cases.json")
(read-domain-file "codelists.json")
(read-domain-file "customers.json")
(read-domain-file "invoices.json")
(read-domain-file "files.json")
(read-domain-file "calendars.json")
