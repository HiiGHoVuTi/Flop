(ns flop.db.song
  (:require [flop.db.util :as util]
            [flop.db.models :refer [Song]]
            [toucan.db :as db])
  (:gen-class))
  
(defn index!
  "Indexes a song in the database
  Creates a db entry {:path :id}"
  [path]
  (db/insert! Song {:path path}))
  
(defn index-all!
  "Calls `index!` on every single file in `util/music-folder`"
  []
  (let [files (util/list-dir util/music-path)
        file-entries (map #(assoc{} :path (.getPath %)) files)]
    (db/simple-insert-many! Song file-entries)))
