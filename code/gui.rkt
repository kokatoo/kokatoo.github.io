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


(define f (new frame% [label "Simple Edit"]
               [width 200]
               [height 200]))
(define c (new editor-canvas% [parent f]))
(define t (new text%))

(define append-only-text%
  (class text%
    (inherit last-position)
    (define/augment (can-insert? s l)
      (display s)
      (newline)
      (display l)
      (newline)
      (= s (last-position)))
    (define/augment (can-delete? s l) #f)
    (super-new)))
(define t (new append-only-text%))

(send c set-editor t)
(send f show #t)

(define mb (new menu-bar% [parent f]))
(define m-edit (new menu% [label "Edit"] [parent mb]))
(define m-font (new menu% [label "Font"] [parent mb]))
(append-editor-operation-menu-items m-edit #f)
(append-editor-font-menu-items m-font)
(send t set-max-undo-history 100)

(send t find-snip 0 'after)

(define pb (new pasteboard%))
(send c set-editor pb)

(define s (make-object editor-snip% t))
(send pb insert s)
(send pb insert (send s copy))

(require racket/class
         racket/snip
         racket/format)

(provide circle-snip%
         (rename-out [circle-snip-class snip-class]))

(define circle-snip%
  (class snip%
    (inherit set-snipclass
             get-flags set-flags
             get-admin)
    (init-field [size 20.0])

    (super-new)
    (set-snipclass circle-snip-class)
    (send (get-the-snip-class-list) add circle-snip-class)
    (set-flags (cons 'handles-events (get-flags)))

    (define/override (get-extent dc x y
                                 [w #f]
                                 [h #f]
                                 [descent #f]
                                 [space #f]
                                 [lspace #f]
                                 [rspace #f])
      (define (maybe-set-box! b v) (when b (set-box! b v)))
      (maybe-set-box! w (+ 2.0 size))
      (maybe-set-box! h (+ 2.0 size))
      (maybe-set-box! descent 1.0)
      (maybe-set-box! space 1.0)
      (maybe-set-box! lspace 1.0)
      (maybe-set-box! rspace 1.0))

    (define/override (draw dc x y left top right bottom dx dy draw-caret)
      (send dc draw-ellipse (+ x 1.0) (+ y 1.0) size size))

    (define/override (copy)
      (new circle-snip% [size size]))

    (define/override (write f)
      (send f put size))

    (define/override (on-event dc x y editorx editory e)
      (when (send e button-down?)
        (set! size (+ 1.0 size))
        (define admin (get-admin))
        (when admin
          (send admin resized this #t))))))

(define circle-snip-class%
  (class snip-class%
    (inherit set-classname)

    (super-new)
    (set-classname (~s '((lib "main.rkt" "circle-snip")
                         (lib "wxme-circle-snip.rkt" "circle-snip"))))

    (define/override (read f)
      (define size-b (box 0.0))
      (send f get size-b)
      (new circle-snip% [size (unbox size-b)]))))

(define circle-snip-class (new circle-snip-class%))
