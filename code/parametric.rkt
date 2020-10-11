#lang racket

(require racket)
(require plot)
(require racket/draw)

;; x = t^{2} - 2t
;; y = t + 1

(plot-new-window? #t)

(plot
 (parametric
  (lambda (t)
    (vector (- (sqr t) (* 2 t))
            (add1 t)))
  -2
  4))

(plot
 (parametric
  (lambda (t)
    (vector (cos t)
            (sin t)))
  0
  (* 2 pi)))

(plot
 (parametric
  (lambda (t)
    (vector (cos (* 2 t))
            (sin (* 2 t))))
  0
  (* 2 pi)))

(plot
 (parametric
  (lambda (t)
    (let ([h 5]
          [k 5]
          [r 2])
      (vector (+ h (* r (cos t)))
              (+ k (* r (sin t))))))
  0
  (* 2 pi))
 #:x-min 0 #:x-max 10
 #:y-min 0 #:y-max 10)

(require racket racket/gui plot)

(define (ex)

  (define f (new frame% [label "Test graph"]
                 [width 600]
                 [height 600]))

  (define c (new canvas% [parent f]))

  (define num 0)

  (send f show #t)

  (define (tock)
    (let ([t (/ num 30)])
      (plot/dc (parametric
                (lambda (t)
                  (let ([h 5]
                        [k 5]
                        [r 2])
                    (vector (+ h (* r (cos t)))
                            (+ k (* r (sin t))))))
                0
                t
                #:x-min 0 #:x-max 10
                #:y-min 0 #:y-max 10)
               (send c get-dc)
               0 0
               (- (send f get-width) 40) ;; figure out how to get the actual size of the text outside the graphs boarder?
               (- (send f get-height) 40)
               ))

    (set! num (add1 num)))
  (new button% [parent f]
       [label "Click Me"]
       [callback (lambda (button event)
                   (define timer (new timer% [notify-callback tock] [interval 5]))
                   #f
                   )])
  #f)
(ex)
