(ns flop.util
  (:require [clojure.java.io :as io]
            [clojure.string :as s])
  (:gen-class))

(defn stream-bytes [is]
  (let [baos (java.io.ByteArrayOutputStream.)]
    (io/copy is baos)
    (.toByteArray baos)))

(defn body-as-text [req]
  (-> req :body stream-bytes String.))

(defn body-as-pair [req]
  (-> req body-as-text s/split-lines))