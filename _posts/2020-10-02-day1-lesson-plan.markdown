---
layout: post
title:  "Day 1 Lesson Plan"
date:   2020-10-02 15:43:06 +0800
img : snake.png
tags: racket
---

In Day 1 of the seminar, we will introduce about coding and DrRacket. We will show demos and introduce to the 2htdp teaching packs. 
Finally we will simulate a traffic light animation. Please also check out [Day 2]({% post_url 2020-10-03-day2-lesson-plan %}) lesson plan.

<div class="toc" markdown="1">
# Contents:
- [Introduction](#intro)
- [DrRacket](#drracket)
- [Demos](#demos)
- [Functions](#functions)
- [Writing Tests](#tests)
- [2htdp/image Library](#image)
- [2htdp/universe Library](#universe)
- [Finite State Machine (FSM)](#fsm)
</div>

## <a name="intro"></a>Introduction
We will start off the seminar by answering the following questions.

1. Why learn coding
2. Future of coding
3. Why Us?

## <a name="drracket"></a>DrRacket

We will introduce them to the DrRacket programming environment or IDE. It is widely used in introductory CS courses with minimal setup and simple to use.

We will proceed to demo simple expression like:

{% highlight racket %}
(+ 1 1) 
{% endhighlight %}

in the REPL panel (see below).

<img src="/assets/img/drracket.png" />

## <a name="demos"></a>Demos

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

## <a name="functions"></a>Functions

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

Next we will impart to them by coding these functions, we can automate computation and compose functions to do wonderful things.

## <a name="tests"></a>Writing Tests

Test cases would be taught as a form of coming up with examples (ideally prior to actual coding) that you expect the function to produce. We will introduce various industry best practice of testing like TDD (Test Driven Development). 

Using the mathematical functions we have written, we will proceed to ask the students to write tests for them. There are 3 basic unit test cases:

- Happy Path
- Unhappy Path
- Boundary

{% highlight racket %}
(require rackunit)

(check-equal? (area-triangle 2 3) 3)
(check-equal? (area-triangle 0 0) 0)
(check-equal? (area-triangle 2e10 3e10) 3e20)    

(check-equal? (area-rect 2 3) 6)
(check-equal? (area-circle 1) pi)
{% endhighlight %}

## <a name="image"></a>2htdp/image Library

2htdp/image is a image teachpack that provides a number of basic image construction functions and combining them to build more complex images. We will use them to a simple traffic light simulation. We will start off with a single circle follow by stacking 3 circles to create a static traffic light simulation.

<span class="autowidth">![](/assets/img/demo6.png)</span>

## <a name="universe"></a>2htdp/universe Library

Next we introduce the big-bang function in 2htdp/universe library to animate the images. Basically we would like to change colors across time. I will proceed to demo an example of how to change the colors of a circle across time. The students will then be tasked to change the color of all circles with a challenge of a certain time interval. This will tie to the concept of rates and modulo they learned in their math class to coding. They will be exposed to keeping track of time state and how to abstract them into mathematical functions.

<span class="autowidth">![](/assets/img/one-traffic.gif)</span>

## <a name="fsm"></a>Finite State Machine (FSM)

Finally we will introduce them the concept of FSM and conditionals. We will take the abs math function as an example to explain conditionals. In the traffic light example, there are only 3 states (Red, Yellow, Green). We will draw the state transition diagram (Red -> Green -> Yellow -> Green). They will be tasked to simulate a traffic light at fixed time interval.

<span class="autowidth">![](/assets/img/traffic.gif)</span>

Note that the time interval is fixed across all 3 states, but we know in real life yellow state is shorter than both red and green. In order to solve this problem, we will introduce the concept of structure to store more information to tackle this problem.

<span class="autowidth">![](/assets/img/full-traffic.gif)></span>

Before we end the first day, we will revisit the traffic light program and analyze what kind of coding improvements to mae the code more asethetic and maintainable if requirements were to be changed in the future.
