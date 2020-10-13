#lang racket

(require racket)
(require racket/gui)
(require plot)

(define (plot-animate
         max-t
         x-min
         x-max
         y-min
         y-max
         fn)

  (define f (new frame% [label "Test graph"]
                 [width 600]
                 [height 600]))

  (define c (new canvas% [parent f]
                 [min-height 500]))

  (define t 0)
  (define inc 0.5)

  (send f show #t)

  (define timer #f)

  (define (tock)
    (sleep/yield inc)
    (if (> t (+ max-t inc))
        (send timer stop)
        (plot/dc
         (parametric
          fn
          0
          t
          #:x-min x-min #:x-max x-max
          #:y-min y-min #:y-max y-max)
         (send c get-dc)
         0
         0
         (- (send f get-width) 40)
         (- (send f get-height) 40)))

    (set! t (+ t inc)))

  (define panel (new horizontal-panel% [parent f]
                     [alignment '(center center)]))

  (new button% [parent panel]
       [label "Start"]
       [callback (lambda (button event)
                   (set! timer (new timer% [notify-callback tock] [interval 5])))])
  (new button% [parent panel]
       [label "Stop"]
       [callback (lambda (button event)
                   (send timer stop))])
  #f)

;; x = t^{2} - 2t
;; y = t + 1

(plot-new-window? #t)

(define (line-fn x0 y0 x1 y1)
  (let ([m (/ (- y1 y0) (- x1 x0))])
    (lambda (x)
      (let ([res (+ y0 (* m (- x x0)))])
        res))))

(define (line-pt x0 y0 x1 y1 t)
  (let* ([line-fn (line-fn x0 y0 x1 y1)]
         [x (+ x0 (* t (- x1 x0)))])
    (list x (line-fn x))))


(plot
 (list (parametric
        (lambda (t)
          (let ([x0 4]
                [y0 1]
                [x1 28]
                [y1 48]
                [x2 50]
                [y2 42]
                [x3 40]
                [y3 5])
            (vector (+ (* x0 (expt (- 1 t) 3))
                       (* 3 x1 t (expt (- 1 t) 2))
                       (* 3 x2 (* t t) (expt (- 1 t) 1))
                       (* x3 (* t t t) (expt (- 1 t) 0)))
                    (+ (* y0 (expt (- 1 t) 3))
                       (* 3 y1 t (expt (- 1 t) 2))
                       (* 3 y2 (* t t) (expt (- 1 t) 1))
                       (* y3 (* t t t) (expt (- 1 t) 0))))))
        0
        1)
       (function
        (apply line-fn (flatten (list (line-pt 4 1 28 48 0.5)
                                      (line-pt 28 48 50 42 0.5))))
        #:color "orange")
       (function
        (apply line-fn (flatten (list (line-pt 28 48 50 42 0.5)
                                      (line-pt 50 42 40 5 0.5))))
        #:color "orange")
       (function
        (line-fn 27.5 34.5 42 34.25)
        #:color "red")
       (function
        (line-fn 4 1 28 48)
        #:color "blue")
       (function
        (line-fn 28 48 50 42)
        #:color "green")
       (function
        (line-fn 50 42 40 5)
        0 50
        #:color "black")))

(plot-animate
 2
 -120 50 -500 100
 (lambda (t)
   (let ([x0 4] [y0 1]
                [x1 28] [y1 48]
                [x2 50] [y2 42]
                [x3 40] [y3 5])
     (vector (+ (* x0 (expt (- 1 t) 3))
                (* 3 x1 t (expt (- 1 t) 2))
                (* 3 x2 (* t t) (expt (- 1 t) 1))
                (* x3 (* t t t) (expt (- 1 t) 0)))
             (+ (* y0 (expt (- 1 t) 3))
                (* 3 y1 t (expt (- 1 t) 2))
                (* 3 y2 (* t t) (expt (- 1 t) 1))
                (* y3 (* t t t) (expt (- 1 t) 0)))))))

(plot
 (parametric
  (lambda (t)
    (vector (- (sqr t) (* 2 t))
            (add1 t)))
  -2
  4))

(plot (parametric
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

(plot-animate
 (* 2 pi)
 0 10 0 10
 (lambda (t)
   (let ([h 5]
         [k 5]
         [r 2])
     (vector (+ h (* r (cos t)))
             (+ k (* r (sin t)))))))



(plot
 (parametric
  (lambda (t)
    (vector (+ t (sin (* 5 t)))
            (+ t (sin (* 6 t)))))
  0
  (* 4 pi))
 #:x-min 0 #:x-max 13
 #:y-min 0 #:y-max 13)

(plot-animate
 (* 4 pi)
 0 13 0 13
 (lambda (t)
   (vector (+ t (sin (* 5 t)))
           (+ t (sin (* 6 t))))))

(plot-animate
 (* 2 pi)
 -1 1 -1 1
 (lambda (t)
   (vector (sin (* 9 t))
           (sin (* 10 t)))))

(plot-animate
 (* 2 pi)
 -3.5 3.5 -3.5 3.5
 (lambda (t)
   (vector (+ (* 2.3 (cos (* 10 t))) (cos (* 23 t)))
           (- (* 2.3 (sin (* 10 t))) (sin (* 23 t))))))

(plot-animate
 (* 3 2 pi)
 0 (* 3 2 pi) 0 5
 (lambda (t)
   (let ([r 1])
     (vector (* r (- t (sin t)))
             (* r (- 1 (cos t)))))))

(plot (function
       (lambda (t)
         (+ 0 (* 2 t)))
       0 10))

(tangent-animate
 0 (* 3 2 pi)
 0 (* 3 2 pi) 0 5
 (lambda (t)
   (let ([r 1])
     (vector (* r (- t (sin t)))
             (* r (- 1 (cos t))))))
 (lambda (t)
   (if (= t 0)
       0
       (/ (sin t) (- 1 (cos t))))))

(tangent-animate
 (- (sqrt 5)) (+ (sqrt 5) 0.5)
 0 5 -4.5 4.5
 (lambda (t)
   (vector (* t t)
           (- (* t t t) (* 3 t))))
 (lambda (t)
   (* 1.5 (- t (/ 1 t)))))

(define (tangent-animate
         min-t
         max-t
         x-min
         x-max
         y-min
         y-max
         fn
         tan-fn)

  (define f (new frame% [label "Test graph"]
                 [width 600]
                 [height 600]))

  (define c (new canvas% [parent f]))

  (define t min-t)
  (define inc 0.5)

  (send f show #t)

  (define timer #f)

  (define (tock)
    (sleep/yield inc)
    (if (> t max-t)
        (send timer stop)
        (plot/dc
         (list (parametric
                fn
                min-t
                max-t
                #:x-min x-min #:x-max x-max
                #:y-min y-min #:y-max y-max)
               (let* ([m (tan-fn t)]
                      [res (fn t)]
                      [x (vector-ref res 0)]
                      [y (vector-ref res 1)]
                      [c (- y (* m x))])
                 (function
                  (lambda (x)
                    (let ([res (+ (* m x) c)])
                      (cond
                        [(> res y-max) y-max]
                        [(< res y-min) y-min]
                        [else res])))
                  #:color "blue")))
         (send c get-dc)
         0
         0
         (- (send f get-width) 40)
         (- (send f get-height) 40)))

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
