---
layout: post
title: "Concentration Inequality"
date: 2021-01-23 01:30:06 +0800
img : 
tags: [probability, measure]
---

Concentration inequalities provide universal probability bounds on random variables regardless on the distribution. It is called concentration inequality because the probablities concentrate on a certain interval and the probablity of very small or very large values are very small.

<div class="toc" markdown="1">
# Contents:
- [Markov Inequality](#markov)
- [Chebyshev Inequality](#chebyshev)
- [Chernoff Bound](#chernoff)
- [References](#references)
</div>

## <a name="markov"></a>Markov Inequality

Let $$X$$ be a nonnegative random variable with $$E[X] < \infty$$. Then:

$$\begin{aligned}
P(X > \alpha) &\leq \frac{E[X]}{\alpha}\\
\forall \alpha &> 0\\
\end{aligned}$$

To show this:

$$\begin{aligned}
E[X] &= E[X.I_{X \leq \alpha}] + E[X.I_{X > \alpha}]\\
&\geq E[X.I_{X > \alpha}]\\
&\geq E[\alpha . I_{X > \alpha}]\\
&\geq \alpha E[I_{X > \alpha}]\\
&\geq \alpha P(X > \alpha)\\
\end{aligned}$$

Note that if $$\alpha \leq E[X]$$ then we will get the trivial probability of $$P(X > \alpha) \leq 1$$. In other words, Markov Inequality is only useful if $$\alpha > E[X]$$.

Also the inequality gives a loose bound in the sense that the probability goes down only on $$\frac{1}{\alpha}$$. For example, the probability of $$X$$ taking twice its value is at most half:

$$\begin{aligned}
P(X > 2E[X]) &\leq \frac{1}{2}\\
\end{aligned}$$

## <a name="chebyshev"></a>Chebyshev Inequality

If the variance is known and finite $$\sigma^{2} < \infty$$, then:

$$\begin{aligned}
P(\vert X - \mu \vert > k\sigma) &\leq \frac{1}{k^{2}}\\
\forall k &> 0\\
\end{aligned}$$

We can derive the Chebyshev's inequality from the Markov's inequality:

$$\begin{aligned}
P(\vert X - \mu \vert^{2} > (k\sigma)^{2}) &\leq \frac{E[\vert X - \mu \vert^{2}]}{(k\sigma)^{2}}\\
&= \frac{\sigma^{2}}{(k\sigma^{2})}\\
\implies P(\vert X - \mu \vert > k\sigma) &\leq \frac{1}{k^{2}}\\
\end{aligned}$$

As we can see the decay is faster at $$\frac{1}{k^{2}}$$ compared to the Markov's inequality.

## <a name="chernoff"></a>Chernoff Bound

To get a tighter bound like the exponential decay, we can invoke the Markov's inequality as long as the mgf exists in a neighborhood of the origin.

Suppose:

$$\begin{aligned}
M_{X}(s) &= E[e^{sX}]\\
\forall s &\in [-\epsilon, \epsilon]\\
M_{X}(s) &< \infty\\
\epsilon &> 0\\
\end{aligned}$$

Then:

$$\begin{aligned}
P(X > \alpha) &\leq e^{-\Lambda(\alpha)}\\
\Lambda(\alpha) &= \sup\limits_{s > 0}\big(s\alpha - log M_{X}(s)\big)\\
\end{aligned}$$

Since $$e^{X}$$ is a monotonically increasing function, we can take the exponent transformation on both sides and invoking Markov's inequality:

$$\begin{aligned}
P(X > \alpha) &= P(e^{sX} > e^{s\alpha})\\
&\leq \frac{E[e^{sX}]}{e^{s\alpha}}\\
&\leq M_{X}(s)e^{-s\alpha}\\
\forall s &> 0\\
M_{X}(s) &< \infty\\
\end{aligned}$$

Note that the above decay is exponential and the tightest bound is achieved by taking the infinitum:

$$\begin{aligned}
P(X > \alpha) &\leq \inf\limits_{s > 0}M_{X}(s)e^{-s\alpha}\\
&= e^{-\sup\limits_{s > 0}\big(s\alpha - log M_{X}(s)\big)}
\end{aligned}$$

Similarly we can prove the case for the negative tail $$P(X < \alpha)$$.

## <a name="references"></a>References

[YouTube Mod-01 Lec-42 Concentration Inequality](https://www.youtube.com/watch?v=nzJbpTYkiWo&list=PLbMVogVj5nJQqGHrpAloTec_lOKsG-foc&index=42&ab_channel=nptelhrd)
<br />
[Krishna Jagannathan lecture27_Concentration.pdf](http://www.ee.iitm.ac.in/~krishnaj/EE5110_files/notes/lecture27_Concentration.pdf)

