(define-resource meeting ()
  :class (s-prefix "besluit:Zitting")
  :properties `((:planned-start         :datetime ,(s-prefix "besluit:geplandeStart"))
                (:started-on            :datetime ,(s-prefix "prov:startedAtTime")) ;; NOTE: Kept ':geplande-start' from besluit instead of ':start' from besluitvorming
                (:ended-on              :datetime ,(s-prefix "prov:endedAtTime")) ;; NOTE: Kept ':geeindigd-op-tijdstip' from besluit instead of ':eind' from besluitvorming
                (:number                :number   ,(s-prefix "adms:identifier"))
                (:location              :url      ,(s-prefix "prov:atLocation")) ;; NOTE: besluitvorming mentions (unspecified) type 'Locatie' don't use this
                (:type                  :url , (s-prefix "ext:aard")))
  :has-many `((notification             :via      ,(s-prefix "dct:subject")
                                        :inverse t
                                        :as "notifications"))
  :resource-base (s-url "http://kanselarij.vo.data.gift/id/zittingen/")
  :features '(include-uri)
  :on-path "meetings")
