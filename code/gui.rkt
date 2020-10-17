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



(define frame (new frame%
                   [label "Example"]
                   [width 300]
                   [height 300]))
(define panel (new horizontal-panel% [parent frame]))
(define editor-canvas (new editor-canvas%
                           (parent panel)
                           (label "Editor Canvas")))
(define text (new text%))
(send text insert "Editor Canvas")
(send editor-canvas set-editor text)
(send frame show #t)

(define gauge (new gauge%
                   (label "Gauge")
                   (parent panel)
                   (range 100)))
(send gauge set-value 42)

(define group-box-panel (new group-box-panel%
                             (parent panel)
                             (label "Group Box Panel")))

(send frame show #t)

(define menu-bar (new menu-bar%
                      (parent frame)))
(new menu%
     (label "&File")
     (parent menu-bar))
(new menu%
     (label "&Edit")
     (parent menu-bar))
(new menu%
     (label "&Help")
     (parent menu-bar))

(define a-panel (new panel%
                     (parent panel)
                     ))
(new message%
     (parent a-panel)
     (label "Panel"))
(send frame show #t)

(define slider (new slider%
                    (label "Slider")
                    (parent panel)
                    (min-value 0)
                    (max-value 100)
                    (init-value 42)))

(send frame fullscreen #f)
(send frame get-menu-bar)
(send frame has-status-line?)
