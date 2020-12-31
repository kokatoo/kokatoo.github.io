---
layout: post
title: "Integration and Expectation"
date: 2020-12-22 01:30:06 +0800
img : mct.png
tags: [probability, measure, expectation]
---

In this post, we will talk about abstract integral such as Lebesgue integral that generalizes the Riemann integral and how it is related to the expectation of a random variable. 

<div class="toc" markdown="1" style="padding-left: 28px;">
# Contents:
- [Riemann Integral](#riemann)
- [Abstract Integral](#abstract)
- [Simple Function](#simple)
- [Non-Negative Function](#nonnegative)
- [General Function](#general)
- [Properties of Integral](#properties)
- [Inclusion Exclusion Principle](#inclusion)
- [Monotone Convergence Theorem](#mct)
- [Expectation of a Discrete RV](#discrete)
- [Expectation of a Continuous RV](#continuous)
- [Fatou's Lemma](#fatou)
- [Dominated Convergence Theorem](#dominate)
</div>

## <a name="riemann"></a>Riemann Integral

Consider a function $$f: \mathbb{R} \rightarrow \mathbb{R}$$ and the interval $$[a , b]$$ in the domain of $$f$$. The lower and upper Riemann sums are defined as:

$$\begin{aligned}
L_{n} := &\sum_{i = 1}^{n}\inf_{x \in [x_{i}, x_{i} + 1]}f(x)\Delta x_{i}\\
U_{n} := &\sum_{i = 1}^{n}\sup_{x \in [x_{i}, x_{i} + 1]}f(x)\Delta x_{i}\\
\end{aligned}$$

As $$\lim\limits_{\Delta x_{i} \rightarrow 0}$$ and $$\lim\limits_{n \rightarrow \infty}$$, it can be shown that $$L_{n}$$ will be monotonically increasing and $$U_{n}$$ will be monotonically decreasing such that:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty} L_{n} \leq \lim\limits_{n \rightarrow \infty} U_{n}\\
\end{aligned}$$

A function $$f$$ is said to be Riemann integrable if the lower and upper Riemann integral agree with each other:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty} L_{n} &=\lim\limits_{n \rightarrow \infty} U_{n}\\
& = \int_{a}^{b} f(x) dx
\end{aligned}$$

## <a name="abstract"></a>Abstract Integral

Let $$(\Omega, \mathcal{F}, \mu)$$ be a measure space and a measurable function $$f: \omega \rightarrow \mathbb{R}$$. We want to define:

$$\begin{aligned}
\int_{A}f d\mu\\
\forall A \in \mathcal{F}\\
\end{aligned}$$

In other words we want to think of integration as integral over a measurable function $$f$$ w.r.t to a measure $$\mu$$ over a $$\mathcal{F}$$-measurable set $$A$$.

There are 2 special cases which we are interested in:

### Lebesgue Integral

Let $$(\Omega, \mathcal{F}, \mu)$$ be $$(\mathbb{R}, \mathcal{B}(\mathbb{R}), \lambda)$$ and $$f: \mathbb{R} \rightarrow \mathbb{R}$$. Then:

$$\begin{aligned}
\int_{-\infty}^{\infty} f d\lambda\\
\end{aligned}$$

is known as the Lebesgue integral. Lebesgue integral can be seen as the generalization of Riemann integral as they agree over intervals over $$\mathbb{R}$$. But Lebesgue integral exist over arbitrary Borel sets which might not be Riemann integrable. But if a Riemann integral exists, Lebesgue integral would exist as well and they would agree.

### Expectation of a Random Variable

Let $$(\Omega, \mathcal{F}, \mu)$$ be $$(\mathbb{R}, \mathcal{B}(\mathbb{R}), P)$$ and $$X: \omega \rightarrow \mathbb{R}$$ as a random variable. Then:

$$\begin{aligned}
E[X] := &\int_{\Omega} X dP\\
\end{aligned}$$

is known as the expectation of a random variable $$X$$.

## <a name="simple"></a>Simple Function

A function $$f: \omega \rightarrow \mathbb{R}$$ is said to be simple if it can be represented as a finite weighted sum of indicator functions:

$$\begin{aligned}
f(\omega) = &\sum_{i = 1}^{n}a_{i}I_{A_{i}}(\omega)\\
\forall \omega &\in \Omega\\
A_{i} &\in \mathcal{F}\\
a_{i} &\geq 0\\
i \in \{&1, 2,\: \cdots, n\}\\
\end{aligned}$$

Note that the representation of $$f$$ is not unique, but it is possible to put it in a canonical representation where the $$\{a_{i}\}$$ are distinct and $$\{A_{i}\}$$ are disjoint. The distinct $$a_{i}$$ will become important when we take the pre-image of the random variable later on.

An integral over a simple function $$f$$ w.r.t a measure $$\mu$$ is defined as:

$$\begin{aligned}
\int_{\Omega}f(\omega) d\mu := &\sum_{i = 1}^{n}a_{i}\mu(A_{i})\\
\end{aligned}$$

A Lebesgue integral example:

Let $$(\Omega, \mathcal{F}, \mu) = (\mathbb{R}, \mathcal{B}(\mathbb{R}), \lambda)$$ and $$f = I_{[0, 1]} + \sqrt{2}I_{\mathbb{Q}}$$:

$$\begin{aligned}
\int_{-\infty}^{\infty} f d\lambda &= \int_{-\infty}^{\infty} \big(I_{[0, 1]} + \sqrt{2}I_{\mathbb{Q}}\big) d\lambda\\
&= 1 \times \lambda([0, 1]) + \sqrt{2} \times \lambda(\mathbb{Q})\\
&= 1 \times 1 + \sqrt{2} \times 0\\
&= 1\\
\end{aligned}$$

A random variable example:

Let $$(\Omega, \mathcal{F}, \mu) = (\{H, T\}^{n}, \mathcal{F}, P)$$ and let $$X: \Omega \rightarrow \mathbb{R}$$ be a simple random variable of the number of neads in $$n$$ tosses:

$$\begin{aligned}
E[X] &= \int_{\Omega} X dP\\
&= \sum_{i = 1}^{n}i\times P(X = i)\\
&= \sum_{i = 1}^{n}i\times {n \choose i}p^{i}(1 - p)^{n - i}\\
&= np
\end{aligned}$$

## <a name="nonnegative"></a>Non-Negative Function

Let $$(\Omega, \mathcal{F}, \mu)$$ be a measure space and $$f: \Omega \rightarrow \mathbb{R}^{+}$$ be a non-negative $$\mathcal{F}$$-measurable function. Let $$S(f)$$ be the collection of all simple functions $$q: \Omega \rightarrow \mathbb{R}^{+}$$ such that:

$$\begin{aligned}
q(\omega) &\leq f(\omega)\\
\forall \omega &\in \Omega\\
\end{aligned}$$

The idea is to approximate the function $$f$$ with simple function $$q$$ from below. 

We define the abstract integral of $$f$$ w.r.t $$\mu$$ as:

$$\begin{aligned}
\int_{\Omega} f d\mu &= \sup_{q \in S(f)}\int_{\Omega}q d\mu\\
\end{aligned}$$

## <a name="general"></a>General Function

Let $$f: \Omega \rightarrow \mathbb{R}$$ be an arbitrary measurable function and separate $$f$$ as:

$$\begin{aligned}
f = f_{+} &- f_{-}\\
\forall f_{+} &\geq 0\\
f_{-} &\geq 0\\
\omega &\in \Omega\\
\end{aligned}$$

And define:

$$\begin{aligned}
\int_{\Omega}f d\mu := \int_{\Omega}f_{+}d\mu - \int_{\Omega}f_{-}d\mu\\
\end{aligned}$$

This is well defined as long as at least one of the integrals is finite and undefined otherwise.

Now let $$A \in \mathcal{F}$$, then:

$$\begin{aligned}
\int_{A}f d\mu := \int_{\Omega}(f \times I_{A})d\mu\\
\end{aligned}$$

## <a name="properties"></a>Properties of Integral

Here are some properties of abstract integral w.r.t to Lebesgue integral and and the special case of expectation that follows from the definition of abstract integral over simple functions, non-negative functions and general functions. 

Let $$f, g, h$$ be measurable functions from $$\Omega \rightarrow \mathbb{R}$$ on the measure space $$(\Omega, \mathcal{F}, \mu)$$ and let $$X, Y$$ be random variabes defined on $$(\Omega, \mathcal{F}, P)$$

### Property 1

$$\begin{aligned}
\int_{\Omega}I_{A}d\mu &= \mu(A)\\
E[I_{A}] &= P(A)\\
\forall A &\in \mathcal{F}\\
\end{aligned}$$

This property follows from the definition of a simple function:

$$\begin{aligned}
f(\omega) = &I_{A}(\omega)\\
\int_{\Omega}f(\omega) d\mu := &\mu(A)\\
\end{aligned}$$

### Property 2

$$\begin{aligned}
\int_{\Omega}gd\mu &\geq 0\\
\forall g &\geq 0\\
\end{aligned}$$

$$\begin{aligned}
E[X] &\geq 0\\
\forall X &\geq 0\\
\end{aligned}$$

Let $$S(g)$$ contains all simple functions. We know that all $$a_{i}$$ are non-negative in simple functions and hence:

$$\begin{aligned}
\int_{\Omega}q d\mu &\geq 0\\
\forall q &\in S(f)\\
\end{aligned}$$

Then:

$$\begin{aligned}
\int_{\Omega}g d\mu &= \sup_{q \in S(f)}\int_{\Omega}q d\mu\\
&\geq 0\\
\end{aligned}$$

### Property 3

$$\begin{aligned}
&g = 0 \rightarrow \int_{\Omega}gd\mu = 0\\
&\mu \text{ a.e.}\\
\\
&X = 0 \rightarrow E[X] = 0\\
&\text{ a.s.}
\end{aligned}$$

Note that $$\mu \text{ a.e.}$$ (almost everywhere) means that $$g$$ equal to zero except at places where it has measure zero w.r.t to $$\mu$$.

Let $$g = 0, \mu \text{ a.e.}$$ be a simple function where $$\mu(A_{i}) = 0$$:

$$\begin{aligned}
g = \sum_{i = 1}^{k}a_{i}I_{A_{i}} \rightarrow \int_{\Omega}g d\mu = 0\\
\end{aligned}$$

Now let $$g = 0, \mu \text{ a.e.}$$ be a non-negative function. Then:

$$\begin{aligned}
q(\omega) = 0 &\rightarrow \int_{\Omega}q d\mu = 0\\
&\rightarrow \int_{\Omega}g d\mu = 0\\
\forall q &\in S(g)\\
\end{aligned}$$

### Property 4

$$\begin{aligned}
0 \geq g \geq h &\rightarrow \int_{\Omega}hd\mu \geq \int_{\Omega}gd\mu \\
0 \geq X \geq Y &\rightarrow E[X] \geq E[Y]\\
\end{aligned}$$

Let $$g, h$$ be simple functions and $$0 \geq g \geq h, \mu \text{ a.e.}$$. Then:

$$\begin{aligned}
h &= g + q\\
&\exist \: q \geq 0\\
\end{aligned}$$

Then using linearity of integration (which we will prove later):

$$\begin{aligned}
\int_{\Omega}h d\mu &= \int_{\Omega}g d\mu + \int_{\Omega}q d\mu\\
&\geq \int_{\Omega}g d\mu\\
\end{aligned}$$

Now let $$g, h$$ be non-negative functions:

$$\begin{aligned}
q \in S(g) &\rightarrow q(\omega) \leq g(\omega) \leq h(\omega)\\
&\rightarrow q \in S(h)\\
&\rightarrow S(g) \subseteq S(h)\\
\end{aligned}$$

Hence:

$$\begin{aligned}
\sup_{q \in S(g)} \int_{\Omega}q d\mu &\leq \sup_{q \in S(h)} \int_{\Omega}q d\mu\\
\rightarrow \int_{\Omega}g d\mu &\leq \int_{\Omega}h d\mu\\
\end{aligned}$$

### Property 5

$$\begin{aligned}
g = h, \mu \text{ a.e.} &\rightarrow \int_{\Omega}gd\mu = \int_{\Omega}hd\mu \\
X = Y \text{ a.s.} &\rightarrow E[X] = E[Y]\\
\end{aligned}$$

This follows from property 4 as:

$$\begin{aligned}
g = h &\leftrightarrow g \leq h \cap g \geq h\\
&\mu\: \text{a.e.}\\
\end{aligned}$$

### Property 6

$$\begin{aligned}
g \geq 0, \mu \text{ a.e.} \cap \int_{\Omega}g d\mu = 0 &\rightarrow g = 0, \mu \text{ a.e.}\\
X \geq 0, \text{ a.s.} \cap E[X] = 0 &\rightarrow X = 0, \text{ a.s.}\\
\end{aligned}$$

Let $$g$$ be a simple function. Because $$a_{i} > 0$$, it follow that:

$$\begin{aligned}
\mu(A_{i}) &= 0, \forall i
\end{aligned}$$

And from finite additivity:

$$\begin{aligned}
\mu(\cup_{i = 1}^{n}A_{i}) = 0\\
\end{aligned}$$

Now, let $$g$$ be a non-negative function. Suppose on the contrary $$B = \{\omega \mid g(\omega) > 0\}$$ and assume $$\mu(B) > 0$$:

Let $$B_{n} = \{\omega \mid g(\omega) > \frac{1}{n}\}$$:

$$\begin{aligned}
B_{n} &\subseteq B_{n + 1}\\
\forall n &\in \mathbb{N}\\
\end{aligned}$$

By continuity of measure:

$$\begin{aligned}
\cup_{i = 1}^{\infty}B_{n} &= B\\
\mu(B) &= \mu(\cup_{i = 1}^{\infty}B_{n})\\
\lim\limits_{n \rightarrow \infty}\mu(B_{n}) &> 0\\
\end{aligned}$$

Then there $$\exist k$$ such that $$\mu(B_{k}) > 0$$. Since $$g$$ is a supremum of simple functions:

$$\begin{aligned}
\int_{\Omega} g d\mu &\geq \int_{B} g d\mu\\
&\geq \int_{\Omega} I_{B}d\mu \\
&\geq \int_{\Omega}I_{B_{k}}d\mu\\
&\geq \frac{1}{k}I_{B_{k}}d\mu = \frac{1}{k}\mu(B_{k})\\
&> 0\\
\end{aligned}$$

which is a contradiction.

### Property 7 (Linearity)

$$\begin{aligned}
\int_{\Omega}(g + h)d\mu &= \int_{\Omega}gd\mu + \int_{\Omega}hd\mu\\
E[X + Y] &= E[X] + E[Y]\\
\end{aligned}$$

Let $$g, h$$ be simple functions:

$$\begin{aligned}
g &= \sum_{i = 1}^{k}a_{i}I_{A_{i}}\\
h &= \sum_{j = 1}^{m}b_{i}I_{B_{i}}\\
\end{aligned}$$

Since in canonical representation $$\{A_{i}\}$$ are disjoint and $$\{B_{j}\}$$ are disjoint, their intersection is disjoint as well:

$$\begin{aligned}
g + h &= \sum_{i = 1}^{k}\sum_{j = 1}^{m}(a_{i} + b_{j})I_{A_{i} \cap B_{j}}\\
\int_{\Omega}(g + h)d\mu &= \sum_{i = 1}^{k}\sum_{j = 1}^{m}(a_{i} + b_{j})\mu(A_{i} \cap B_{j})\\
&= \sum_{i = 1}^{k}a_{i}\sum_{j = 1}^{m}\mu(A_{i} \cap B_{j}) + \sum_{j = 1}^{m}b_{j}\sum_{i = 1}^{k}\mu(A_{i} \cap B_{j})\\
&= \sum_{i = 1}^{k}a_{i}\mu(A_{i}) + \sum_{j = 1}^{m}b_{j}\mu(B_{j})\\
&= \int_{\Omega}g d\mu + \int_{\Omega}h d\mu\\
\end{aligned}$$

Please refer to the Monotone Convergence Theorem [section](#linearity) for the proof of non-negative functions.

### Property 8 (Scaling)

$$\begin{aligned}
\int_{\Omega}afd\mu &= a\int_{\Omega}fd\mu\\
E[aX] &= aE[X]\\
\forall a &\geq 0
\end{aligned}$$

Let $$f$$ be a simple function:

$$\begin{aligned}
f &= \sum_{i = 1}^{k}a_{i}I_{A_{i}}\\
\int_{\Omega} a \times f d\mu &= \sum_{i = 1}^{k}a \times a_{i}\mu(A_{i})\\
&= a \times \sum_{i = 1}^{k}a_{i} \mu(A_{i})\\
&= a \int_{\Omega}f d\mu\\
\end{aligned}$$

Now let $$f$$ be a non-negative function. We can see that:

$$\begin{aligned}
q \in S(f) &\leftrightarrow aq \in S(af)\\
\end{aligned}$$

Then:

$$\begin{aligned}
\int_{\Omega} af d\mu &= \sup_{q' \in S(af)} \int_{\Omega}q' d\mu\\
&= \sup_{aq \in S(af)} \int_{\Omega} aq\: d\mu\\
&= \sup_{q \in S(f)} \int_{\Omega} aq\: d\mu\\
&= \sup_{q \in S(f)} a \int_{\Omega} q d\mu\\
&= a \sup_{q \in S(f)} \int_{\Omega} q d\mu\\
&= a \int_{\Omega}f d\mu\\
\end{aligned}$$

Note that $$a$$ is non-negative, so it is ok to take it out of $$\sup$$.

## <a name="inclusion"></a>Inclusion Exclusion Principle

$$\begin{aligned}
P(\cup_{i = 1}^{n}A_{i}) &= \sum_{i = 1}^{n}P(A_{i}) - \sum_{i < j}P(A_{i}\cap A_{j}) + \sum_{i < j < k}P(A_{i}\cap A_{j} \cap A_{k}) - \: \cdots + (-1)^{n - 1}P(\cap_{i = 1}^{n}A_{i})\\
\end{aligned}$$

One can prove the above principle using mathematical induction but it is easier to prove using indicator and expectation:

$$\begin{aligned}
I_{\cup_{i = 1}^{n}A_{i}} &= 1 - I_{\cap_{i = 1}^{n}A_{i}^{c}}\\
&= 1 - \prod_{i = 1}^{n}I_{A_{i}^{c}}\\
&= 1 - \prod_{i = 1}^{n}(1 - I_{A_{i}})\\
\end{aligned}$$

By expanding the product and taking expectation of indicator functions to get probability:

$$\begin{aligned}
E[I_{\cup_{i = 1}^{n}A_{i}}] &= E[1 - \prod_{i = 1}^{n}(1 - I_{A_{i}})]\\
&= E[1 - (1 - I_{A_{1}})\times (1 - I_{A_{2}}) \times \: \cdots (1 - I_{A_{n}})]\\
&= E[1 - 1 + I_{A_{1}} - \sum_{i < j}I_{A_{i}}I_{A_{j}} + \sum_{i < j < k}I_{A_{i}}I_{A_{j}}I_{A_{k}} - \: \cdots + (-1)^{n - 1}\prod_{i = 1}^{n}I_{A_{i}}]\\
&= E[I_{A_{1}}] - \sum_{i < j}E[I_{A_{i}}I_{A_{j}}] + \sum_{i < j < k}E[I_{A_{i}}I_{A_{j}}I_{A_{k}}] - \: \cdots + E[(-1)^{n - 1}\prod_{i = 1}^{n}I_{A_{i}}]\\
P(\cup_{i = 1}^{n}A_{i}) &= \sum_{i = 1}^{n}P(A_{i}) - \sum_{i < j}P(A_{i}\cap A_{j}) + \sum_{i < j < k}P(A_{i}\cap A_{j} \cap A_{k}) - \: \cdots + (-1)^{n - 1}P(\cap_{i = 1}^{n}A_{i})\\
\end{aligned}$$

## <a name="mct"></a>Monotone Convergence Theorem

Let $$f_{n}: \Omega \rightarrow \mathbb{R}$$ be a sequence of measurable functions.

We say $$f_{n}$$ converges pointwise to $$f$$ if:

$$\begin{aligned}
f_{n}(\omega) &\rightarrow f(\omega)\\
\forall \omega &\in \Omega\\
\end{aligned}$$

And we say that $$f_{n}$$ converges to $$f \: \mu \text{ a.e.}$$:

$$\begin{aligned}
f_{n}(\omega) &\rightarrow f(\omega)\\
\mu &\text{ a.e.}\\
\end{aligned}$$

In general, if $$f_{n}$$ converges to $$f$$:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}\int_{\Omega}f_{n}(\omega)d\mu &\ne \int_{\Omega}f(\omega)d\mu\\
\forall \omega &\in \Omega\\
\end{aligned}$$

However, if $$f_{n}$$ converges monotonically to $$f$$, it is fine.

Given $$(\Omega, \mathcal{F}, \mu)$$ and let $$g_{n} \geq 0$$ be a sequence of measurable functions such that:

$$\begin{aligned}
g_{n}(\omega) &\leq g_{n + 1}(\omega)\\
&\mu \text{ a.e.}\\
\lim\limits_{n \rightarrow \infty}g_{n}(\omega) &= g(\omega)\\
&\mu \text{ a.e.}\\
\end{aligned}$$

Then MCT states that:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}\int_{\Omega}g_{n}(\omega)d\mu &= \int_{\Omega}\lim\limits_{n \rightarrow \infty}g_{n}(\omega)d\mu\\
&= \int_{\Omega}g(\omega)d\mu\\
\forall \omega &\in \Omega\\
\end{aligned}$$

### <a name="linearity"></a>Linearity

$$\begin{aligned}
\int_{\Omega}g + h d\mu &= \int_{\Omega}g d\mu + \int_{\Omega}h d\mu\\
\end{aligned}$$

We will continue the linearity proof for non-negative functions.

Let $$g, h$$ be non-negative measurable functions and let $$g_{n}, h_{n}, n \geq 1$$ be simple functions such that:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}g_{n}(\omega) &= g(\omega)\\
\lim\limits_{n \rightarrow \infty}h_{n}(\omega) &= h(\omega)\\
\forall \omega &\in \Omega\\
\end{aligned}$$

Then it is clear that:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}(g_{n} + h_{n}) &= g + h\\
\end{aligned}$$

Assuming we can approximate $$g, h$$ monotonicallly and invoking monotone convergence theorem:

$$\begin{aligned}
\int_{\Omega}(g + h) d\mu &= \int_{\Omega}\lim\limits_{n \rightarrow \infty}(g_{n} + h_{n}) d\mu\\
&= \lim\limits_{n \rightarrow \infty}\int_{\Omega}(g_{n} + h_{n}) d\mu\\
&= \lim\limits_{n \rightarrow \infty}\int_{\Omega}g_{n} d\mu + \lim\limits_{n \rightarrow \infty}\int_{\Omega}h_{n} d\mu\\
&= \int_{\Omega}\lim\limits_{n \rightarrow \infty}g_{n} d\mu + \int_{\Omega}\lim\limits_{n \rightarrow \infty}h_{n} d\mu\\
&= \int_{\Omega}g d\mu + h d\mu\\
\end{aligned}$$

### Approximating Non-Negative Function From Below

One way to approximate a non-negative function from below $$\int_{\Omega} g d\mu = \sup_{q \in S(g)}\int_{\Omega} q d\mu$$ is to quantize the following way:

$$\begin{aligned}
g_{n}(\omega) &= \begin{cases}
n, &\text{ if } g(\omega) \geq n,\\
\frac{i}{2^{n}}, &\text{ if } \frac{i}{2^{n}} \geq g(\omega) \geq \frac{i + 1}{2^{n}}.\\
\end{cases}\\[10pt]
\forall i &\in \{0, 1,\: \cdots, n2^{n} - 1\}\\
\end{aligned}$$

Note that the $$g(\omega)$$ is only needed if $$g$$ is not bounded and the function is quantized into $$n2^{n}$$ levels:

$$\begin{aligned}
g_{n}(\omega) &= \sum_{i = 0}^{n2^{n} - 1}\frac{i}{2^{n}}I_{\{\omega \mid \frac{i}{2^{n}} \leq g(\omega) \leq \frac{i + 1}{2^{n}}\}} + nI_{\{g_{n}(\omega) \geq n\}}\\
\end{aligned}$$

We can show that $$g_{n}$$ converges to $$g$$ and it is monotonically increasing:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}g_{n}(\omega) &= g(\omega)\\
g_{n}(\omega) &\leq g_{n + 1}\\
\forall \omega &\in \Omega, n \in \mathbb{N}\\
\end{aligned}$$

Hence, we can invoke the monotone convergence theorem:

$$\begin{aligned}
\int_{\omega}g d\mu &= \int_{\omega}\lim\limits_{n \rightarrow \infty}g_{n}d\mu\\
&= \lim\limits_{n \rightarrow \infty} \int_{\omega}g_{n}d\mu\\
&= \lim\limits_{n \rightarrow \infty} \sum_{i = 0}^{n2^{n} - 1}\frac{i}{2^{n}}I_{\{\omega \mid \frac{i}{2^{n}} \leq g(\omega) \leq \frac{i + 1}{2^{n}}\}} + nI_{\{g_{n}(\omega) \geq n\}}\\
\end{aligned}$$

Essentially in layman terms, when comparing with the Riemann integral, instead of dividing the x-axis $$dx$$, we are instead splitting up the y-axis.

## <a name="discrete"></a>Expectation of a Discrete RV

Let:

$$\begin{aligned}
X(\omega) &= \sum_{i = 1}^{\infty}I_{A_{i}}\\
\forall X &\geq 0
\end{aligned}$$


In the canonical representation, $$\{a_{i}\}$$ are non-negative and distinct and $$\{A_{i}\}$$ are disjoint. Hence we can see that $$\{A_{i}\}$$ partition the sample space $$\Omega$$.

Let $$\{X_{n}\}$$ be a sequence of simple discrete random variables which approximate $$X$$ from below:

$$\begin{aligned}
X_{n}(\omega) &= \sum_{i = 1}^{n}a_{i}I_{A_{i}}(\omega)\\
\end{aligned}$$

From this definition, we can clearly see that:

$$\begin{aligned}
X_{n}(\omega) &\leq X_{n + 1}(\omega)\\
\forall n &\geq 1\\
\end{aligned}$$

If we define:

$$\begin{aligned}
X_{n}(\omega) &= \begin{cases}
a_{k}, &n \geq k,\\
0, &n < k.\\
\end{cases}
\end{aligned}$$

Then it can be shown that $$X_{n}(\omega)$$ converges monotonically to $$X(\omega)$$:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}X_{n}(\omega) &= X(\omega)\\
\forall \omega &\in \Omega\\
\end{aligned}$$

Then using MCT:

$$\begin{aligned}
E[X] &= E\bigg[\lim\limits_{n \rightarrow \infty} X_{n}\bigg]\\
& = \lim\limits_{n \rightarrow \infty}E[X_{n}]\\
& = \lim\limits_{n \rightarrow \infty}\sum_{i = 1}^{n}a_{i}P(A_{i})\\
& = \lim\limits_{n \rightarrow \infty}\sum_{i = 1}^{n}a_{i}P(X = a_{i})\\
& = \sum_{i = 1}^{\infty}a_{i}P(X = a_{i})\\
\end{aligned}$$

If $$X$$ can hold both positive and negative values:

$$\begin{aligned}
E[X] &= E[X_{+}] - E[X_{-}]\\
X_{+} &= max(X, 0)\\
X_{-} &= -min(X, 0)\\
\end{aligned}$$

And is undefined if both sides are infinity.

Let $$X$$ be a geometric random variable with parameter $$p$$. Then:

$$\begin{aligned}
E[X] &= \sum_{i = 1}^{\infty}iP(X = i)\\
&= \sum_{i = 1}^{\infty}i(1-p)^{i - 1}p\\
&= p\sum_{i = 1}^{\infty}i(1-p)^{i - 1}\\
&= p\frac{d}{dp}\bigg(-\sum_{i = 1}^{\infty}(1-p)^{i}\bigg)\\
&= p\frac{d}{dp}\big(-\frac{1}{p}\big)\\
&= p\big(-\frac{-1}{p^{2}}\big)\\
&= \frac{1}{p}\\
\end{aligned}$$

### Transformation and Expectation

Let $$(\Omega, \mathcal{F}, P)$$ be the sample measure space, $$(\mathbb{R}, \mathcal{B}(\mathbb{R}), P_{X})$$ be the measure space of random variable $$X$$, and the measure space $$(\mathbb{R}, \mathcal{B}(\mathbb{R}), P_{Y})$$ for random variable $$Y = f(X)$$. Then:

$$\begin{aligned}
\int_{\Omega}Y dP &= \int_{-\infty}^{\infty}f dP_{X}\\
&= \int_{-\infty}^{\infty}y dP_{Y}\\
\end{aligned}$$

First let $$f$$ be a simple function with values $$y_{1},\: \cdots, y_{n}$$. Then:

$$\begin{aligned}
\int_{\Omega} Y dP &= \sum_{i = 1}^{n}y_{i}P(\omega \mid Y(\omega) = y_{i})\\
&= \sum_{i = 1}^{n}y_{i}P(\omega \mid f(X(\omega)) = y_{i})\\
&= \int_{-\infty}^{\infty}y dP_{Y}\\
\end{aligned}$$

And:

$$\begin{aligned}
\int_{-\infty}^{\infty} f dP_{X} &= \sum_{i = 1}^{n}y_{i}P_{X}(x \in \mathbb{R} \mid f(x) = y_{i})\\
&= \sum_{i = 1}^{n}y_{i}P_{X}(f^{-1}(y_{i}))\\
&= \sum_{i = 1}^{n}y_{i}P(\omega \mid X(\omega) \in f^{-1}(y_{i}))\\
&= \sum_{i = 1}^{n}y_{i}P(\omega \mid f(X(\omega)) = y_{i})\\
&= \int_{-\infty}^{\infty}y dP_{Y}\\
\end{aligned}$$

Now let f be a non-negative function. Let $$\{f_{n}\}$$ be a sequence of simple functions that approximate $$f$$ from below and by MCT:

$$\begin{aligned}
\int_{\Omega}Y dP &= \int_{\Omega}f(X(\omega)) dP\\
&= \int_{\Omega}\lim\limits_{n \rightarrow \infty} f_{n}(X(\omega)) dP\\
&= \lim\limits_{n \rightarrow \infty}\int_{\Omega} f_{n}(X(\omega)) dP\\
&= \lim\limits_{n \rightarrow \infty}\int_{-\infty}^{\infty}f_{n}(X = x) dP_{X}\\
&= \int_{-\infty}^{\infty}f(X = x) dP_{X}\\
\end{aligned}$$

## <a name="continuous"></a>Expectation of a Continuous RV

Recall in the Radon Nikodym Theorem [post]({% post_url 2020-12-11-density-distribution-function %}#radon) that we define $$P_{X}$$ as absolute continous w.r.t to Lebesgue measure $$\lambda$$ iff there exists a measurable function $$f_{X}: \mathbb{R} \rightarrow [0, \infty]$$ such that:

$$\begin{aligned}
P_{X}(B) = \int_{\Omega}f_{X}d\lambda\\
\end{aligned}$$

Now let $$X$$ be a continuous random variable on $$(\Omega, \mathcal{F}, P)$$ and $$g$$ be a measurable function which is either non-negative or satisfies $$\int_{\Omega} \vert g \vert dP_{X} < \infty$$. Then:

$$\begin{aligned}
E[g(X)] = \int_{\Omega}gf_{X}d\lambda\\
\end{aligned}$$

And if $$g$$ is the identity function:

$$\begin{aligned}
E[g(X)] = \int_{\Omega}xf_{X}d\lambda\\
\end{aligned}$$

Let us first consider $$g$$ as a simple function $$g = \sum_{i = 1}^{n}a_{i}I_{A_{i}}$$ and by invoking Radon Nikodym theorem:

$$\begin{aligned}
E[g(X)] &= \int_{\Omega}gdP_{X}\\
&= \sum_{i = 1}^{n}a_{i}P_{X}(A_{i})\\
&= \sum_{i = 1}^{n}a_{i}\int_{A_{i}}f_{X}d\lambda\\
&= \sum_{i = 1}^{n}\int_{A_{i}}a_{i}f_{X}d\lambda\\
&= \sum_{i = 1}^{n}\int_{\Omega}a_{i}I_{A_{i}}f_{X}d\lambda\\
&= \int_{\Omega}(\sum_{i = 1}^{n}a_{i}I_{A_{i}})f_{X}d\lambda\\
&= \int_{\Omega}gf_{X}d\lambda\\
\end{aligned}$$

Next let $$g$$ be non-negative measurable function and $$\lim\limits_{n \rightarrow \infty}g_{n} = g$$ and by invoking MCT and RN:

$$\begin{aligned}
E[g(X)] &= \lim\limits_{n \rightarrow \infty}\int_{\Omega}g_{n}dP_{X}\\
&= \lim\limits_{n \rightarrow \infty}\int_{\Omega}g_{n}f_{X}d\lambda\\
&= \int_{\Omega}\lim\limits_{n \rightarrow \infty}g_{n}f_{X}d\lambda\\
&= \int_{\Omega}gf_{X}d\lambda\\
\end{aligned}$$

## <a name="fatou"></a>Fatou's Lemma

If $$X, Y$$ are random variables, we have:

$$\begin{aligned}
E[min(X, Y)] &\leq min(E[X], E[Y])\\
\end{aligned}$$

This is the case because the below implies the above:

$$\begin{aligned}
E[min(X, Y)] &\leq E[X]\\
E[min(X, Y)] &\leq E[Y]\\
\end{aligned}$$

Fatou's Lemma generalizes to infinite sequences of random variables. 

Let $$\{X_{n}, n \geq 1 \}$$ be a sequence of random variables and $$E[\vert Y \vert] < \infty$$:

(i) If $$X_{n} \geq Y$$:

$$\begin{aligned}
E[\liminf\limits_{n \rightarrow \infty} X_{n}] &\leq \liminf\limits_{n \rightarrow \infty} E[X_{n}]\\
\forall n &\geq 1\\
\end{aligned}$$

(ii) If $$X_{n} \leq Y$$:

$$\begin{aligned}
E[\limsup\limits_{n \rightarrow \infty} X_{n}] &\geq \limsup\limits_{n \rightarrow \infty} E[X_{n}]\\
\forall n &\geq 1\\
\end{aligned}$$

Recall the definition $$\limsup, \liminf$$ and that they always exist even though the limit might not exist for a bounded sequence;

$$\begin{aligned}
\liminf\limits_{n \rightarrow \infty} X_{n} &= \lim\limits_{n \rightarrow \infty} \inf_{m \geq n} X_{m}\\
\limsup\limits_{n \rightarrow \infty} X_{n} &= \lim\limits_{n \rightarrow \infty} \sup_{m \geq n} X_{m}\\
\end{aligned}$$

From the definition of $$\liminf$$ we can see that:

$$\begin{aligned}
\inf_{k \geq n}X_{k} - Y &\leq X_{m} - Y\\
\forall m &\geq n\\
\end{aligned}$$

And taking expectations and infimum w.r.t to $$m$$ on the RHS since LHS doesn't depend on $$m$$ and we know that the inequality holds $$\forall m \geq n$$:

$$\begin{aligned}
E[\inf_{k \geq n}X_{k} - Y] &\leq E[X_{m} - Y]\\
&\leq \inf_{m \geq n}E[X_{m} - Y]\\
\end{aligned}$$

Let $$Z_{n} = \inf_{m \geq n}E[X_{m} - Y]$$. We know that $$Z_{n}$$ is non-negative and a non-decreasing sequence of random variables.

By MCT:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}E[\inf_{k \geq n}X_{k} - Y] &\leq \lim\limits_{n \rightarrow \infty}\inf_{m \geq n}E[X_{m} - Y]\\
\lim\limits_{n \rightarrow \infty}E[\inf_{k \geq n}X_{k} - Y] &\leq \liminf_{m \geq n}E[X_{m} - Y]\\
E[\liminf_{n \rightarrow \infty}X_{n} - Y] &\leq \liminf_{m \geq n}E[X_{k} - Y]\\
E[\liminf_{n \rightarrow \infty}X_{n}] - E[Y] &\leq \liminf_{m \geq n}E[X_{k}] - E[Y]\\
E[\liminf_{n \rightarrow \infty}X_{n}] &\leq \liminf_{m \geq n}E[X_{k}]\\
\end{aligned}$$

Similarly, for $$\limsup$$:

$$\begin{aligned}
\sup_{k \geq n}X_{k} - Y &\geq X_{m} - Y\\
\forall m &\geq n\\
\end{aligned}$$

As the following identity holds:

$$\begin{aligned}
\limsup_{\lim\limits_{n \rightarrow \infty}}X_{n} &= -\liminf_{\lim\limits_{n \rightarrow \infty}}-X_{n}\\
\liminf_{\lim\limits_{n \rightarrow \infty}}X_{n} &= -\limsup_{\lim\limits_{n \rightarrow \infty}}-X_{n}\\
\end{aligned}$$

And taking expectations and supremum w.r.t to $$m$$ on the RHS:

$$\begin{aligned}
E[\sup_{k \geq n}X_{k} - Y] &\geq E[X_{m} - Y]\\
&\geq \sup_{m \geq n}E[X_{m} - Y]\\
\end{aligned}$$

And finally invoking MCT:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}E[\sup_{k \geq n}X_{k} - Y] &\geq \lim\limits_{n \rightarrow \infty}\sup_{m \geq n}E[X_{m} - Y]\\
\lim\limits_{n \rightarrow \infty}E[\sup_{k \geq n}X_{k} - Y] &\geq \limsup_{m \geq n}E[X_{m} - Y]\\
E[\limsup_{n \rightarrow \infty}X_{n} - Y] &\geq \limsup_{m \geq n}E[X_{n} - Y]\\
E[\limsup_{n \rightarrow \infty}X_{n}] - E[Y] &\geq \limsup_{m \geq n}E[X_{n}] - E[Y]\\
E[\limsup_{n \rightarrow \infty}X_{n}] &\geq \limsup_{m \geq n}E[X_{n}]\\
\end{aligned}$$

## <a name="dominate"></a>Dominated Convergence Theorem

Consider a sequence of random variables $$X_{n}$$ that converges almost surely to $$X$$.

Suppose there exists a random variable $$Y$$ such that $$\vert X_{n} \vert \leq_{a.s.} Y, \forall n$$ and $$E[Y] < \infty$$. Then:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty}E[X_{n}] = E[X]\\
\end{aligned}$$

Given that:

$$\begin{aligned}
\vert X_{n} \vert &\leq Y\\
-Y \leq X_{n} &\leq Y\\
\end{aligned}$$

We can invoke Fatou's Lemma:

$$\begin{aligned}
E[X] &= E[\liminf\limits_{n \rightarrow \infty}]\\
&\leq \liminf\limits_{n \rightarrow \infty}E[X_{n}]\\
&\leq \limsup\limits_{n \rightarrow \infty}E[X_{n}]\\
&\leq E[\limsup\limits_{n \rightarrow \infty}X_{n}]\\
&= E[X_{n}]\\
\end{aligned}$$

As both ends are equalities, all the inequalities will become equalities. 

Hence:

$$\begin{aligned}
E[X] &= \liminf\limits_{n \rightarrow \infty}E[X_{n}]\\
&= \limsup\limits_{n \rightarrow \infty}E[X_{n}]\\
&= \lim\limits_{n \rightarrow \infty}E[X_{n}]\\
&= E[X]\\
\end{aligned}$$

The difference between MCT and DCT is that we do not require $$\{X_{n}\}$$ to be monotonically increasing but bounded by some $$Y$$ almost surely $$\forall n$$.
