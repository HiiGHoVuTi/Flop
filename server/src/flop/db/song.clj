(ns flop.db.song
  (:require [flop.db.util :as util]
            [flop.db.models :refer [Song]]
            [toucan.db :as db]
            [clojure.java.io :as io]
            [clj-fuzzy.metrics :refer [jaro]]
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
          (select-keys [:title :artist :album :year])
          (assoc :id (:id entry))))

; Note(Maxime): exact search

(defn to-json
  "turns a db ID into a json representation of the song"
  [id]
  (some-> Song (db/select-one :id id)
                db-song-to-json))

(defn criterion-as-json
  "returns a list of songs from disk according to a criterion"
  ([criterion n] (take n (criterion-as-json criterion)))  
  ([criterion]
  (transduce (comp (map db-song-to-json)
                   (filter criterion))
             merge []
             (db/select-reducible Song))))

(defn folder-to-json-vec
  "tries to list songs in a given folder"
  [folder]
  (if (.exists folder)
    (->> folder file-seq
             (map #(.getPath %))
             (filter #(.endsWith % "ogg"))
             (map #(db/select-one Song :path %))
             (map db-song-to-json)
             (into []))))

(defn album-as-json
  "returns a list of songs from a disk-album"
  [exact-name]
  (some->> (io/file util/music-path) file-seq
           (filter #(.endsWith (.getPath %) exact-name))
           first folder-to-json-vec))
  
(defn artist-as-json
  "returns a list of songs from a disk-artist"
  [exact-name]
  (folder-to-json-vec 
    (io/file (str util/music-path exact-name))))

; NOTE(Maxime): fuzzy search

(def fuzzy-score jaro)
(def fuzzy-threshold 0.65)

(defn fuzzy-search
  ([criterion n] (take n (fuzzy-search criterion)))
  ([criterion] 
  (->> (transduce (filter #(< fuzzy-threshold 
                                    (criterion %)))
                  merge []
                 (db/select-reducible Song))
        (sort-by criterion >))))

(defn find-song-json
  "tries to find a song from name and returns sorted results"
  ([fuzzy-name n] (take n (find-song-json fuzzy-name)))
  ([fuzzy-name] 
    (map db-song-to-json 
      (fuzzy-search
        #(fuzzy-score fuzzy-name (-> %1 :path util/path->song))))))

