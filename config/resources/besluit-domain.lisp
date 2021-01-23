(define-resource meeting ()
  :class (s-prefix "besluit:Zitting")
  :properties `((:planned-start         :datetime ,(s-prefix "besluit:geplandeStart"))
                (:started-on            :datetime ,(s-prefix "prov:startedAtTime")) ;; NOTE: Kept ':geplande-start' from besluit instead of ':start' from besluitvorming
                (:ended-on              :datetime ,(s-prefix "prov:endedAtTime")) ;; NOTE: Kept ':geeindigd-op-tijdstip' from besluit instead of ':eind' from besluitvorming
                (:number                :number   ,(s-prefix "adms:identifier"))
                (:location              :url      ,(s-prefix "prov:atLocation"))) ;; NOTE: besluitvorming mentions (unspecified) type 'Locatie' don't use this
  :has-one `((meeting-type              :via      ,(s-prefix "ext:aard")
                                        :as "type"))
  :has-many `((notification             :via      ,(s-prefix "dct:subject")
                                        :inverse t
                                        :as "notifications"))
  :resource-base (s-url "http://kanselarij.vo.data.gift/id/zittingen/")
  :features '(include-uri)
  :on-path "meetings")

(define-resource meeting-type ()
  :class (s-prefix "ext:MinisterraadType")
  :properties `((:label :string ,(s-prefix "skos:prefLabel"))
                (:alt-label :string ,(s-prefix "skos:altLabel")))
  :has-many `((meeting :via ,(s-prefix "ext:aard")
                       :as "meetings"))
  :resource-base (s-url "http://kanselarij.vo.data.gift/id/concept/ministerraad-type-codes/")
  :features '(include-uri)
  :on-path "meeting-types")

