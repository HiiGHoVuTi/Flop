(ns flop.stream
  (:require [toucan.db :as db]
            [flop.db.models :refer [Song]]
            [green-tags.core :as gt]
            [clojure.java.io :as io])
  (:gen-class))

(defn stream-song [id]
  (if-let [song (db/select-one Song :id id)]
    {:status 200
     :headers {"Content-type" "audio/ogg"
               "Content-Disposition" (str "inline; filename=\"song.ogg\"")}
     :body (io/file (:path song))}))

(defn stream-image [id]
  (if-let [song (db/select-one Song :id id)]
    {:status 200
     :headers {"Content-type" "image/jpeg"
               "Content-Disposition" (str "inline; filename=\"album.jpeg\"")}
     :body (io/input-stream 
              (-> song :path
                  gt/get-all-info :artwork-data))}))
