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

  (define c (new canvas% [parent f]))

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

  (new button% [parent f]
       [label "Start"]
       [callback (lambda (button event)
                   (set! timer (new timer% [notify-callback tock] [interval 5])))])
  (new button% [parent f]
       [label "Stop"]
       [callback (lambda (button event)
                   (send timer stop))])
  #f)

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

