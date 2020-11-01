#lang racket

(require racket
         racket/gui
         plot
         plot/utils
         math)

(plot-new-window? #t)

(define (d1 spot vol t atm r)
  (let ([t (if (<= t 0) 0.000001 t)])
    (/ (+ (log (/ spot atm))
          (* (+ r (/ (sqr vol) 2)) t))
       (* vol (sqrt t)))))

(define (d1 spot vol t atm r)
  (/ (+ (log (/ spot atm))
        (* (+ r (/ (sqr vol) 2)) t))
     (* vol (sqrt t))))

(define (delta spot vol t atm call?)
  (let ([d1 (d1 spot vol t atm 0)])
    (if call?
        (cdf (normal-dist) d1)
        (- (cdf (normal-dist) (- d1))))))

(define (bs spot vol t atm call?)
  (let* ([r 0]
         [d1 (d1 spot vol t atm r)]
         [d2 (- d1 (* vol (sqrt t)))])
    (if call?
        (- (* spot (cdf (normal-dist) d1))
           (* atm (exp (* (- r) t)) (cdf (normal-dist) d2)))
        (- (* atm (exp (* (- r) t)) (cdf (normal-dist) (- d2)))
           (* spot (cdf (normal-dist) (- d1)))))))

(define (init-bs price call?)
  (let* ([t 0.5]
         [atm 15]
         [x-min 5]
         [x-max 25]
         [call-fn (lambda (spot)
                    (bs spot 0.3 t atm #t))]
         [put-fn (lambda (spot)
                   (* -1
                      (bs spot 0.3 t atm #f)))]
         [m (delta price 0.3 t atm call?)]
         [y (if call?
                (call-fn price)
                (put-fn price))
            ]
         [c (- y (* m price))])
    (list
     (axes)
     (function-label (lambda (x) 4)
                     10
                     (string-append "Delta: " (real->decimal-string m 2))
                     #:point-sym 'none)
     (function-label (lambda (x) 5)
                     10
                     (string-append "Price: " (number->string price))
                     #:point-sym 'none)
     (function-label (lambda (x) 6)
                     10
                     (string-append "ATM Strike: " "15")
                     #:point-sym 'none)
     (function (lambda (spot)
                 (if call?
                     (call-fn spot)
                     (put-fn spot)))
               x-min x-max
               #:color 1
               #:y-min -10 #:y-max 10
               #:label "Option"
               )
     (function (lambda (x)
                 (let ([res (+ (* m x) c)])
                   (if (< res -10)
                       +nan.0
                       res)))
               x-min x-max
               #:color 3
               #:y-min -10 #:y-max 10
               #:label "Delta"))))

(define (option-underlying t call?)
  (let* ([atm 15]
         [x-min 11]
         [x-max 19]
         [y-min (if call? 0 -1)]
         [y-max (if call? 1 0)]
         [call-fn (lambda (spot)
                    (bs spot 0.3 t atm #t))]
         [put-fn (lambda (spot)
                   (* -1
                      (bs spot 0.3 t atm #f)))])
    (list
     (axes)
     (function (lambda (spot)
                 (if call?
                     (delta spot 0.1 t atm call?)
                     (delta spot 0.1 t atm call?)))
               x-min x-max
               #:color 1
               #:y-min y-min #:y-max y-max)
     (function (lambda (spot)
                 (if call?
                     (delta spot 0.1 0.000001 atm call?)
                     (delta spot 0.1 0.000001 atm call?)))
               x-min x-max
               #:color 3
               #:y-min y-min #:y-max y-max)
     (function-label (lambda (x)
                       (if call?
                           0.8
                           -0.2))
                     12
                     (string-append "T = " (real->decimal-string t 3))
                     #:point-sym 'none))))
(animate-options
 option-underlying)

(plot3d (surface3d
         (lambda (spot vol)
           (delta spot vol t atm call?))
         11 19 0.05 1
         #:color 3)
        #:x-label "Underlying"
        #:y-label "T"
        #:z-label "Delta")

(let ([atm 15]
      [call? #f])
  (plot3d (surface3d
           (lambda (spot t)
             (delta spot 0.1 t atm call?))
           11 19 0.00001 1
           #:color 3)
          #:x-label "Underlying"
          #:y-label "T"
          #:z-label "Delta"
          ))


(let ([x-min 11]
      [x-max 19]
      [atm 15]
      [call? #f]
      [y-min -1]
      [y-max 0])
  (plot (list
         (axes)
         (function (lambda (spot)
                     (delta spot 0.1 0.5 atm call?))
                   x-min x-max
                   #:color 1
                   #:y-min y-min #:y-max y-max
                   #:label "T = 0.5")
         (function (lambda (spot)
                     (delta spot 0.1 0.1 atm call?))
                   x-min x-max
                   #:color 2
                   #:y-min y-min #:y-max y-max
                   #:label "T = 0.1")
         (function (lambda (spot)
                     (delta spot 0.1 0.01 atm call?))
                   x-min x-max
                   #:color 3
                   #:y-min y-min #:y-max y-max
                   #:label "T = 0.01")
         (function (lambda (spot)
                     (delta spot 0.1 0.000001 atm call?))
                   x-min x-max
                   #:color 0
                   #:y-min y-min #:y-max y-max
                   #:label "T = 0"))
        #:x-label "Underlying Price"
        #:y-label "Delta"))

(define (animate-options
         fn)

  (define f (new frame%
                 [label "Test graph"]
                 [width 600]
                 [height 800]))
  (define c1 (new canvas%
                  [parent f]))

  (define price 5)
  (define max-price 25)
  (define inc 1)

  (define t 1)
  (define t-inc 0.1)

  (send f show #t)

  (define timer #f)

  (define (tock)

    (cond [(<= t 0.011)
           (set! t-inc 0.001)]
          [(<= t 0.11)
           (set! t-inc 0.01)])

    (display t)
    (newline)
    (display t-inc)
    (newline)

    (sleep/yield 0.1)
    ;(> price max-price)
    (if (< t 0)
        (send timer stop)
        (plot/dc
         (fn t #f)
         (send c1 get-dc)
         0
         0
         (- (send f get-width) 40)
         (- (send f get-height) 60)
         #:title ""
         #:x-label "Underlying Price"
         #:y-label "Delta"))
    (set! price (+ price inc))
    (set! t (- t t-inc)))

  (new button% [parent f]
       [label "Start"]
       [callback (lambda (button event)
                   (set! timer (new timer% [notify-callback tock] [interval 100])))])
  (new button% [parent f]
       [label "Stop"]
       [callback (lambda (button event)
                   (send timer stop))])
  #f)
(animate-options
 option-underlying)

(define (animate3D
         fn)

  (define f (new frame%
                 [label "Test graph"]
                 [width 600]
                 [height 800]))
  (define c1 (new canvas%
                  [parent f]))

  (define price 5)
  (define max-price 25)
  (define inc 1)

  (define t 1)
  (define t-inc 0.1)

  (send f show #t)

  (define timer #f)

  (define (tock)

    (cond [(<= t 0.011)
           (set! t-inc 0.001)]
          [(<= t 0.11)
           (set! t-inc 0.01)])

    (display t)
    (newline)
    (display t-inc)
    (newline)

    (sleep/yield 0.1)
    ;(> price max-price)
    (if (< t 0)
        (send timer stop)
        (plot3d/dc
         (fn t #t)
         (send c1 get-dc)
         0
         0
         (- (send f get-width) 40)
         (- (send f get-height) 60)
         #:x-label "Underlying"
         #:y-label "Volatility"
         #:z-label "Delta"
         #:angle 57
         #:altitude 20))
    (set! price (+ price inc))
    (set! t (- t t-inc)))

  (new button% [parent f]
       [label "Start"]
       [callback (lambda (button event)
                   (set! timer (new timer% [notify-callback tock] [interval 3000])))])
  (new button% [parent f]
       [label "Stop"]
       [callback (lambda (button event)
                   (send timer stop))])
  #f)

(animate3D
 vol-delta)

(define (vol-delta t call?)
  (let ([atm 15])
    (surface3d
     (lambda (spot vol)
       (delta spot vol t atm call?))
     11 19 0.05 1
     #:color 3
     #:label (string-append "T = " (real->decimal-string t 3)))))

(let ([atm 15]
      [call? #t])
  (plot3d (surface3d
           (lambda (spot t)
             (delta spot 0.1 t atm call?))
           11 19 0.00001 1
           #:color 3)
          #:x-label "Underlying"
          #:y-label "T"
          #:z-label "Delta"))


(let ([x-min 11]
      [x-max 19]
      [atm 15]
      [call? #f])
  (plot (list
         (axes)
         (function (lambda (vol)
                     (delta 10 1 vol atm call?))
                   0.0000001 1
                   #:color 0
                   #:y-min 0 #:y-max 1
                   #:label "T = 0"))
        #:x-label "Underlying Price"
        #:y-label "Delta"))

(let ([atm 15]
      [call? #t]
      [t 1])
  (plot3d
   (surface3d
    (lambda (spot vol)
      (delta spot vol t atm call?))
           11 19 0.05 1
           #:color 3
           #:label (string-append "T = " (real->decimal-string t 2)))
   #:x-label "Underlying"
   #:y-label "Vol"
   #:z-label "Delta"
   #:angle 57
   #:altitude 20))
