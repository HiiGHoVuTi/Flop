(ns flop.db.song
  (:require [flop.db.util :as util]
            [flop.db.models :refer [Song]]
            [toucan.db :as db]
            [green-tags.core :as gt])
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
    (->> file-entries
      (filter #(.endsWith (:path %) "ogg")) 
      (db/simple-insert-many! Song))))

(defn db-song-to-json
  "turns a song db entry {:path} into json"
  [entry]
  (some-> entry 
          :path gt/get-all-info
          (select-keys [:title :artist :album :year])))

(defn to-json
  "turns a db ID into a json representation of the song"
  [id]
  (some-> Song (db/select-one :id id)
                db-song-to-json))

(defn criterion-as-json
  "returns a list of songs from disk according to a criterion"
  [criterion exact-value]
  (transduce (comp (map db-song-to-json)
                   (filter #(= exact-value (criterion %))))
             merge []
             (db/select-reducible Song)))

(defn album-as-json
  "returns a list of songs from a disk-album"
  [exact-name]
  (criterion-as-json :album exact-name))
  
(defn artist-as-json
  "returns a list of songs from a disk-artist"
  [exact-name]
  (criterion-as-json :artist exact-name))
