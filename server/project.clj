(defproject flop "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "EPL-2.0 OR GPL-2.0-or-later WITH Classpath-exception-2.0"
            :url "https://www.eclipse.org/legal/epl-2.0/"}
  :dependencies [[org.clojure/clojure "1.10.3"]
                    ; Rest
                    [compojure "1.6.1"]
                    [http-kit "2.3.0"]
                    [ring/ring-defaults "0.3.2"]
                    [org.clojure/data.json "0.2.6"]
                    ; DB
                    [org.postgresql/postgresql "42.2.4"]
                    [honeysql/honeysql "1.0.461"]
                    [toucan/toucan "1.18.0"]
                    [green-tags "0.3.0-alpha"]
                    ]
  :repl-options {:init-ns flop.core}
  :plugins [[lein-environ "0.4.0"]])
