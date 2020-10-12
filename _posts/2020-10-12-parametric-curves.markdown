---
layout: post
title: "Parametric Curves"
date: 2020-10-12 01:30:06 +0800
img : para2.gif
categories:
---

We shall start a new series based on the popular [Multivariate Calculus](https://www.amazon.com/Multivariable-Calculus-James-Stewart/dp/1305266641/ref=sr_1_1?crid=3OZ0BQMO52OZ7&dchild=1&keywords=multivariable+calculus+james&qid=1602362514&s=books&sprefix=multivar%2Cstripbooks-intl-ship%2C360&sr=1-1) textbook by James Stewart. Most of the examples will be taken from the book and I highly recommend you to get a copy. We shall start the series with Parametric Curves.

Parametric equations are a set of `x`, `y` equations that are given as functions of a third variable `t`. This allows us to denote a curve as a set of functions where the usual function will fail the Vertical Line Test for functions.

$$\begin{aligned}
x &= f(t)\\
y &= g(t)\\
\end{aligned}$$

Usually `t` denotes time but it doesn't have to be. In this post, we can think of `t` as time and the parametric cuves as denoting the position of a particle at time `t`.

$$(x, y) = (f(t), g(t))$$

The classic example will be the circle:

$$x = cos\: t \:\:\:\: y = sin\: t\:\:\:\: 0 \leqslant t \leqslant 2\pi$$

In Racket, we can plot the function using the `plot` library:

{% highlight racket %}
(require plot)

(plot (parametric
       (lambda (t)
         (vector (cos t)
                 (sin t)))   
       0
       (* 2 pi)))
{% endhighlight %}

![](/assets/img/para1.png)

It will be nice if Racket plot library is able to animate the drawing of the parametric equations. Unfortunately as far as I know, it is currently not a feature that is available. However, we can write a function that draws the function using a callback timer loop that you will find at the bottom of the post.

Using the `plot-animate` function, let's plot the following function:

$$\begin{aligned}
x &= t + sin\: 5t\\
y &= t + sin\: 6t
\end{aligned}$$

{% highlight racket %}
(plot-animate
 (* 4 pi)
 0 13 0 13
 (lambda (t)
   (vector (+ t (sin (* 5 t)))
           (+ t (sin (* 6 t))))))   
{% endhighlight %}

![](/assets/img/para2.gif)

Let's plot another function given in the textbook:

$$\begin{aligned}
x &= sin\: 9t\\
y &= sin\: 10t
\end{aligned}$$

{% highlight racket %}
(plot-animate
 (* 2 pi)
 -1 1 -1 1
 (lambda (t)
   (vector (sin (* 9 t))
           (sin (* 10 t)))))   
{% endhighlight %}

![](/assets/img/para3.gif)

And finally:

$$\begin{aligned}
x &= 2.3\: cos\: 10t\: + \: cos\: 23t\\
y &= 2.3\: sin\: 10t\: - \: sin\: 23t
\end{aligned}$$

{% highlight racket %}
(plot-animate
 (* 2 pi)
 -3.5 3.5 -3.5 3.5
 (lambda (t)
   (vector (+ (* 2.3 (cos (* 10 t))) (cos (* 23 t)))
           (- (* 2.3 (sin (* 10 t))) (sin (* 23 t))))))    
{% endhighlight %}

![](/assets/img/para4.gif)

## Cycloids

We can trace a path of a circle rolling along a straight line usin gthe following parametric equations:

$$\begin{aligned}
x &= r(\theta  - sin\: \theta)\\
y &= r(\theta  - cos\: \theta)
\end{aligned}$$

$$r\theta$$ represents part of the circumference of the circle as it traces it's path along the line. Cycloids are interesting because it arises in many interesting problems like the brachistochrone problem and tautochrone problem. In short, when you invert the cycloid, and row a particle down, it will slide down in the shortest time due to gravity and no matter where you place it, it will always slide to the bottom at the same time.

{% highlight racket %}
(plot-animate
 (* 3 2 pi)
 0 (* 3 2 pi) 0 5
 (lambda (t)
   (let ([r 1])
     (vector (* r (- t (sin t)))
             (* r (- 1 (cos t)))))))   
{% endhighlight %}

![](/assets/img/para5.gif)

The `plot-animate` function:

{% highlight racket %}
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
{% endhighlight %}
