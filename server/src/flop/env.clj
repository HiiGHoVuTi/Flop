(ns flop.env
	(:require [clojure.edn :as edn])
	(:gen-class))
	
(defn get-
	"gets a value from the `env.edn` file"
	[property]
	(-> "env.edn" slurp edn/read-string property))
