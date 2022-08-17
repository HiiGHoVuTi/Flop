(ns flop.db.util
	(:require [clojure.java.io :as io]
						[clojure.string]
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
	
(defn analyse-path
	"turns a path into [artist album song]"
	[path]
	(-> path (clojure.string/replace music-path "")
					 (clojure.string/replace ".ogg" "")
					 (clojure.string/split #"/")))

(defn path->song [path]
	(let [[_ _ song] (analyse-path path)] song))
(defn path->artist [path]
  (let [[artist _ _] (analyse-path path)] artist))
(defn path->album [path]
  (let [[_ album _] (analyse-path path)] album))

