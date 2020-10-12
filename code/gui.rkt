#lang racket

(require racket
         racket/gui)

(define frame (new frame% [label "Example"]))

(define msg (new message% [parent frame]
                 [label "No events so far..."]))

(new button% [parent frame]
     [label "Click Me"]
     [callback (lambda (button event)
                 (send msg set-label "Button click"))])

(define my-canvas%
  (class canvas%

    (define/override (on-event event)
      (send msg set-label "Canvas mouse"))

    (define/override (on-char event)
      (send msg set-label "Canvas keyboard"))

    (super-new)))

(new my-canvas% [parent frame])

(new button% [parent frame]
     [label "Pause"]
     [callback (lambda (button event) (sleep 5))])

(define panel (new horizontal-panel% [parent frame]))

(new button% [parent panel]
     [label "Left"]
     [callback (lambda (button event)
                 (send msg set-label "Left click"))])
(new button% [parent panel]
     [label "Right"]
     [callback (lambda (button event)
                 (send msg set-label "Right click"))])


(send frame show #t)

(define frame (new frame%
                   [label "Example"]
                   [width 300]
                   [height 300]))

(new canvas% [parent frame]
     [paint-callback
      (lambda (canvas dc)
        (send dc set-scale 3 3)
        (send dc set-text-foreground "blue")
        (send dc draw-text "Don't Panic!" 0 0))])
(send frame show #t)
