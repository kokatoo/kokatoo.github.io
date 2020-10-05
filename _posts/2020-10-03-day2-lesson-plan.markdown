---
layout: post
title:  "Day 2 Lesson Plan"
date:   2020-10-03 15:43:06 +0800
img : falling2.gif
categories:
---

In day 2 of the seminar, we will introduce list and recursion. We will demo Newton's Method for calculating square root and some fundamental Number Theory concepts like Prime Factorization, GCD and LCD. Students can test the LCD of blinking traffic lights and code it for themselves. Finally we will simulate bouncing balls.

## 1. List, Loop, and Recursion

Introduce the list function and datatype and some basic functions to deal with list like car and cdr.

Next we introduce looping (via recursion in Racket). A simple example would be the exponential function.

{% highlight racket %}
(define (my-expt base index)
  (if (= index 0)
      1
      (* base (my-expt base (sub1 index)))))   
{% endhighlight %}

Next we will task them to code a factorial function. Make sure test cases are written first to ensure their coding is correct.

{% highlight racket %}
(check-equal? (factorial 5) 120)   
{% endhighlight %}

## 2. Newton's Method
Revisit the square function that we did on day 1 and query the student whether they can figure out a way to find the inverse function. In other words, how does the computer calculate the square root of a number? 

{% highlight racket %}
(define (my-sqr x)   
  (* x x))
(my-sqr 2)
{% endhighlight %}

The students are not expected to learn this but it would be interesting to expose them to the Newton's method in calculating square roots where there is no closed-form solution. A simple explanation would explaining it as an average of the initial guess of the number `x` with `(/ guess x)` to come up with a closer approximation. Would also give a short introduction on how they will be exposed to the Newton's method in Calculus in the future and how important it is in engineering.

{% highlight racket %}
(define (my-sqrt x)

  (define (average x1 x2)
    (/ (+ x1 x2) 2))

  (define (good-enough? guess)
    (< (abs (- (sqr guess) x)) 0.001))   

  (define (improve guess)
    (average guess (/ x guess)))

  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))

  (sqrt-iter 1.0))
{% endhighlight %}

## 3. Prime Factorization

Get the students to recall what they learned about prime factorization in math class and how they would have coded it. Explain to them why they only have to search for factors up to the `(sqrt n)`. This involves a simple but beautiful mathematical proof.

We will start with a prime search algorithm and move on from there to prime factors if there is enough time. Note that this is their very first real algorithm.

{% highlight racket %}
(define (prime? n)

  (define (smallest-divisor n)
    (find-divisor n 2))

  (define (find-divisor n test-divisor)
    (cond [(> (sqr test-divisor) n) n]
          [(divides? test-divisor n) test-divisor]
          [(= test-divisor 2) (find-divisor n (+ test-divisor 1))]    
          [else (find-divisor n (+ test-divisor 2))]))

  (define (divides? a b)
    (= (modulo b a) 0))

  (= n (smallest-divisor n)))
{% endhighlight %}

Next we will briefly go into the importance of prime as basic building blocks of number (Fundamental Theorem of Arithmetic), how its used in cryptography and the field of cryptography.

## 4. Greatest Common Divisor (GCD)

Next we would ask them to recall what they have learned in math class about GCD. Explain to them the importance of GCD in Number Theory and a simple example of maximizing the side of a square you can cut out from a rectangle and simplifying fractions.

Ask the students to recall how to find the GCD of two numbers from prime factors and explain to them why this would be a bad way to find the GCD (as explained in the cryptography RSA example of how hard it is to factor numbers). The time complexity is in fact exponential in terms of the input length. 

There is a faster way and easier way to compute the GCD which is to use Euclid's algorithm. Step through the recursion with the students and compare the result using the prime factors code.

{% highlight racket %}
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (modulo a b))))   
{% endhighlight %}

## 5. Least Common Multiple (LCM)

Next we will show them the relationship between GCD and LCM through a simple formula.

{% highlight racket %}
(define (lcm a b)
  (/ (* a b) (gcd a b)))   
{% endhighlight %}

Using the traffic light simulation we did yesterday, explain to them if two traffic lights are blinking at different intervals, LCM would be able to predict when the red light will blink together again. We can use the bicycle wheel example in their Math textbook to better explain this. Task them to code 2 different traffic lights to verify that this is in fact true.

![](/assets/img/lcm.gif)

## 6. Bouncing Balls

Explain Newton's Third Law and its application on falling object. We will first task the students to create a ball using a circle in an empty canvas. Using a gravitational constant of 9.81 and the knowledge gained about rates in the traffic light simulation, get the student to code a falling object obeying Newton's equation for a falling body.

![](/assets/img/falling.gif)

Next explain to them the physics of bouncing. The formula for the bounce up will depend on the velocity accumulated until the time the ball hits the ground and governed by the following equation:

`y = v(0) * t - 0.5*a*t^2`

![](/assets/img/falling2.gif)

Finally if there is enough time, we can challenge the students to create multiple balls simulating drops from all the planets in the solar system.

![](/assets/img/gravity.gif)
