(ns flop.db.playlist
  (:require [toucan.db :as db]
            [flop.db.song :as song]
						[flop.db.models :refer [Playlist Song-in-Playlist]])
  (:gen-class))

(defn get-json
  "reads a playlist from the database, by id"
  [id]
  (db/select-one Playlist {:id id}))

(defn list-json
  "reads all songs from a playlist in the database, by id"
  [id]
  (->> {:playlist_id id}
       (db/select Song-in-Playlist)
       (map (comp song/to-json :song_id))))

(defn create!
  "adds a playlist to the database"
  [name]
  (db/insert! Playlist {:name name}))

(defn add-song!
  "adds a song to a playlist, by id"
  [playlist song]
  (comment "maybe check if playlist and song exist")
  (db/insert! Song-in-Playlist 
    {:song_id song :playlist_id playlist}))

(defn remove-song!
  "removes a song from a playlist, by id"
  [playlist song]
  (db/delete! Song-in-Playlist
    {:song_id song :playlist_id playlist}))

