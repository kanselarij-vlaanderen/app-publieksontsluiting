(in-package :mu-cl-resources)
(defparameter *cache-model-properties-p* t)
(defparameter *cache-count-queries* t)
(defparameter *supply-cache-headers-p* t
  "when non-nil, cache headers are supplied.  this works together with mu-cache.")
(defparameter *include-count-in-paginated-responses* t
  "when non-nil, all paginated listings will contain the number
   of responses in the result object's meta.")
(defparameter *max-group-sorted-properties* nil)

(read-domain-file "mandaat-domain.lisp")
(read-domain-file "publicatie-domain.lisp")
(read-domain-file "besluit-domain.lisp")
(read-domain-file "document-domain.lisp")
(read-domain-file "files-domain.lisp")

(define-resource notification ()
   :class (s-prefix "ext:Notification")
   :properties `((:title :string ,(s-prefix "dct:title"))
                 (:description :string ,(s-prefix "dct:description")))
   :has-one `((meeting :via ,(s-prefix "dct:subject")
                       :as "meeting"))
   :resource-base (s-url "http://kanselarij.vo.data.gift/notifications/")
   :on-path "notifications")
