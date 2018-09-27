#lang racket/gui

(require racket/struct)
(require db)
(define conn
  (sqlite3-connect
   #:database "/home/willian/Documentos/Personal/crequests/dados/racket_db.db"
   )
  )
;(query-rows conn "select * from questionarios");
;Definições das telas
(define main (new frame% [label "Crequests"] [width 400] [height 200] [x 600] [y 300]))
(define alert (new frame% [label "Crequests - Alerta"] [width 200] [height 200] [x 600] [y 300]))
(define create_perguntas (new frame% [label "Crequests - Perguntas"] [width 700] [height 500] [x 500] [y 180]))
(define create_questionarios (new frame% [label "Crequests - Questionários"] [width 700] [height 500] [x 500] [y 180]))
(define solve_questionarios (new frame% [label "Crequests - Resolver"] [width 700] [height 500] [x 500] [y 180]))

;Função que salva a pergunta e as respostas
(define save_pergunta 
  (lambda (lista)
    (print lista)
     (define result_save_pergunta (query conn "INSERT INTO perguntas VALUES (null, $pergunta, $ra, $rb, $rc, $rd, $re, $correta)" 
                                         (list-ref lista 0) (list-ref lista 1) (list-ref lista 2) (list-ref lista 3) (list-ref lista 4) (list-ref lista 5) (list-ref lista 6)))
     (printf "\nPergunta Cadastrada!\n")
     (send create_perguntas show #f)
     (send alert show #t)
    )) 

;Design do Alert
(define header_alert (new message%
                     (parent alert)
                     (label "Cadastro realizado com sucesso!")))
   
(new button% [parent alert]
             [label "OK"]
             [callback (lambda (button event)
                         (send alert show #f))])

;Design da Main
(new button% [parent main]
             [label "Criar Perguntas"]
             [min-width 300]
             [min-height 50]
             [vert-margin 10]
             [callback (lambda (button event)
                         (send create_perguntas show #t))])

(new button% [parent main]
             [label "Criar Questionários"]
             [min-width 300]
             [min-height 50]
             [vert-margin 10]
             [callback (lambda (button event)
                         (send create_questionarios show #t))])

(new button% [parent main]
             [label "Reponder Questionários"]
             [min-width 300]
             [min-height 50]
             [vert-margin 10]
             [callback (lambda (button event)
                         (send solve_questionarios show #t))])
 
(send main show #t)

;Design da tela de criação de perguntas
(define header (new message%
                     (parent create_perguntas)
                     (label "Criação de novas perguntas")))

(define pergunta (new text-field%
                        (label "Pergunta: ")
                        (parent create_perguntas)))

(define body (new message%
                     (parent create_perguntas)
                     (label "Respostas")))

(define resposta_01 (new text-field%
                        (label "Resposta 01: ")
                        (parent create_perguntas)))

(define resposta_02 (new text-field%
                        (label "Resposta 02: ")
                        (parent create_perguntas)))

(define resposta_03 (new text-field%
                        (label "Resposta 03: ")
                        (parent create_perguntas)))

(define resposta_04 (new text-field%
                        (label "Resposta 04: ")
                        (parent create_perguntas)))

(define resposta_05 (new text-field%
                        (label "Resposta 05: ")
                        (parent create_perguntas)))

(define resposta_correta (new radio-box%
                       (label "Resposta Correta:")
                       (parent create_perguntas)
                       (choices (list "Resposta 01"
                                      "Resposta 02"
                                      "Resposta 03"
                                      "Resposta 04"
                                      "Resposta 05"))))

(new button% [parent create_perguntas]
             [label "Enviar"]
             [callback (lambda (button event)
                       (save_pergunta (list (send pergunta get-value) (send resposta_01 get-value) (send resposta_02 get-value) (send resposta_03 get-value)
                                       (send resposta_04 get-value) (send resposta_05 get-value) (send resposta_correta get-selection))))])

