#!/usr/bin/env bb

(ns day01.main
  (:require [clojure.string :as str]))

(def input (slurp "input.txt"))

(def data (->>
           (str/split input #"\n")
           (map #(as-> % entry
                   (str/split entry #"\s+")
                   (map Integer/parseInt entry)))))

(defn part1 []
  (reduce + (map (comp abs -) (sort (map first data)) (sort (map second data)))))

(println "Part 1:" (part1))
