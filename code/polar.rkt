#lang racket

(require racket
         racket/gui
         plot
         plot/utils)

(plot (function
       (lambda (x)
         (tan x))
       (- (* 3/2 pi)) (* 3/2 pi))
      #:y-min -5 #:y-max 5)

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
       (* 2 pi))
      #:y-label "r"
      #:x-label "θ")

(plot (parametric
       (lambda (theta)
         (polar->cartesian theta (sin (* 2 theta))))
       0
       (* 2 pi)))


(parameterize ([plot-title ""])
  (plot (list (axes)
              (parametric
               (lambda (theta)
                 (polar->cartesian theta (sqrt (sin (* 2 theta)))))
               0
               (/ pi 2))
              (parametric
               (lambda (theta)
                 (polar->cartesian theta (- (sqrt (sin (* 2 theta))))))
               0
               (/ pi 2)))
        #:x-min -1.1 #:x-max 1.1
        #:y-min -1.1 #:y-max 1.1))

(define (plot-animate
         max-t
         fn1
         fn2)

  (define f (new frame%
                 [label "Test graph"]
                 [width 600]
                 [height 800]))
  (define c1 (new canvas%
                  [parent f]))

  (define c2 (new canvas%
                  [parent f]))

  (define t 0)
  (define inc 0.5)

  (send f show #t)

  (define timer #f)

  (define (tock)
    (sleep/yield inc)
    (if (> t (+ max-t inc))
        (send timer stop)
        (begin
          (plot/dc
           (parametric
            fn1
            0
            t)
           (send c1 get-dc)
           0
           0
           (- (send f get-width) 40)
           #:x-min -1 #:x-max 1
           #:y-min -1 #:y-max 1
           350)
          (plot/dc
           (function
            fn2
            0
            t
            #:color 3)
           (send c2 get-dc)
           0
           0
           (- (send f get-width) 40)
           #:x-min 0 #:x-max max-t
           #:y-min -1 #:y-max 1
           #:y-label "r"
           #:x-label "θ"
           350))
        )

    (set! t (+ t inc)))

  (new button% [parent f]
       [label "Start"]
       [callback (lambda (button event)
                   (set! timer (new timer% [notify-callback tock] [interval 5])))])
  (new button% [parent f]
       [label "Stop"]
       [callback (lambda (button event)
                   (send timer stop))])
  #f)

(plot-animate
 (* 2 2 pi)
 (lambda (theta)
   (polar->cartesian theta (+ (expt (sin (* 2.5 theta)) 3)
                              (expt (cos (* 2.5 theta)) 3))))
 (lambda (theta)
   (+ (expt (sin (* 2.5 theta)) 3)
      (expt (cos (* 2.5 theta)) 3))))

(define (plot-ex
         max-t
         fn1
         fn2)

  (define f (new frame%
                 [label "Test graph"]
                 [width 600]
                 [height 800]))
  (define c1 (new snip-canvas%
                  [parent f]
                  [min-height 350]
                  [paint-callback
                   (lambda (can dc)
                     (plot/dc
                      (parametric
                       fn1
                       0
                       max-t)
                      dc
                      0
                      0
                      (- (send f get-width) 40)
                      #:x-min -1 #:x-max 1
                      #:y-min -1 #:y-max 1
                      350))]))

  (define c2 (new canvas%
                  [parent f]
                  [min-height 350]
                  [paint-callback
                   (lambda (can dc)
                     (plot/dc
                      (function
                       fn2
                       0
                       max-t)
                      dc
                      0
                      0
                      (- (send f get-width) 40)
                      #:x-min 0 #:x-max (* 2 pi)
                      #:y-min -1 #:y-max 1
                      350))]))

  (send c1 on-event )
  (send f show #t)
  #f)

(plot-ex
 (* 2 pi)
 (lambda (theta)
   (polar->cartesian theta (cos (* 2 theta))))
 (lambda (theta)
   (cos (* 2 theta))))




