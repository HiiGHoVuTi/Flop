(ns flop.core
  (:require [flop.env :as env] [flop.util :as util]
            [org.httpkit.server :as server]
            [clojure.data.json :as json]
            [compojure.core :refer [defroutes GET POST]]
            [compojure.route :as route]
            [compojure.coercions :refer [as-int]]
            [ring.util.response :refer [not-found]]
            [ring.middleware.defaults :refer [wrap-defaults api-defaults]]
            [flop.db.init] [flop.db.song])
  (:gen-class))

    
(defroutes app-routes
  (GET "/" [] "hello world !")
  (GET "/song-info/:id" [id :<< as-int]
    (if-let [data (flop.db.song/to-json id)]
      (json/write-str data)
      (not-found "No song with this id")))
  (GET "/song-search/" req
    (if-let [data (flop.db.song/find-song-json (util/body-as-text req))]
      (json/write-str data)
      (not-found "How did you query something so wrong ?")))
  (GET "/artist/" req
    (if-let [data (flop.db.song/artist-as-json (util/body-as-text req))]
      (json/write-str data)
      (not-found "No artist with this exact name")))
  (GET "/album/" req
    (if-let [data (flop.db.song/album-as-json (util/body-as-text req))]
      (json/write-str data)
      (not-found "No album with this exact name")))
  (POST "/import-song/" req 
    (let [query (util/body-as-text req)]
      (flop.db.song/import-external! query)))
  (route/not-found "Error, page not found!"))

(defn -main
  "This is our main entry point"
  [& _]
  (let [port (or (env/get- :port) 3000)]
    (flop.db.init/setup-all!)
    ; Run the server with Ring.defaults middleware
    (server/run-server (wrap-defaults #'app-routes api-defaults) {:port port})
    (println (str "Running webserver at http:/127.0.0.1:" port "/"))))
