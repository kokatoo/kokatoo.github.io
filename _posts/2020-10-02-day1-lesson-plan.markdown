---
layout: post
title:  "Day 1 Lesson Plan"
date:   2020-10-02 15:43:06 +0800
img : snake.png
categories:
---

## 1. Introduction
We will start off the seminar by answering the following questions.

1. Why learn coding
2. Future of coding
3. Why Us?

## 2. DrRacket

We will introduce them to the DrRacket programming environment or IDE. It is widely used in introductory CS courses with minimal setup and simple to use.

We will proceed to demo simple expression like:

{% highlight racket %}
(+ 1 1) 
{% endhighlight %}

in the REPL panel (see below).

<img src="/assets/img/drracket.png" />

## 3. Demos

First we will demo the power of Racket by running some simple programs.

{% highlight racket %}
(scale
 50
 (color-list->bitmap
  '(red orange yellow green cyan blue violet)   
  7
  1))
{% endhighlight %}

![](/assets/img/demo1.png)

{% highlight racket %}
(let sierpinski ([n 8])
  (if (zero? n)
      (triangle 2 'solid 'red)
      (let ([t (sierpinski (- n 1))]) 
        (above t (beside t t)))))
{% endhighlight %}

![](/assets/img/demo2.png)

{% highlight racket %}
(define (koch-curve n)
  (cond
    [(zero? n) (square 1 "solid" "black")]
    [else
     (local [(define smaller (koch-curve (- n 1)))] 
       (beside/align "bottom"
                     smaller
                     (rotate 60 smaller)
                     (rotate -60 smaller)
                     smaller))]))
{% endhighlight %}

![](/assets/img/demo3.png)

Next we will demo programs that the students will code themselves during the course of the seminar.

### 3.1 Bouncing Balls:

Simulate bouncing balls with different gravitational constant from the Sun to Pluto.

![](/assets/img/gravity.gif)

### 3.2 Snake Game:
![](/assets/img/snake.gif)

## 4. Function

Give the students a revision of what defines a mathematical function and how it's different from the conventional function as we know in programming. Introduce implictly the concept of immutability vs state changes as we compared the differences between various programming languages and mathematical function. This is essentially giving the students a taste of the debate between functional programming vs imperative programming.

We will show them how to code simple mathematical functions in Racket.

{% highlight racket %}

(define (area-triangle a b) 
  (* 1/2 a b))

(define (area-rect a b)
  (* a b))

(define (area-circle r)
  (* pi (sqr r)))
{% endhighlight %}

Students will proceed to code the following formulas:
- area of a cube
- square function
- Pythagorean formula
- quadratic formula

