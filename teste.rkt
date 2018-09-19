#lang racket
(require db)
(define sl3c
  (sqlite3-connect
   #:database "/home/willian/racket_db.db"
   )
  )
;(query-rows sl3c "select * from questionarios");