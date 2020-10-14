---
layout: post
title: "Parametric Curves"
date: 2020-10-12 01:30:06 +0800
img : para2.gif
categories:
---

We shall start a new series based on the popular [Multivariate Calculus](https://www.amazon.com/Multivariable-Calculus-James-Stewart/dp/1305266641/ref=sr_1_1?crid=3OZ0BQMO52OZ7&dchild=1&keywords=multivariable+calculus+james&qid=1602362514&s=books&sprefix=multivar%2Cstripbooks-intl-ship%2C360&sr=1-1) textbook by James Stewart. Most of the examples will be taken from the book and I highly recommend you to get a copy. We shall start the series with Parametric Curves.

<div class="toc" markdown="1">
# Contents:
- [Parametric Equation](#parametric)
- [Cycloid](#cycloid)
- [Tangent](#tangent)
- [Arc Length](#arc)
- [Surface Area](#surface)
- [Bézier Curves](#beizer)
</div>

## <a name="parametric"></a>Parametric Equation

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

## <a name="cycloid"></a>Cycloid

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

## <a name="tangent"></a>Tangent

Let's try to plot tangents to the parametric plots. We know from the chain rule:

$$\frac{dy}{dt} = \frac{dy}{dx} \cdot \frac{dx}{dt}$$

We can then bring solve for $$\frac{dy}{dx}$$:

$$\frac{dy}{dx} = \frac{dy \mathbin{/} dt}{dx \mathbin{/} dt} \mathbin{,} \:\:\: \frac{dx}{dt} \neq 0$$

The tangent for the cycloid:

$$\begin{aligned}
\frac{dy}{dx} &= \frac{dy \mathbin{/} d\theta}{dx \mathbin{/} d\theta}\\\\
&= \frac{r\:sin\:\theta}{r(1 - cos\:\theta)}\\\\
&= \frac{sin\:\theta}{1 - cos\:\theta}
\end{aligned}$$

Let's plot the tangent for the cycloid:

![](/assets/img/para6.gif)

Let's try another function:

$$\begin{aligned}
x &= t^{2}\\
y &= t^{3} - 3t\\\\
\frac{dy}{dx} &= \frac{dy \mathbin{/} dt}{dx \mathbin{/} dt}\\\\
&= \frac{3t^{2} - 3}{2t}\\\\
&= \frac{3}{2}(t - \frac{1}{t})
\end{aligned}$$

![](/assets/img/para7.gif)

## <a name="arc"></a>Arc Length

The formula for arc length can be derived from the Pythagorean Theorem (for the interval/hypotenuse approximation) and Mean Value Theorem (for the $$\frac{dy}{dx}$$) is given below:

$$L = \int_{a}^{b}\sqrt{1 + \bigg(\frac{dy}{dx}\bigg)^{2}} dx$$

To extend this to cover parametric equation:

$$\begin{aligned}
L &= \int_{a}^{b}\sqrt{1 + \bigg(\frac{dy}{dx}\bigg)^{2}} dx\\\\
L &= \int_{c}^{d}\sqrt{1 + \bigg(\frac{dy \mathbin{/} dt}{dx \mathbin{/} dt}\bigg)^{2}} \frac{dx}{dt} dt\\\\
L &= \int_{c}^{d}\sqrt{\bigg(\frac{dx}{dt}\bigg)^{2} + \bigg(\frac{dy}{dt}\bigg)^{2}} dt\\\\
\end{aligned}$$

## <a name="surface"></a>Surface Area

We can calculate the surface area of a function $$f$$ when it's revolved about the x-axis by the following formula:

$$L = \int_{a}^{b} 2 \pi f(x)\sqrt{1 + [f'(x)]^{2}} dx$$

This equation can be derived from the surface area of a section of the cone with length $$l$$ and radius $$r$$ (see the textbook for more details):

$$A = 2\pi rl \mathbin{,} \:\:\: r=\frac{1}{2}(r_{1} + r_{2}) $$

$$r$$ corresponds to the $$f(x)$$ part of the equation (derived from Mean Value Theorem) and $$l$$ corresponds to the arc length part of the equation $$\sqrt{1 + [f'(x)]^{2}}$$.

Let us extend this to cover parametric equations:

$$L = \int_{a}^{b} 2 \pi y \sqrt{\bigg(\frac{dx}{dt}\bigg)^{2} + \bigg(\frac{dy}{dt}\bigg)^{2}} dt$$

This can be derived in a similar way to arc length.

## <a name="beizer"></a>Bézier Curves

Bézier curve is a parammetric curve that is used extensively in Computer Aided Design (CAD). For example in the design of curvature of cars' bodies.

Following is a cubic Bézier curve comprising of 4 control points for: $$0 \leqslant t \leqslant 1\\\\$$

$$\begin{aligned}
x &= x_{0}(1 - t)^{3} + 3x_{1}t(1 - t)^{2} + 3 x_{2}t^{2}(1 - t) + x_{3}t^{3}\\\\
y &= y_{0}(1 - t)^{3} + 3y_{1}t(1 - t)^{2} + 3 y_{2}t^{2}(1 - t) + y_{3}t^{3}\\
\end{aligned}$$

The control points basically act as boundary conditions on a cubic spline interpolation. Given the following control points, we can plot the following graph in Racket:

$$P_{0}(4\mathbin{,}\:1)\mathbin{,}\:P_{1}(28\mathbin{,}\:48)\mathbin{,}\:P_{2}(50\mathbin{,}\:42)\mathbin{,}\:P_{3}(40\mathbin{,}\:5)$$

![](/assets/img/para2.png)

The blue, green, and black lines are formed using the 4 control points while the 2 yellow lines are formed from anchor points at $$t = 0.5$$ and the red line is also the anchor point at $$t = 0.5$$ but on the yellow lines. As you can see the red line touches the cubic Bézier Curve. As $$t$$ moves, the red line will trace the curve correspondingly.

<br />
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
{% endhighlight %}
