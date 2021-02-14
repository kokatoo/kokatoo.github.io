---
layout: post
title: "Convergence of Random Variables"
date: 2021-01-23 01:30:06 +0800
img : 
tags: [probability, measure]
---

Let $$\{x_{n}, n \geq 1\}$$ be a sequence of random variables. We say that the sequence converges to some $$x \in \mathbb{R}$$ if:

$$\begin{aligned}
\vert x_{n} - x \vert &< \epsilon\\
\exists n_{0} &\in \mathbb{N}\\
\forall n &\geq n_{0}\\
\epsilon &> 0\\
\end{aligned}$$

We say that the sequence converges to $$+\infty$$ if:

$$\begin{aligned}
x_{n} &> M\\
\exists n_{0} &\in \mathbb{N}\\
\forall n &\geq n_{0}\\
M &> 0\\
\end{aligned}$$

Similarly, we say the sequence converges to $$-\infty$$ if:

$$\begin{aligned}
x_{n} &< -M\\
\exists n_{0} &\in \mathbb{N}\\
\forall n &\geq n_{0}\\
M &> 0\\
\end{aligned}$$

<div class="toc" markdown="1">
# Contents:
- [Types of Convergences](#types)
    - [Pointwise Convergence](#pointwise)
    - [Convergence in Probability](#prob)
    - [Convergence in the $$r^\text{th}$$ Mean](#rthmean)
    - [Convergence in Distribution (Weak Convergence)](#distribution)
    - [Example](#example)
- [Hierarchy of Convergences](#hierarchy)
    - [$$X_{n} \overset{r}{\rightarrow} X \implies X_{n} \overset{i.p.}{\rightarrow} X$$](#hier1)
    - [$$X_{n} \overset{r}{\rightarrow} X \kern.7em\not\kern -.7em \impliedby X_{n} \overset{i.p.}{\rightarrow} X$$](#hier2)
    - [$$X_{n} \overset{r}{\rightarrow} X \implies X_{n} \overset{s}{\rightarrow} X$$](#hier8)
    - [$$X_{n} \overset{r}{\rightarrow} X \kern.7em\not\kern -.7em \impliedby X_{n} \overset{s}{\rightarrow} X$$](#hier9)
    - [$$X_{n} \overset{i.p.}{\rightarrow} X \implies X_{n} \overset{D}{\rightarrow} X$$](#hier3)
    - [$$X_{n} \overset{i.p.}{\rightarrow} X \kern.7em\not\kern -.7em \impliedby X_{n} \overset{D}{\rightarrow} X$$](#hier4)
    - [$$X_{n} \overset{a.s.}{\rightarrow} X \implies \overset{i.p.}{\rightarrow} X$$](#hier5)
    - [$$X_{n} \overset{a.s.}{\rightarrow} X \kern.7em\not\kern -.7em \impliedby X_{n} \overset{i.p.}{\rightarrow} X$$](#hier6)
    - [$$X_{n} \overset{a.s.}{\rightarrow} X \kern.7em\not\kern -.7em \impliedby X_{n} \overset{m.s.}{\rightarrow} X$$](#hier7)
- [Skorokhod’s Representation Theorem](#skorokhod)
- [Continuous Mapping Theorem](#continuous)
- [Continuity Theorems](#continuity)
- [Hölder's Inequality](#holder)
- [Minkowski's Inequality](#minkowski)
- [Lyapunov's Inequality](#lyapunov)
- [References](#references)
</div>

## <a name="types"></a>Types of Convergences

### <a name="pointwise"></a>Pointwise Convergence

Let $$(\Omega, \mathcal{F}, P)$$ be a probability space and $$\{X_{n}\mid n \in \mathbb{N}\}$$ be a sequence of random variables defined on the probability space.

$$\{X_{n}\}$$ is said to converge surely or pointwise to $$X$$ if:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}X_{n}(\omega) &\rightarrow X(\omega)\\
X_{n}(\omega) &\overset{p.w.}{\rightarrow} X(\omega)\\
\forall &\omega \in \Omega\\
\end{aligned}$$

For a fixed realized $$\omega$$, pointwise convergence is the same as the definition we give in the introduction.

Pointwise convergence is however too strict for most practical purposes as it applies to all $$\omega$$. By lessening the assumption, we can get to other form of convergences.

### <a name="almost"></a>Amost Sure Convergence (Strong Convergence)

A sequence of random variables $$\{X_{n}\}$$ is said to converge with probability one or almost surely to $$X$$ if:

$$\begin{aligned}
P(\{\omega \mid \lim\limits_{n \rightarrow \infty}X_{n}(\omega) &\rightarrow X(\omega)\}) = 1\\
X_{n}(\omega) &\overset{a.s.}{\rightarrow} X(\omega)\\
\end{aligned}$$

This means that the random variables might not converge on a set of zero probability measure.

### <a name="prob"></a>Convergence in Probability

A sequence of random variables $$\{X_{n}\}$$ is said to converge in probability to $$X$$ if:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}P(\vert X_{n} - X \vert &> \epsilon) = 0\\
X_{n}(\omega) &\overset{i.p.}{\rightarrow} X(\omega)\\
\forall \epsilon &> 0\\
\end{aligned}$$

Note that the difference between convergence in probability and almost sure convergence is the $$\lim\limits$$ are inside for almost sure convergence and outside for convergence in probability. In fact, almost sure convergence implies convergence in probability but the converse is not true.

So rather than saying the sequence of random variables is converging, it is more accurate to say that the sequence of probabilities converges.

### <a name="rthmean"></a>Convergence in the $$r^\text{th}$$ Mean

A sequence of random variables $$\{X_{n}\}$$ is said to converge in the rth mean to $$X$$ if:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}E[\vert X_{n} &- X \vert^{r}] = 0\\
X_{n}(\omega) &\overset{r}{\rightarrow} X(\omega)\\
\end{aligned}$$

For $$r = 2$$, the convergence is known as the mean-squared convergence.

### <a name="distribution"></a>Convergence in Distribution (Weak Convergence)

A sequence of random variables $$\{X_{n}\}$$ is said to converge in distribution to $$X$$ if:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}F_{X_{n}}(x) &= F_{X}(x)\\
X_{n}(\omega) &\overset{D}{\rightarrow} X(\omega)\\
\forall x &\in \mathbb{R}
\end{aligned}$$

where $$F_{X}()$$ is continuous.

### <a name="example"></a>Example

Consider the probability space $$\big([0, 1], \mathcal{B}([0, 1]), \lambda\big)$$ and a sequence of random variables $$\{X_{n}, n \geq 1\}$$:

$$\begin{aligned}
X_{n}(\omega) &= 
\begin{cases}
   n, &\text{if } \omega \in [0, \frac{1}{n}]\\
   0, &\text{otherwise}\\
\end{cases}
\end{aligned}$$

Since the probability measure is the Lebesgue measure, we can rewrite the random variable as:

$$\begin{aligned}
P(X_{n} = n) &= \frac{1}{n}\\
P(X_{n} = 0) &= 1 - \frac{1}{n}\\
\end{aligned}$$

We can see that if as $$n \rightarrow \infty$$:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}X_{n}(\omega) &= 
\begin{cases}
   0, &\omega \neq 0\\
   \infty, &\omega = 0\\
\end{cases}
\end{aligned}$$

Hence, we can see the above converge almost surely to $$0$$ and not pointwise/surely to $$0$$ as $$0$$ has a measure of $$0$$.

Consider some $$\epsilon >0$$:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}P(\vert X_{n} \vert > \epsilon) &= \lim\limits_{n \rightarrow \infty}P(X_{n} = n)\\
&= \lim\limits_{n \rightarrow \infty}\frac{1}{n}\\
&= 0
\end{aligned}$$

Hence, $$\{X_{n}\}$$ converges in probability.

Now consider the following mean-square:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}E[\vert X_{n} \vert^{2}] &= \lim\limits_{n \rightarrow \infty}\big(n^{2}.\frac{1}{n} + 0^{2}.(1 - \frac{1}{n})\big)\\
&= \infty\\
\end{aligned}$$

Hence, $$\{X_{n}\}$$ does not converge in mean-squared.

And neither does it converge in $$1^{\text{th}}$$ mean:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}E[\vert X_{n} \vert] &= \lim\limits_{n \rightarrow \infty}\big(n.\frac{1}{n} + 0.(1 - \frac{1}{n})\big)\\
&= 1\\
\end{aligned}$$

And finally it can be shown that the CDF of $$\{X_{n}\}$$ converges to:

$$\begin{aligned}
F_{X}(x) &=
\begin{cases}
   0, &\text{if } x < 0\\
   1, &\text{otherwise}\\
\end{cases}
\end{aligned}$$

## <a name="hierarchy"></a>Hierarchy of Convergences

The following implication holds:

$$\begin{aligned}
\text{p.w.} \implies \text{a.s.} &\implies \text{i.p.} \implies \text{D}\\
\text{r}^\text{th}\text{ mean} &\implies \text{i.p.}\\
\text{r}^\text{th}\text{ mean}(r \geq 1) &\implies \text{s}^\text{th}\text{ mean}(r > s \geq 1)\\
\end{aligned}$$

### <a name="hier1"></a>$$X_{n} \overset{r}{\rightarrow} X \implies X_{n} \overset{i.p.}{\rightarrow} X$$

First let's show the $$X_{n} \overset{r}{\rightarrow} X \implies X_{n} \overset{i.p.}{\rightarrow} X$$:

Knowing that $$\vert X_{n} - X\vert$$ is monotonically increasing and hence applying Markov's inequality to $$\lim\limits_{n \rightarrow \infty}P(\vert X_{n} - X\vert > \epsilon)$$ in the higher moments:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}P(\vert X_{n} - X\vert > \epsilon) &\leq \lim\limits_{n \rightarrow \infty}\frac{E[\vert X_{n} - X \vert^{r}]}{\epsilon^{r}}\\
&= 0\\
\forall \epsilon &> 0\\
\end{aligned}$$

Note this is equal to $$0$$ because $$X_{n} \overset{r}{\rightarrow} X$$.

### <a name="hier2"></a>$$X_{n} \overset{r}{\rightarrow} X \kern.7em\not\kern -.7em \impliedby X_{n} \overset{i.p.}{\rightarrow} X$$

In general, the converse is not true.

Counterexample:

Let $$\{X_{n}\}$$ be a sequence of independent random variables defined as:

$$\begin{aligned}
X_{n} &= 
\begin{cases}
   n^{3}, &P(X_{n} = n^{3}) = \frac{1}{n^{2}}\\
   0, &P(X_{n} = 0) = 1 - \frac{1}{n^{2}}\\
\end{cases}
\end{aligned}$$

Then, $$X_{n} \overset{i.p.}{\rightarrow} 0$$ as:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}P(\vert X_{n} - 0 \vert > \epsilon) = 0\\
\forall \epsilon > 0\\
\end{aligned}$$

But:

$$\begin{aligned}
E[\vert X_{n} - 0 \vert] &= n^{3}.\frac{1}{n^{2}} + 0.(1 - \frac{1}{n^{2}})\\
&= n\\
\forall n &\in \mathbb{N}\\
\end{aligned}$$

Hence, $$X_{n}$$ does not converge in the $$1^{th}$$ mean.

### <a name="hier8"></a>$$X_{n} \overset{r}{\rightarrow} X \implies X_{n} \overset{s}{\rightarrow} X$$

Given that $$r > s \geq 1$$:

$$\begin{aligned}
X_{n} \overset{r}{\rightarrow} X \implies X_{n} \overset{s}{\rightarrow} X\\
\end{aligned}$$

The proof follows from [Lyapunov's Inequality](#lyapunov).

### <a name="hier9"></a>$$X_{n} \overset{r}{\rightarrow} X \kern.7em\not\kern -.7em \impliedby X_{n} \overset{s}{\rightarrow} X$$

In general, the converse is not true.

Counterexample:

$$\begin{aligned}
X_{n} &= 
\begin{cases}
   n, &P(X_{n} = n) = \frac{1}{n^{\frac{r + s}{2}}}\\
   0, &P(X_{n} = 0) = 1 - \frac{1}{n^{\frac{r + s}{2}}}\\
\end{cases}
\end{aligned}$$

We can see:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}E[\vert X_{n}^{s} \vert] &= \lim\limits_{n \rightarrow \infty}n^{\frac{s - r}{2}}\\
&= 0\\
\end{aligned}$$

But:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}E[\vert X_{n}^{r} \vert] &= \lim\limits_{n \rightarrow \infty}n^{\frac{r - s}{2}}\\
&= \infty\\
\end{aligned}$$

### <a name="hier3"></a>$$X_{n} \overset{i.p.}{\rightarrow} X \implies X_{n} \overset{D}{\rightarrow} X$$

Next we show the proof of $$X_{n} \overset{i.p.}{\rightarrow} X \implies X_{n} \overset{D}{\rightarrow} X$$.

Let $$\epsilon > 0$$:

$$\begin{aligned}
F_{X_{n}}(x) &= P(X_{n} < x)\\
&= P(X_{n} \leq x, X \leq x + \epsilon) + P(X_{n} \leq x, X > x + \epsilon)\\
&\leq F_{X}(x + \epsilon) + P(\vert X_{n} - X\vert > \epsilon)\\
\end{aligned}$$

Similarly:

$$\begin{aligned}
F_{X}(x - \epsilon) &= P(X \leq x - \epsilon)\\
&= P(X \leq x - \epsilon, X_{n} \leq x) + P(X \leq x - \epsilon, X_{n} > x)\\
&\leq F_{X_{n}}(x) + P(\vert X_{n} - X\vert > \epsilon)\\
\end{aligned}$$

Combining the two:

$$\begin{aligned}
F_{X}(x - \epsilon) - P(\vert X_{n} - X\vert > \epsilon) \leq F_{X_{n}}(x) \leq F_{X}(x + \epsilon) + P(\vert X_{n} - X\vert > \epsilon)\\
\end{aligned}$$

As we know that $$X_{n} \overset{i.p.}{\rightarrow} X$$ as $$n \rightarrow \infty$$, then:

$$\begin{aligned}
F_{X}(x - \epsilon) - \lim\limits_{n \rightarrow \infty}P(\vert X_{n} - X\vert > \epsilon) &\leq \lim\limits_{n \rightarrow \infty}F_{X_{n}}(x) \leq F_{X}(x + \epsilon) + \lim\limits_{n \rightarrow \infty}P(\vert X_{n} - X\vert > \epsilon)\\
F_{X}(x - \epsilon) - 0 &\leq \lim\limits_{n \rightarrow \infty}F_{X_{n}}(x) \leq F_{X}(x + \epsilon) + 0\\
F_{X}(x - \epsilon) &\leq \liminf\limits_{n \rightarrow \infty}F_{X_{n}}(x) \leq \limsup\limits_{n \rightarrow \infty}F_{X_{n}}(x) \leq F_{X}(x + \epsilon)\\
\end{aligned}$$

If $$F_{X}$$ is continuous at $$x$$, then the above equation will converge to $$F_{X}(x)$$ as $$\epsilon \rightarrow 0$$.

### <a name="hier4"></a>$$X_{n} \overset{i.p.}{\rightarrow} X \kern.7em\not\kern -.7em \impliedby X_{n} \overset{D}{\rightarrow} X$$

In general, the converse is not true. 

Counterexample:

Let $$X$$ be a Bernoulli random variable with $$p = 0.5$$ and a sequence $$\{X_{n} \mid X_{n} = X\}$$ and let $$Y = 1 - X$$.

Clearly:

$$\begin{aligned}
X_{n} \overset{D}{\rightarrow} X
\end{aligned}$$

But:

$$\begin{aligned}
\vert X_{n} - Y \vert &= 1\\
\forall n &\in \mathbb{N}\\
\end{aligned}$$

Thus, $$X_{n}$$ does not converge to $$Y$$ in probability.

However, there is a special case where the converse is true. That is when $$X_{n}$$ converges to a constant in distribution.

### <a name="hier5"></a>$$X_{n} \overset{a.s.}{\rightarrow} X \implies \overset{i.p.}{\rightarrow} X$$

#### Sufficient Condition for Almost Sure Convergence

Before we touch on the above implication, let's first explore a sufficient condition for almost sure convergence.

$$\begin{aligned}
\sum_{n = 1}^{\infty}P(&A_{n}(\epsilon)) < \infty\\
\implies X_{n} &\overset{a.s.}{\rightarrow} X\\
\forall \epsilon &> 0\\
A_{n}(\epsilon) = \{\omega : \vert X_{n}&(\omega) - X(\omega)\vert > \epsilon \}\\
\end{aligned}$$

Note that the above condition is stronger than convergence in probability:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}P(\vert X_{n} - X \vert &> \epsilon) = 0\\
\end{aligned}$$

So by invoking the [Borel Cantelli Lemma 1]({% post_url 2020-12-05-probability-measure %}#cantelli) and since $$\sum_{n = 1}^{\infty}P(A_{n}(\epsilon)) < \infty$$, then almost surely only finitely many $$\{A_{n}\}$$ will occur for any $$\epsilon > 0$$. 

Now let:

$$\begin{aligned}
B_{m}(\epsilon) &= \cup_{n \geq m}A_{n}(\epsilon)\\
\end{aligned}$$

Therefore:

$$\begin{aligned}
B_{m}(\epsilon) &\leq \sum_{n = m}^{\infty}P(A_{n}(\epsilon))\\
\end{aligned}$$

Then according to Borel Cantell Lemma 1, there is a certain $$m$$ such that no event $$A_{n}$$ will occur $$n > m$$ so:

$$\begin{aligned}
\lim\limits_{m \rightarrow \infty}P(B_{m}(\epsilon)) = 0\\
\end{aligned}$$

Hence $$X_{n}$$ converges almost surely to $$X$$.

#### Necessary and Sufficient Condition for Almost Sure Convergence

Next we will do a necessary and sufficient condition for almost sure convergence.

Let:

$$\begin{aligned}
A_{n}(\epsilon) &= \{\omega : \vert X_{n}(\omega) - X(\omega)\vert > \epsilon \}\\
B_{m}(\epsilon) &= \cup_{n \geq m}A_{n}(\epsilon)\\
\end{aligned}$$

Then:

$$\begin{aligned}
X_{n} &\overset{a.s.}{\rightarrow} X\\
\iff \lim\limits_{m \rightarrow \infty}P\big(&B_{m}(\epsilon)\big) \rightarrow 0\\
\forall &\epsilon > 0\\
\end{aligned}$$

Note that the difference between this and the sufficient condition is that we jump straight to the condition involving $$B_{m}$$.

First let's prove $$\lim\limits_{m \rightarrow \infty}P\big(B_{m}(\epsilon)\big) \rightarrow 0 \implies X_{n} \overset{a.s.}{\rightarrow} X$$:

Let:

$$\begin{aligned}
A(\epsilon) &= \cap_{m = 1}^{\infty}\cup_{n = m}^{\infty}A_{n}(\epsilon)\\
&= \{A_{n}(\epsilon) \text{ i.o.} \}
\end{aligned}$$

This means that $$A_{n}$$ occurs infinitely often.

Then:

$$\begin{aligned}
X_{n} &\overset{a.s.}{\rightarrow} X\\
\implies P(A(&\epsilon)) = 0\\
P(\cap_{m = 1}^{\infty}B_{m}(&\epsilon)) = 0\\
\forall &\epsilon > 0\\
\end{aligned}$$

Since $$\{B_{m}(\epsilon)\}$$ is a nested decreasing sequence, we can invoke the continuity of probablity measure and take the limit out:

$$\begin{aligned}
\lim\limits_{m \rightarrow \infty}P\big(B_{m}(\epsilon)\big) &\rightarrow 0\\
\end{aligned}$$

Next we prove the converse $$X_{n} \overset{a.s.}{\rightarrow} X \implies \lim\limits_{m \rightarrow \infty}P\big(B_{m}(\epsilon)\big) \rightarrow 0$$:

Let:

$$\begin{aligned}
C &= \lim\limits_{n \rightarrow \infty}\{\omega \in \Omega \mid X_{n}(\omega) \rightarrow X(\omega)\}\\
\end{aligned}$$

Then:

$$\begin{aligned}
P(C^{c}) &= P(\cup_{\epsilon > 0}A(\epsilon))\\
&= P(\cup_{k = 1}^{\infty}A\bigg(\frac{1}{m}\bigg))\\
&\leq \sum_{k = 1}^{\infty}P(A\bigg(\frac{1}{k}\bigg))\\
\end{aligned}$$

The inequality is true because we can always find a $$\frac{1}{k} \leq \epsilon$$ such that $$A(\epsilon) \subseteq A(\frac{1}{k})$$.

Then by the continuity of probability measure:

$$\begin{aligned}
P(A\bigg(\frac{1}{k})\bigg) &= P(\cap_{m = 1}^{\infty}B_{m}\bigg(\frac{1}{k})\bigg)\\
&= \lim\limits_{m \rightarrow \infty}P(B_{m}\bigg(\frac{1}{k}\bigg))\\
&= 0\\
\end{aligned}$$

Hence $$P(C^{c}) = 0$$ and $$P(C) = 1$$.

Therefore, we know that:

$$\begin{aligned}
X_{n} \overset{a.s.}{\rightarrow} X \iff \lim\limits_{m \rightarrow \infty}P(B_{m}(\epsilon)) = 0\\
\end{aligned}$$

As $$A_{m}(\epsilon) \subseteq B_{m}(\epsilon)$$, it is implied that:

$$\begin{aligned}
X_{n} \overset{a.s.}{\rightarrow} X &\iff \lim\limits_{m \rightarrow \infty}P(B_{m}(\epsilon)) = 0\\
&\implies \lim\limits_{m \rightarrow \infty}P(A_{m}(\epsilon)) = 0\\
&\implies X_{n} \overset{i.p.}{\rightarrow} X
\end{aligned}$$

### <a name="hier6"></a>$$X_{n} \overset{a.s.}{\rightarrow} X \kern.7em\not\kern -.7em \impliedby X_{n} \overset{i.p.}{\rightarrow} X$$

In general, the converse is not true. 

Counterexample:

Let $$\{X_{n}\}$$ be a sequence of independent random variables defned as:

$$\begin{aligned}
X_{n} &= \begin{cases}
   1, &P(X_{n} = 1) = \frac{1}{n}\\
   0, &P(X_{n} = 0) = 1 - \frac{1}{n}\\
\end{cases}
\end{aligned}$$

Taking the limit $$n \rightarrow \infty$$:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}P(\vert X_{n} - X \vert > \epsilon) &= \lim\limits_{n \rightarrow \infty}P(\vert X_{n} - 0\vert > \epsilon)\\
&= \lim\limits_{n \rightarrow \infty}P(\vert X_{n}\vert > \epsilon)\\
&= \lim\limits_{n \rightarrow \infty}P(X_{n} = 1)\\
&= \lim\limits_{n \rightarrow \infty}\frac{1}{n}\\
&= 0\\
\end{aligned}$$

Hence, $$X_{n} \overset{i.p.} 0$$.

Next, let $$A_{n}$$ be the event that $$\{X_{n} = 1\}$$. We know that $$\{A_{n}\}$$ are independent and:

$$\begin{aligned}
\sum_{n = 1}^{\infty}P(A_{n}) &= \infty\\
\end{aligned}$$

Invoking [Borel Cantelli Lemma 2]({% post_url 2020-12-05-probability-measure %}#cantelli), infinitely many $$A_{n}$$ events will occur with probability one. Therefore, $$X_{n}$$ does not converge to zero almost surely.



### <a name="hier7"></a>$$X_{n} \overset{m.s.}{\rightarrow} X \kern.7em\not\kern -.7em \impliedby X_{n} \overset{a.s.}{\rightarrow} X$$

In general, the converse is not true.

Counterexample:

Let $$\{X_{n}\}$$ be a sequence of independent random variables defined as:

$$\begin{aligned}
X_{n} &= 
\begin{cases}
   n, &\text{if } \omega \in [0, \frac{1}{n}]\\
   0, &\text{otherwise}\\
\end{cases}
\end{aligned}$$

In the [example](#example) section, we know that $$X_{n}$$ converges to 0 almost surely.

But:

$$\begin{aligned}
E[X_{n}^{2}] &= n^{2}.\frac{1}{n}\\
&= n\\
\lim\limits_{n \rightarrow \infty}E[X_{n}^{2}] &= \infty\\
\end{aligned}$$

Hence, $$X_{n} \overset{m.s.}{\rightarrow} X \kern.7em\not\kern -.7em \impliedby X_{n} \overset{a.s.}{\rightarrow} X$$.

However, there always exists a determinstic increasing subsequence $$n_{1}, n_{2}, \cdots$$, such that:

$$\begin{aligned}
X_{n} &\overset{i.p.}{\rightarrow} X\\
\implies \lim\limits_{i \rightarrow \infty}X_{n_{i}} &\overset{a.s.}{\rightarrow} X\\
\end{aligned}$$

For example, let $$\{X_{n}\}$$ be a sequence of independent random variables defined as:

$$\begin{aligned}
X_{n} &= 
\begin{cases}
   1, &P(X_{n} = 1) = \frac{1}{n}\\
   0, &P(X_{n} = 0) = 1 - \frac{1}{n}\\
\end{cases}\\
\end{aligned}$$

We have seen earlier that $$X_{n}$$ does not converge almost surely to $$X$$. 

However if we consider the subsequence $$\{X_{1}, X_{3}, X_{9}, \cdots\}$$, then this subsequence converges almost surely to zero:

Let:

$$\begin{aligned}
n_{i} &= i^{2}\\
Y_{i} &= X_{n_{i}} = X_{i^{2}}\\
\end{aligned}$$

Then:

$$\begin{aligned}
P(Y_{i} = 1) &= P(X_{i^{2}} = 1)\\
&= \frac{1}{i^{2}}\\
\implies \sum_{i \in \mathbb{N}}P(Y_{i}) &= \sum_{i \in \mathbb{N}} \frac{1}{i^{2}} < \infty\\
\end{aligned}$$

Hence, by the Borel Cantelli Lemma 1:

$$\begin{aligned}
X_{i^{2}} \overset{a.s.}{\rightarrow} 0
\end{aligned}$$

The above example will going to be useful when we explore The Weak/Strong Law of Large Numbers.


### <a name="hier7"></a>$$X_{n} \overset{a.s.}{\rightarrow} X \kern.7em\not\kern -.7em \impliedby X_{n} \overset{m.s.}{\rightarrow} X$$

In general, the converse is not true.

Counterexample:

Let $$\{X_{n}\}$$ be a sequence of independent random variables defined as:

$$\begin{aligned}
X_{n} &= 
\begin{cases}
   1, &P(X_{n} = 1) = \frac{1}{n}\\
   0, &P(X_{n} = 0) = 1 - \frac{1}{n}\\
\end{cases}\\
\lim\limits_{n \rightarrow \infty}E[X_{n}^{2}] &= \lim\limits_{n \rightarrow \infty}\frac{1}{n}\\
&= 0\\
\end{aligned}$$

But back in [$$X_{n} \overset{a.s.}{\rightarrow} X \kern.7em\not\kern -.7em \impliedby X_{n} \overset{i.p.}{\rightarrow} X$$](#hier6), we know that $$X_{n}$$ does not converge to 0 almost surely. Hence, $$X_{n} \overset{a.s.}{\rightarrow} X \kern.7em\not\kern -.7em \impliedby X_{n} \overset{m.s.}{\rightarrow} X$$.

## <a name="skorokhod"></a>Skorokhod's Representation Theorem

Let $$\{X_{n}, n \geq 1\}$$ and $$X$$ be random variables on $$(\Omega, \mathcal{F}, P)$$ such that $$X_{n} \overset{D}{\rightarrow} X$$.

Then there exists a probability space $$(\Omega^{\prime}, \mathcal{F}^{\prime}, P^{\prime})$$ and random variables $$\{Y_{n}, n \geq 1\}$$ and $$Y$$ on $$(\Omega^{\prime}, \mathcal{F}^{\prime}, P^{\prime})$$ such that $$\{Y_{n}\}, \{X_{n}\}$$ and $$Y, X$$ have the same distribution and:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}Y_{n} \overset{a.s.}{\rightarrow} Y\\
\end{aligned}$$

In other words, one can construct an almost sure convergence sequence in another probability space having the same distribution as $$X_{n} \overset{D}{\rightarrow} X$$.

We will use Skorokhod's Representation Theorem in the Continuous Mapping Theorem below.

## <a name="continuous"></a>Continuous Mapping Theorem

If $$X_{n} \overset{D}{\rightarrow} X$$ and $$g:\mathbb{R} \rightarrow \mathbb{R}$$ is continuous, then:

$$\begin{aligned}
g(X_{n}) \overset{D}{\rightarrow} g(X)\\
\end{aligned}$$

To show this, we know from the continuity of $$g$$ that if $$X_{n} \overset{a.s.}{\rightarrow} X$$, then $$g(X_{n}) \overset{a.s.}{\rightarrow} g(X)$$. However, we only have that $$X_{n} \overset{D}{\rightarrow} X$$.

Hence by Skorokhod's Representation Theorem, there exists a probability space $$(\Omega^{\prime}, \mathcal{F}^{\prime}, P^{\prime})$$, and $$\{Y_{n}\}, Y$$ such that:

$$\begin{aligned}
Y_{n} \overset{a.s.}{\rightarrow} Y\\
\end{aligned}$$

From the continuity of $$g$$:

$$\begin{aligned}
&\{\omega \in \Omega^{\prime} \mid g(Y_{n}(\omega)) \rightarrow g(Y(\omega))\} \supseteq \{\omega \in \Omega^{\prime} \mid Y_{n}(\omega) \rightarrow Y(\omega)\}\\
\implies &P(\{\omega \in \Omega^{\prime} \mid g(Y_{n}(\omega)) \rightarrow g(Y(\omega))\}) \geq P(\{\omega \in \Omega^{\prime} \mid Y_{n}(\omega) \rightarrow Y(\omega)\})\\
\implies &P(\{\omega \in \Omega^{\prime} \mid g(Y_{n}(\omega)) \rightarrow g(Y(\omega))\}) \geq 1\\
\implies &g(Y_{n}) \overset{a.s.}{\rightarrow}g(Y)\\
\implies &g(Y_{n}) \overset{D}{\rightarrow}g(Y)\\
\implies &g(X_{n}) \overset{D}{\rightarrow}g(X)\\
\end{aligned}$$

Since $$X, Y$$ have the same distribution.

## <a name="continuity"></a>Continuity Theorems

### Theorem

Furthermore, $$X_{n} \overset{D}{\rightarrow} X$$ iff for every bounded continuous function  $$g:\mathbb{R} \rightarrow \mathbb{R}$$, we have:

$$\begin{aligned}
E[g(X_{n})] \rightarrow E[g(X)]\\
\end{aligned}$$

Proving just one side, by Skorokhod's Representation Theorem, there exists $$\{Y_{n}\}, Y$$ such that:

$$\begin{aligned}
Y_{n} \overset{a.s.}{\rightarrow} Y\\
\end{aligned}$$

Next, by invoking the Continuous Mapping Theorem:

$$\begin{aligned}
g(Y_{n}) \overset{a.s.}{\rightarrow} g(Y)\\
\end{aligned}$$

And finally, since $$g$$ is bounded, and by invoking DCT:

$$\begin{aligned}
E[g(Y_{n})] &\rightarrow E[g(Y)]\\
\implies E[g(X_{n})] &\rightarrow E[g(X)]\\
\end{aligned}$$

### Theorem

Also, if $$X_{n} \overset{D}{\rightarrow} X$$, then:

$$\begin{aligned}
C_{X_{n}}(t) &\rightarrow C_{X}(t)\\
\forall t &\in \mathbb{R}\\
\end{aligned}$$

By Skorokhod's Representation Theorem, there exists $$\{Y_{n}\}, Y$$ such that:

$$\begin{aligned}
Y_{n} &\overset{a.s.}{\rightarrow} Y\\
\implies cos(Y_{n}t) &\rightarrow cos(Yt)\\
\implies cos(X_{n}t) &\rightarrow cos(Xt)\\
\end{aligned}$$

As $$cos, sin$$ are bounded functions:

$$\begin{aligned}
E[cos(Y_{n}(t))] + iE[sin(Y_{n}t)] &\rightarrow E[cos(Yt)] + iE[sin(Yt)]\\
\implies C_{Y_{n}}(t) &\rightarrow C_{Y}\\
\implies C_{X_{n}}(t) &\rightarrow C_{X}\\
\forall t &\in \mathbb{R}\\
\end{aligned}$$

### Theorem

The converse for the above theorem is also true.

Let $$\{X_{n}\}$$ be a sequence of random variables with characteristic functions $$\{C_{X_{n}}(t)\}$$, and $$X$$ with a characteristic function $$C_{X}(t)$$, then:

$$\begin{aligned}
X_{n} \overset{D}{\rightarrow}X\\
\end{aligned}$$

### Theorem

Let $$\{X_{n}\}$$ be a sequence of random variables with characteristic function $$\{C_{X_{n}}(t)\}$$, and suppose:

$$\begin{aligned}
\phi(t) = &\lim\limits_{n \rightarrow \infty}C_{X_{n}}(t)\\
\forall t &\in \mathbb{R}\\
\end{aligned}$$

Then, if $$\phi(t)$$ is discontinuous at $$t = 0$$, then $$X_{n}$$ does not converge in distribution.

Then, if $$\phi(t)$$ is continuous at $$t = 0$$, then $$\phi$$ is a valid characteristic function of some random variable $$X$$ and $$X_{n} \overset{D}{\rightarrow} X$$.

In other words, we can just check the continuity at $$t = 0$$ without having to verify the conditions of the characteristic function.

An intuitive explanation of why this is so is because since $$\phi(t)$$ is a limit of characteristic functions $$\{C_{X_{n}}\}$$, it inherits some nice properties such that the above theorem is true.

## <a name="holder"></a>Hölder's Inequality

If $$p, q > 1$$ and $$\frac{1}{p} + \frac{1}{q} = 1$$ then:

$$\begin{aligned}
E\big[\vert XY \vert\big] &\leq E\big[\vert X \vert^{p}\big]^{\frac{1}{p}} \times E\big[\vert Y \vert^{q}\big]^{\frac{1}{q}}\\
\end{aligned}$$

This generalizes the Caucny-Schwarz Inequality.

## <a name="minkowski"></a>Minkowski's Inequality

If $$p \geq 1$$ then:

$$\begin{aligned}
E\big[\vert X + Y \vert\big] &\leq E\big[\vert X \vert^{p}\big]^{\frac{1}{p}} + E\big[\vert Y \vert^{p}\big]^{\frac{1}{p}}
\end{aligned}$$

This generalizes the Triangle Inequality for the pth moment.

## <a name="lyapunov"></a>Lyapunov's Inequality

If $$r > s \geq 1$$ then:

$$\begin{aligned}
E\big[\vert X \vert^{s}\big]^{\frac{1}{s}} + E\big[\vert Y \vert^{r}\big]^{\frac{1}{r}}
\end{aligned}$$

## <a name="references"></a>References

[YouTube Mod-01 Lec-43 Convergence of Random Variables - 1](https://www.youtube.com/watch?v=cAtsCYGtfiE&list=PLbMVogVj5nJQqGHrpAloTec_lOKsG-foc&index=43)
<br />
[Krishna Jagannathan lecture28_Convergence.pdf](http://www.ee.iitm.ac.in/~krishnaj/EE5110_files/notes/lecture28_Convergence.pdf)

