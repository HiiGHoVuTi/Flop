(ns flop.db.util
	(:require [clojure.java.io :as io]
            [flop.env :as env])
  (:gen-class))

(def music-path (or (env/get- :music-folder) "./SONGS/"))

(defn list-dir
  "lazily and recursively lists all *files* in a directory
  this does not include the directory themselves"
  [path]
  (->> path io/file file-seq
      (filter (memfn isFile))))

(defn list-dir'
	"eagerly lists all subfolders and files non-recursively"
	[path]
	(->> path io/file .list (into [])))