(ns flop.db.init
  (:require [clojure.string]
            [toucan.db :as db]
            [toucan.models :as models]
            [clojure.java.jdbc :as jdbc]
            [flop.db.song :as song]
            [flop.db.models :refer [User]])
  (:gen-class))

(defn connect! 
  "Connects to the database using the environment variables"
  []
  (db/set-default-db-connection!
    {:classname "org.postgresql.Driver"
     :subprotocol "postgresql"
     :subname "//localhost:5432/flop"
     :user "flop"
     :password (or (System/getenv "DB_PASSWORD") "ohsosecret")}))

(defn setup-models! []
  (models/set-root-namespace! 'flop.db.models))

(defn create-dummy-users! []
  (jdbc/execute! (db/connection)  
    (jdbc/create-table-ddl "users"
      [[:id :uuid :primary :key :default "uuid_generate_v4 ()"]
       [:name "varchar(32)"]]
      {:conditional? true}))
  (db/insert! User {:name "Maxime"}))

(defn create-dummy-data! []
  ; need this extension for uuid
  (jdbc/execute! (db/connection) 
    "CREATE EXTENSION IF NOT EXISTS \"uuid-oosp\"")
  ; create the table for songs
  (jdbc/execute! (db/connection)
    (jdbc/create-table-ddl "songs"
      [[:id :serial :primary :key]
       [:path "varchar(256)"]]
      {:contitional? true}))
  (create-dummy-users!))

(defn setup-all!
  "Connects to the database and creates required data models"
  []
  (connect!)
  (setup-models!))

(defn first-setup!
  "This function creates the databases
  It should only be ran once on the server machine"
  []
  (setup-all!)
  (create-dummy-data!)
  (song/index-all!))