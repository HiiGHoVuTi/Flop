; This file is cursed by the linter
; it reports missing symbols but the code works just fine

(ns flop.db.models
  (:require [toucan.models :refer [defmodel IModel default-fields]])
  (:gen-class))

(defmodel User :users
  IModel
  (default-fields [_]
    [:name]))

(defmodel Song :songs
  IModel
  (default-fields [_]
    [:id :path]))