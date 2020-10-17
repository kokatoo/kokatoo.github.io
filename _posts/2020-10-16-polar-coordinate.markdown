---
layout: post
title: "Polar Coordinates"
date: 2020-10-16 01:30:06 +0800
img : polar2.gif
tags: calculus
---

We are all probably familiar to the Cartesian coordinates but do you know there is another 2D cordinate system that is easier to use in certain situations? Welcome to the world of polar coordinates where rotation and spirals rule.

<div class="toc" markdown="1">
# Contents:
- [Polar Coordinate System](#coordinate)
- [Polar Curves](#curves)
- [Symmetry](#symmetry)
- [Common Polar Curves](#common)
</div>

## <a name="coordinate"></a>Polar Coordinate System

A point in the $$(x\mathbin{,}y)$$ Cartesian coordinate is represented as $$(r\mathbin{,}\theta)$$ in polar coordinates. $$r$$ represents the distance from the point to the origin, and $$\theta$$ is the angle between the point and the polar axis (x-axis). We can convert between the two world using trigonometry and Pythagorean theorem:

$$\begin{aligned}
x &= r\: cos\: \theta\\
y &= r\: sin\: \theta\\\\
r^{2} &= x^{2} + y^{2}\\
tan\: \theta &= \frac{y}{x}
\end{aligned}$$

As can seen from the plot below, each value of $$tan\: \theta$$ occurs twice from 0 to $$2\pi$$. Therefore you need to specify the specific quadrant as well and you can tell which quadrant from the original $$(x, y)$$ point.

{% highlight racket %}
(plot (function
       (lambda (x)
         (tan x))
       (- (* 3/2 pi)) (* 3/2 pi))   
      #:y-min -5 #:y-max 5)
{% endhighlight %}

![](/assets/img/polar1.png)

## <a name="curves"></a>Polar Curves

Polar curves can be represented by the equation $$r = f(\theta)$$. 

Let's plot $$r = 1 + sin\:\theta$$ using Racket Plot:

{% highlight racket %}
(plot (parametric
       (lambda (theta)
         (polar->cartesian theta (+ 1 (sin theta))))    
       0
       (* 2 pi)))
{% endhighlight %}

We can animate and plot both the polar curve and the parametric equation that is driving $$r$$ as $$\theta$$ increases $$r = 1 + sin\:\theta$$.

![](/assets/img/polar3.gif)

## <a name="symmetry"></a>Symmetry

The curve is symmetric about the polar-axis (x-axis) if:

$$r = f(\theta) = f(-\theta)$$

For example:

$$r = cos\:2\theta$$

as $$cos\:\theta = cos(-\theta)$$

![](/assets/img/polar2.png)

The curve is symmetric about the y-axis if:

$$r = f(\theta) = f(\pi - \theta)$$

Note the above example satisfies this as well since:

$$cos\: 2\theta = cos(2(\pi - \theta))$$

The curve is symmetric about the pole (remains unchanged if you rotate 180°) if:

$$\begin{aligned}
r &= f(\theta) = -f(\theta)\\
or&\\
r &= f(\theta + \pi)\\
or&\\
(r\mathbin{,}\theta) &= (-r\mathbin{,}\theta)
\end{aligned}$$

Note again the above example satisfies this as well since:

$$cos\: 2\theta = cos(2(\theta + \pi))$$

## <a name="common"></a>Common Polar Curves

### Circles and Spirals:

<br />
<div class="row">
  <div class="column">
  $$r = a$$
    <img src="/assets/img/polar3.png" style="width:100%">
  </div>
  <div class="column">
  $$r = a\: sin\:\theta$$
    <img src="/assets/img/polar5.png" style="width:100%">
  </div>
  <div class="column">
  $$r = a\: cos\:\theta$$
  <img src="/assets/img/polar6.png" style="width:100%">
  </div>
  <div class="column">
  $$r = a\:\theta$$
  <img src="/assets/img/polar4.png" style="width:100%">
  </div>
</div>

### Limaçons:

Arises in the study of planetary motion.

<br />
<div class="row">
  <div class="column">
$$\begin{aligned}
r &= a + b\: sin\:\theta\\
a &< b
\end{aligned}$$
    <img src="/assets/img/polar7.png" style="width:100%">
  </div>
  <div class="column">
$$\begin{aligned}
r &= a + b\: sin\:\theta\\
a &= b
\end{aligned}$$
    <img src="/assets/img/polar8.png" style="width:100%">
  </div>
  <div class="column">
$$\begin{aligned}
r &= a + b\: sin\:\theta\\
a &> b
\end{aligned}$$
  <img src="/assets/img/polar9.png" style="width:100%">
  </div>
  <div class="column">
$$\begin{aligned}
r &= a + b\: cos\:\theta\\
a &< b
\end{aligned}$$  
  <img src="/assets/img/polar10.png" style="width:100%">
  </div>
</div>

### Roses:

$$n$$-leaved if $$n$$ is odd.

$$2n$$-leaved if $$n$$ is even.

<br />
<div class="row">
  <div class="column">
$$\begin{aligned}
r &= a\:cos\:2\theta
\end{aligned}$$
    <img src="/assets/img/polar11.png" style="width:100%">
  </div>
  <div class="column">
$$\begin{aligned}
r &= a\:cos\:3\theta
\end{aligned}$$
    <img src="/assets/img/polar12.png" style="width:100%">
  </div>
  <div class="column">
$$\begin{aligned}
r &= a\:cos\:4\theta
\end{aligned}$$
  <img src="/assets/img/polar13.png" style="width:100%">
  </div>
  <div class="column">
$$\begin{aligned}
r &= a\:sin\:4\theta
\end{aligned}$$  
  <img src="/assets/img/polar14.png" style="width:100%">
  </div>
</div>

### Lemniscates:

<br />
<div class="row">
  <div class="column">
$$\begin{aligned}
r^{2} &= a^{2}\:sin\:2\theta
\end{aligned}$$
    <img src="/assets/img/polar15.png" style="width:100%">
  </div>
  <div class="column">
$$\begin{aligned}
r^{2} &= a^{2}\:cos\:2\theta
\end{aligned}$$
    <img src="/assets/img/polar16.png" style="width:100%">
  </div>
