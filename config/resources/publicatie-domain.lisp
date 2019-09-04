(define-resource theme ()
  :class (s-prefix "ext:ThemaCode") ;; NOTE: as well as skos:Concept
  :properties `((:label         :string ,(s-prefix "skos:prefLabel"))
                (:scope-note    :string ,(s-prefix "skos:scopeNote"))
                (:alt-label     :string ,(s-prefix "skos:altLabel"))
                (:deprecated    :bool   ,(s-prefix "owl:deprecated")))
  :resource-base (s-url "http://kanselarij.vo.data.gift/id/concept/thema-codes/")
  :features `(no-pagination-defaults include-uri)
  :on-path "themes")
