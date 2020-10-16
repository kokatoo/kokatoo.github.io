#lang racket

(require racket
         racket/gui
         plot
         plot/utils)

(polar->cartesian 1 1)

(plot-new-window? #t)

(plot (parametric
       (lambda (theta)
         (polar->cartesian theta 2)) 0 (* 2 pi)))


(plot (parametric
       (lambda (r)
         (polar->cartesian 1 r)) -2 1)
      #:x-min -1.5 #:x-max 0.5)

(plot (parametric
       (lambda (r)
         (polar->cartesian (/ pi 2) r)) -2 1
       #:x-min -1 #:x-max 1))

(plot (parametric
       (lambda (theta)
         (polar->cartesian theta (* 2 (cos theta))))
       0
       (* 2 pi)))

(plot (parametric
       (lambda (theta)
         (polar->cartesian theta (+ 1 (sin theta))))
       0
       (* 2 pi)))

(define (ex)
  (define f (new frame% [label "Test graph"]
                 [width 600]
                 [height 800]))

  (define c1 (new canvas% [parent f]
                  [min-height 300]))

  (define c2 (new canvas% [parent f]
                  [min-height 300]))


  (send f show #t)

  (define panel (new horizontal-panel% [parent f]
                     [alignment '(center center)]))
  (new button% [parent panel]
       [label "Start"]
       [callback (lambda (button event)
                   #f)])
  (new button% [parent panel]
       [label "Stop"]
       [callback (lambda (button event)
                   #f)])
  #f)
(ex)
