(ns flop.core
  (:require [org.httpkit.server :as server]
            [compojure.core :refer [defroutes GET]]
            [compojure.route :as route]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]
            [flop.db.init])
  (:gen-class))

(defroutes app-routes
  (GET "/" [] "hello world !")
  (route/not-found "Error, page not found!"))

(defn -main
  "This is our main entry point"
  [& _]
  (let [port (Integer/parseInt (or (System/getenv "PORT") "3000"))]
    (flop.db.init/setup-all!)
    ; Run the server with Ring.defaults middleware
    (server/run-server (wrap-defaults #'app-routes site-defaults) {:port port})
    (println (str "Running webserver at http:/127.0.0.1:" port "/"))))
