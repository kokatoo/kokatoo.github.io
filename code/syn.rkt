#lang racket

(require racket
         racket/gui
         plot
         plot/utils
         math)

(plot-new-window? #t)

(define (bs spot r vol t strike call?)
  (let* ([d1 (/ (+ (log (/ spot strike))
                   (* (+ r (/ (sqr vol) 2)) t))
                (* vol (sqrt t)))]
         [d2 (- d1 (* vol (sqrt t)))]
         )
    (if call?
        (- (* spot (cdf (normal-dist) d1))
           (* strike (exp (* (- r) t)) (cdf (normal-dist) d2)))
        (- (* strike (exp (* (- r) t)) (cdf (normal-dist) (- d2)))
           (* spot (cdf (normal-dist) (- d1)))))))

(define (bs2 t premium)
  (let* ([strike 15]
         [x-min 5]
         [x-max 25]
         [call-fn (lambda (spot)
                    (bs spot 0 0.1 t strike #t))]
         [put-fn (lambda (spot)
                   (* -1
                      (bs spot 0 0.1 t strike #f)))])
    (list
     (axes)
     (function (lambda (spot)
                 (- (call-fn spot)
                    premium))
               x-min x-max
               #:color 1
               #:y-min -10 #:y-max 10)
     (function
      (lambda (x)
        (if (< x strike)
            (- premium)
            (- x strike premium)))
      x-min x-max
      #:color 1)
     (function (lambda (spot)
                 (+ (put-fn spot)
                    premium))
               x-min x-max
               #:color 3)
     (function
      (lambda (x)
        (if (> x strike)
            (+ premium)
            (+ x (- strike) (+ premium))))
      x-min x-max
      #:color 3)
     (function (lambda (spot)
                 (+ (put-fn spot)
                    (call-fn spot)))
               x-min x-max
               #:color 2))))
(animate-options
 bs2)

(define (animate-options
         fn)

  (define f (new frame%
                 [label "Test graph"]
                 [width 600]
                 [height 800]))
  (define c1 (new canvas%
                  [parent f]))

  (define max-t 5)
  (define premium
    2)

  (define t max-t)
  (define inc 2)

  (send f show #t)

  (define timer #f)

  (define (tock)
    (display t)
    (newline)
    (display inc)
    (newline)
    (newline)
    (sleep/yield 0.1)
    (if (< t 0.01)
        (send timer stop)
        (plot/dc
         (fn t premium)
         (send c1 get-dc)
         0
         0
         (- (send f get-width) 40)
         (- (send f get-height) 40)
                  ))
    (set! t (- t inc))
    (cond
      [(<= t 0.01) (set! inc 0.005)]
      [(<= t 0.02) (set! inc 0.005)]
      [(<= t 0.03) (set! inc 0.01)]
      [(<= t 0.1) (set! inc 0.05)]
      [(<= t 0.2) (set! inc 0.1)]
      [(<= t 0.5) (set! inc 0.3)]
      [(<= t 1) (set! inc 0.5)]))

  (new button% [parent f]
       [label "Start"]
       [callback (lambda (button event)
                   (set! timer (new timer% [notify-callback tock] [interval 10])))])
  (new button% [parent f]
       [label "Stop"]
       [callback (lambda (button event)
                   (send timer stop))])
  #f)

(animate-options
 bs2)
