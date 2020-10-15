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

(plot (parametric
       (lambda (theta)
         (polar->cartesian theta (cos (* 2 theta))))
       0
       (* 2 pi)))



(plot (parametric
       (lambda (r)
         (polar->cartesian pi r)) -2 1))


