---
layout: post
title: "Transforms"
date: 2021-01-10 01:30:06 +0800
img : 
tags: [probability, measure, expectation]
---

The pmf/pdf to various function transforms we are discussing here are analogous to time to frequency transforms. For example, Probability Generating Function are analogous to Z-Transform, Moment Generating Function are analogous to Laplace Transform and Characteristic Function are analogous to Fourier Transform.

<div class="toc" markdown="1">
# Contents:
- [Probability Generating Function](#pgf)
- [Moment Generating Function](#mgf)
- [Characteristic Function](#characteristic)
- [Moments from Characteristic Function](#moments)
- [References](#references)
</div>

## <a name="pgf"></a>Probability Generating Function

Let $$X$$ be an integer random variable and $$z$$ as a complex number parameter. The PGF is defined as:

$$\begin{aligned}
G_{X}(z) :=\: &E[z^{X}]\\
= & \sum_{i}z^{i}P(X = i)\\
\forall z &\in \mathbb{C}\\
\end{aligned}$$

For the parameter $$z$$, not all values necessarily converges for PGF $$G_{X}(z)$$. We can show that for a nonnegative random variable, there exists $$R$$, such that PGF converges for $$\vert z \vert < R$$ and diverges for $$\vert z \vert > R$$. Note that $$R = \infty$$ is possible.

$$G_{X}(z)$$ certainly converges for $$\vert z \vert < 1$$ the unit circle as:

$$\begin{aligned}
\vert G_{X}(z)\vert &= \vert\sum_{i}z^{i}P(X = i)\vert\\
&\leq \sum_{i}\vert z\vert^{i}\\
\end{aligned}$$

### Poisson Random Variable Example

The PGF of a Poisson random variable $$X$$:

$$\begin{aligned}
G_{X}(z) &= \sum_{i = 1}^{\infty}z^{i}\frac{e^{-\lambda \lambda^{i}}}{i!}\\
&= e^{\lambda(z - 1)}\\
\forall z &\in \mathbb{C}\\
\end{aligned}$$

### Geometric Random Variable Example

The PGF of a geometric random variable $$X$$:

$$\begin{aligned}
G_{X}(z) &= \sum_{i = 1}^{\infty}z^{i}(1 - p)^{i - 1}p\\
&= \frac{pz}{1 - z(1 - p)}\\
\forall z &\in \mathbb{C}\\
\vert z \vert &< \frac{1}{1 - p}\\
\end{aligned}$$

### Property 1

$$\begin{aligned}
G_{X}(1) &= 1\\
\end{aligned}$$

### Property 2

$$\begin{aligned}
\frac{dG_{X}(z)}{dz}\bigg\vert_{z = 1} &= E[X]\\
\end{aligned}$$

To show this:

$$\begin{aligned}
\frac{dG_{X}(z)}{dz} &= \frac{d}{dz}\sum_{i}z^{i}P(X = i)\\
&= \sum_{i}\frac{d}{dz}z^{i}P(X = i)\\
&= \sum_{i}iz^{i - 1}P(X = i)\\
&= \sum_{i}i\times 1 \times P(X = i)\\
&= \sum_{i}iP(X = i)\\
&= E[X]\\
\end{aligned}$$

Note that the series always converges for $$z = 1$$ and the interchange of summation and differential operator is only valid for absolute convergence.

### Property 3

$$\begin{aligned}
\frac{d^{k}G_{X}(z^{k})}{dz}\bigg\vert_{z = 1} &= E[X(X - 1)(X - 2)\cdots (X - k + 1)]\\
\end{aligned}$$

The proof follows from property 2:

$$\begin{aligned}
\frac{d^{k}G_{X}(z^{k})}{dz} &= \frac{d}{dz}\sum_{i}z^{i}P(X = i)\\
&= \sum_{i}\frac{d^{k}}{dz^{k}}z^{i}P(X = i)\\
&= \sum_{i}i(i - 1)\cdots (i - k + 1)z^{i - 1}z^{i - 2}\cdots z^{i - k}P(X = i)\\
&= E[X(X - 1)(X - 2)\cdots (X - k + 1)]\\
\end{aligned}$$

### Property 4

Let $$X, Y$$ be independent random variables. Then:

$$\begin{aligned}
Z &= X + Y\\
\implies G_{Z}(z) &= G_{X}(z)G_{Y}(z)\\
\end{aligned}$$

To show this:

$$\begin{aligned}
G_{Z}(z) &= E[z^{Z}]\\
&= E[z^{X + Y}]\\
&= E[z^{X}z^{Y}]\\
\end{aligned}$$

Because $$X, Y$$ are independent, they are uncorrelated as well. Hence:

$$\begin{aligned}
E[z^{X}z^{Y}] &= E[z^{X}]E[z^{Y}]\\
&= G_{X}(z)G_{Y}(z)\\
\end{aligned}$$

Note that the region of convergence of $$G_{Z}$$ is the intersection of the region of convergence for $$G_{X}, G_{Y}$$.

Similarly, this generalizes to arbitrary number of independent random variables.

Recall from the transformation [post]({% post_url 2020-12-16-transformation %}#sum) that $$Z$$ is the convolution of $$P_{X}$$ and $$P_{Y}$$, and it is analogous to computing convolution by taking Z-Transform from time to frequency domain and multiplying.

### Property 5

Let $$\{X_{i}\}$$ be i.i.d discrete and postive integer valued random variables and random variable $$N$$ which is independent of $$\{X_{i}\}$$.

Then:

$$\begin{aligned}
Y &= \sum_{i = 1}{N}X_{i}\\
\implies G_{Y}(z) &= G_{N}(G_{X}(z))\\
\end{aligned}$$

By invoking Law of Iterated Expectation and property 4:

$$\begin{aligned}
G_{Y}(z) &= E[z^{Y}]\\
&= E\big[E[z^{Y} \mid N]\big]\\
&= E\big[E[z^{\sum_{i}X_{i}} \mid N]\big]\\
&= E\big[E[z^{\sum_{i}x_{i}} \mid N = n]\big]\\
&= E\big[E[\prod_{i}z^{x_{i}} \mid N = n]\big]\\
&= E[G_{X}(z)^{n} \mid N = n]\\
&= E_{N}[G_{X}(z)^{N}]\\
&= G_{N}(G_{X}(z))\\
\end{aligned}$$

<br />
With these 5 properties, we can use them to show expectations and sum of independent random variables from different probability distributions.

## <a name="mgf"></a>Moment Generating Function

The MGF of a random variable $$X$$ is a function $$M_{X}: \mathbb{R} \rightarrow [0, \infty]$$ defined as:

$$\begin{aligned}
M_{X}(s) &= E[e^{sX}]\\
\end{aligned}$$

The domain or region of convergence is the set:

$$\begin{aligned}
\{s \mid M_{X}(s) < \infty\}\\
\end{aligned}$$

If $$X$$ is discrete:

$$\begin{aligned}
M_{X}(s) &= \sum_{x}e^{sx}p_{X}(x)\\
\end{aligned}$$

If $$X$$ is continuous:

$$\begin{aligned}
M_{X}(s) &= \int_{x}e^{sx}f_{X}(x)dx\\
\end{aligned}$$

Note that in the continuous case, the equation is analogous to Laplace Transform except in Laplace Transform it is $$-s$$.

### Exponential Random Variable Example

$$\begin{aligned}
M_{X}(s) &= \int_{0}^{\infty}e^{sx}\lambda e^{-\lambda x}dx\\
&= \begin{cases}
\frac{\lambda}{\lambda - s}, \: &\text{if } s < \lambda,\\
\infty, \: &\text{otherwise}\\
\end{cases}\\
\forall x &\geq 0\\
s &\in \mathbb{R}\\
\end{aligned}$$

Hence the region of convergence is $$s < \lambda$$. This is the case because $$e^{-\lambda x}$$ decreases faster than $$e^{sx}$$.

### Standard Normal Random Variable Example

$$\begin{aligned}
M_{X}(s) &= \frac{1}{\sqrt{2\pi}}\int_{-\infty}^{\infty}e^{sx}e^{\frac{-x^{2}}{2}}dx\\
&= e^{\frac{s^{2}}{2}}\int_{-\infty}^{\infty}\frac{1}{\sqrt{2\pi}}e^{\frac{-(x - s)^{2}}{2}}dx\\
&= e^{\frac{s^{2}}{2}}\\
\forall x &\in \mathbb{R}\\
s &\in \mathbb{R}\\
\end{aligned}$$

The region of convergence in this example is the whole real line as $$e^{-\frac{x^{2}}{2}}$$ decreases faster than $$e^{sx}$$ for all $$x \in \mathbb{R}$$.

<br />

Note that the MGF is analytic. In other words, if $$M_{X}(s)$$ is finite in the interval $$s \in [-\epsilon, \epsilon]$$ for some $$\epsilon >0$$, then $$M_{X}(s)$$ uniquely determines the CDF of $$X$$. However, if the MGF is only finite for a single point (Cauchy distribution is an example), then we cannot determine the CDF uniquely from the MGF.

Hence, if $$X, Y$$ are two random variables such that:

$$\begin{aligned}
M_{X}(s) &= M_{Y}(s)\\
\forall s &\in [-\epsilon, \epsilon]\\
\exists \epsilon &> 0\\
\end{aligned}$$

Then $$X, Y$$ have the same CDF.

### Property 1

$$\begin{aligned}
M_{X}(0) &= 1\\
\end{aligned}$$

### Property 2

Suppose $$M_{X}(s) < \infty$$ for $$s \in [-\epsilon, \epsilon], \epsilon > 0$$. Then:

$$\begin{aligned}
\frac{d}{ds}M_{X}(s)\vert_{s = 0} &= E[X]\\
\end{aligned}$$

More generally:

$$\begin{aligned}
\frac{d^{m}}{ds^{m}}M_{X}(s)\vert_{s = 0} &= E[X^{m}]\\
\end{aligned}$$

Property 2 is how the MGF got its name.

To show this:

$$\begin{aligned}
\frac{d}{ds}M_{X}(s) &= \frac{d}{ds}E[e^{sX}]\\
&= E[\frac{d}{ds}e^{sX}]\\
&= E[Xe^{sX}]\\
\end{aligned}$$

Similarly for the general case:

$$\begin{aligned}
\frac{d^{m}}{ds^{m}}M_{X}(s) &= \frac{d^{m}}{ds^{m}}E[e^{sX}]\\
&= E[\frac{d^{m}}{ds^{m}}e^{sX}]\\
&= E[X^{m}e^{sX}]\\
\end{aligned}$$

Note that the interchange of the derivative and the expectation requires a proof. Basically it involves invoking the DCT which we will not do here.

### Property 3

$$\begin{aligned}
Y &= aX + b\\
\implies M_{Y}(s) &= e^{sb}M_{X}(as)\\
\end{aligned}$$

This follows from the definition of MGF.

For example:

$$\begin{aligned}
X &\sim \mathcal{N}(0, 1)\\
Y &\sim \mathcal{N}(\mu, \sigma^{2})\\
Y &= \sigma X + \mu\\
\implies M_{Y}(s) &= e^{\mu s}M_{X}(\sigma s)\\
&= e^{\mu s}e^{\sigma^{2}\frac{s^{2}}{2}}\\
\end{aligned}$$

### Property 4

Let $$X, Y$$ be independent random variables. Then:

$$\begin{aligned}
Z &= X + Y\\
\implies M_{Z}(s) &= M_{X}(s)M_{Y}(s)\\
\end{aligned}$$

To show this:

$$\begin{aligned}
M_{Z}(s) &= E[e^{sZ}]\\
&= E[e^{sX + sY}]\\
&= E[e^{sX}e^{sY}]\\
&= E[e^{sX}]E[e^{sY}]\\
&= M_{X}(s)M_{Y}(s)\\
\end{aligned}$$

For example, let $$X, Y$$ be independent normal random variables and:

$$\begin{aligned}
X &\sim \mathcal{N}(\mu_{X}, \sigma_{X}^2)\\
Y &\sim \mathcal{N}(\mu_{Y}, \sigma_{Y}^2)\\
Z &= X + Y\\
\end{aligned}$$

With the following MGF:

$$\begin{aligned}
M_{X}(s) &= e^{\mu_{X}s + \frac{\sigma_{X}^{2}s^{2}}{2}}\\
M_{Y}(s) &= e^{\mu_{Y}s + \frac{\sigma_{Y}^{2}s^{2}}{2}}\\
M_{Z}(s) &= M_{X}(s) + M_{Y}(s)\\
&= e^{(\mu_{X} + \mu_{Y})s + \frac{(\sigma_{X}^{2} + \sigma_{Y}^{2})s^{2}}{2}}\\
\end{aligned}$$

And this implies that:

$$\begin{aligned}
Z &\sim \mathcal{N}(\mu_{X} + \mu_{Y}, \sigma_{X}^2 + \sigma_{Y}^{2})\\
\end{aligned}$$

Let's do another example. Let $$X, Y$$ be independent exponential random variables and:

$$\begin{aligned}
X &\sim \text{Exp}(\lambda_{X})\\
Y &\sim \text{Exp}(\lambda_{Y})\\
Z &= X + Y\\
\end{aligned}$$

With the following MGF:

$$\begin{aligned}
M_{X}(s) &= \frac{\lambda_{X}}{\lambda_{X} - s}\\
M_{Y}(s) &= \frac{\lambda_{Y}}{\lambda_{Y} - s}\\
M_{Z}(s) &= M_{X}(s) + M_{Y}(s)\\
&= \frac{\lambda_{X}\lambda_{Y}}{(\lambda_{X} - s)(\lambda_{Y} - s)}\\[7pt]
\forall s &< \text{min}(\lambda_{X}, \lambda_{Y})\\
\end{aligned}$$

Using partial fractions and inverting the transform, we will get the following distribution:

$$\begin{aligned}
f_{Z}(z) &= \frac{\lambda_{X}}{\lambda_{X} - \lambda_{Y}}\lambda_{Y}e^{-\lambda_{Y}z} - \frac{\lambda_{Y}}{\lambda_{X} - \lambda_{Y}}\lambda_{X}e^{-\lambda_{X}z}\\
&= \frac{\lambda_{X}\lambda_{Y}}{\lambda_{X} - \lambda_{Y}}(e^{-\lambda_{X}z} - e^{-\lambda_{Y}}z)\\
\forall z &\geq 0\\
\end{aligned}$$

### Property 5

Let $$Z = \sum_{i = 1}{N}X_{i}$$ and $$\{X_{i}\}$$ are i.i.d. and $$N$$ is a random variable independent of $$\{X_{i}\}$$. Then:

$$\begin{aligned}
M_{Z}(s) &= E[e^{sZ}]\\
&= E[E[e^{sZ} \mid N]]\\
&= E[M_{X}(s)^{N}]\\
\end{aligned}$$

In terms of both PGF and MGF of $$Z$$ (outer function is PGF and inner function is MGF):

$$\begin{aligned}
M_{Z}(s) &= G_{N}(M_{X}(s))\\
&= M_{N}(log(M_{X}(s)))
\end{aligned}$$

For example, let:

$$\begin{aligned}
X_{i} &\sim \text{Exp}(\lambda)\\
N &\sim \text{Geom(p)}\\
Z &= \sum_{i = 1}^{N}X_{i}\\
\end{aligned}$$

Then for the MGF $$M_{X}(s)$$ and the PGF $$G_{N}(z)$$:

$$\begin{aligned}
M_{X}(s) &= \frac{\lambda}{\lambda - s}\\
\forall s &< \lambda\\

G_{N}(z) &= \frac{pz}{1 - (1 - p)z}\\
\forall \vert z \vert &< \frac{1}{1 - p}\\

M_{Z}(s) &= G_{N}(M_{X}(s))\\
&= \frac{p\frac{\lambda}{\lambda - s}}{1 - (1 - p)(\frac{\lambda}{\lambda - s})}\\
&= \frac{\lambda p}{\lambda p - s}\\
\forall s &< \lambda p\\
\end{aligned}$$

This implies that:

$$\begin{aligned}
Z &\sim \text{Exp}(\lambda p)\\
\end{aligned}$$

## <a name="characteristic"></a>Characteristic Function

Let $$X$$ be a random variable and the characteristic function is defined as:

$$\begin{aligned}
C_{X}(t) :=\: &E[e^{itX}]\\
=\: &E[cos(tX) + isin(tx)]\\
=\: &E[cos(tX)] + iE[sin(tx)]\\
\forall t \in\: &\mathbb{R}\\
\end{aligned}$$

Alternatively, it can be written as:

$$\begin{aligned}
C_{X}(t) &= \int_{\Omega}e^{itx}dP_{X}\\
\end{aligned}$$

And if $$X$$ is a continuous random variable:

$$\begin{aligned}
C_{X}(t) &= \int_{-\infty}^{\infty}e^{itx}f_{X}(x)dx\\
\end{aligned}$$

As you can see from the above equation, the characteristic function is analogous to the fourier transform function.

In comparison with the moment generating function, the characteristic function always exists and is finite unlike the MGF which might only exists at $$s = 0$$. Furthermore, the inverse of the characteristic function is easier to do than the inverse of MGF.

### Exponential Random Variable Example

Let $$X$$ be an exponential random variable with parameter $$\lambda$$.

The characteristic function is:

$$\begin{aligned}
C_{X}(t)&= \int_{x = 0}^{\infty}\lambda e^{-\lambda x}e^{itx}dx\\
&= \frac{\lambda}{\lambda - it}\\
\forall t &\in \mathbb{R}\\
\end{aligned}$$

Note that because $$\lambda - it$$ is a complex number, we would need to perform contour integration to arrive at the example. However in the exponential random variable example, the computation is the same as if we treat $$\lambda - it$$ as a real number.

### Cauchy Random Variable Example

Let $$X$$ be a Cauchy random variable. The characteristic function is:

$$\begin{aligned}
C_{X}(t) &= \int_{-\infty}^{\infty}e^{itx}\frac{1}{\pi(1 + x^{2})}dx\\
&= e^{-\vert t \vert}\\
\forall t &\in \mathbb{R}\\
\end{aligned}$$

Note the above contour integration is not trivial to perform. However we can get the result by looking at the Fourier transform table and do a duality trick. Also note that for MGF, Cauchy random variable converges only at $$s = 0$$ while characteristic function exists everwhere and converges absolutely and uniformly. Hence characteristic functions are especially usefull for handling heavy-tailed random variables such as Cauchy.

### Property 1

Let $$Y = aX + b$$. Then from the definition of characteristic function:

$$\begin{aligned}
C_Y{t} &= e^{ibt}C_{X}(at)\\
\end{aligned}$$

### Property 2

Let $$X, Y$$ be independent random variables and $$Z = X + Y$$. Then:

$$\begin{aligned}
C_{Z}(t) &= C_{X}(t)C_{Y}(t)\\
\end{aligned}$$

To show this:

$$\begin{aligned}
C_Z{t} &= E[e^{itZ}]\\
&= E[e^{it(X + Y)}]\\
&= E[e^{itX}e^{itY}]\\
&= E[e^{itX}]E[e^{itY}]\\
&= C_{X}(t)C_{Y}(t)\\
\end{aligned}$$

### Property 3

If the MGF $$M_{X}(s) < \infty$$ for some $$s \in [-\epsilon, \epsilon]$$, then:

$$\begin{aligned}
C_{X}(t) &= M_{X}(it)\\
\forall t &\in \mathbb{R}\\
\end{aligned}$$

For example, let $$X \sim \mathcal{N}(0, 1)$$. Given that the MGF:

$$\begin{aligned}
M_{X}(s) &= e^{\frac{s^{2}}{2}}\\
\end{aligned}$$

Then the characteristic function is:

$$\begin{aligned}
C_{X}(t) &= M_{X}(it)\\
&= e^{\frac{-t^{2}}{2}}\\
\end{aligned}$$

And by invoking property 1, we get the non-standard Gaussian $$X \sim \mathcal{N}(\mu, \sigma^{2})$$:

$$\begin{aligned}
C_{X}(t) &= e^{i\mu t}e^{\frac{-\sigma^{2}t^{2}}{2}}\\
&= e^{i\mu t - \frac{\sigma^{2}t^{2}}{2}}\\
\end{aligned}$$

### Inverse Functions

If two random variables have the same characteristic function, then they have the same CDF. Furthermore, if $$X$$ is a continuous random variable, then one is able to convert the characteristic function into the CDF:

$$\begin{aligned}
f_{X}(s) &= \lim\limits_{T \rightarrow \infty}\frac{1}{2\pi}\int_{-T}^{T}e^{-itx}C_{X}(t)dt\\
\end{aligned}$$

The above is true for every $$x$$ where $$f_{X}(x)$$ is differentiable.

Also if the characteristic function is absolutely integrable:

$$\begin{aligned}
\int_{-\infty}^{\infty}\vert C_{X}(t) \vert dt < \infty\\
\end{aligned}$$

Then the pdf exists.

For noncontinuous function, there is a way to recover the CDF, but we are not going to cover it here. But do note that at points of discontinuity, the CDF will take the midpoint rather than the right-continuity of CDF.

### Defining Property 1

$$\begin{aligned}
C_{X}(0) &= 1\\
\vert C_{X}(t)\vert &\leq 1\\
\forall t &\in \mathbb{R}\\
\end{aligned}$$

To show this for $$C_{X}(0)$$:

$$\begin{aligned}
C_{X}(0) &= E[e^{i0X}]\\
&= 1\\
\end{aligned}$$

And by the Cauchy Schwarz inequality:

$$\begin{aligned}
\vert C_{X}(t)\vert &= \vert \int_{\Omega}e^{itx}dP_{X}\vert\\
&\leq \int_{\Omega}\vert e^{itx} \vert dP_{X}\\
&= 1\\
\end{aligned}$$

### Defining Property 2

$$C_{X}(t)$$ is uniformly continuous on $$\mathbb{R}$$:

$$\begin{aligned}
\vert C_{X}(t +h) - C_{X}(t)\vert &\leq \phi(h)\\
\forall t &\in \mathbb{R}\\
\exists \phi(h) &\rightarrow \lim\limits_{h \rightarrow 0}\phi(h) = 0\\
\end{aligned}$$

Uniform continuity is a stronger condition than continuity but weaker than differentiability. Note also that the continuity doesn't depend on $$t$$ which is how the name uniform comes about.

To show this:

$$\begin{aligned}
\vert C_{X}(t +h) - C_{X}(t)\vert &= \vert E[e^{i(t + h)X}] - E[e^{itX}]\vert\\
&= \vert E[e^{itX}(e^{ihX} - 1)]\\
&\leq E[\vert e^{ihX} - 1 \vert]\\
\end{aligned}$$

Expanding $$\vert e^{ihX} - 1 \vert$$:

$$\begin{aligned}
\vert e^{ihX} - 1 \vert &= \sqrt{(cosh(hX) - 1)^{2} + (sin (hX))^{2}}\\
&= \sqrt{2 - 2cos(hX)}\\
&= 2 sin(\frac{hX}{2})\\
&\leq 2
\end{aligned}$$

Hence we can see that the above equation is bounded above by 2. 

Applying DCT we have:

$$\begin{aligned}
\phi(h) &= E[\vert e^{ihX} - 1 \vert]\\
\lim\limits_{h \rightarrow 0}\phi(h) &= \lim\limits_{h \rightarrow 0}E[\vert e^{ihX} - 1 \vert]\\
&= E[\lim\limits_{h \rightarrow 0}\vert e^{ihX} - 1 \vert]\\
&= E[\vert 1 - 1 \vert]\\
&= 0\\
\end{aligned}$$

### Defining Property 3

$$C_{X}(t)$$ is a nonnegative definite kernel:

$$\begin{aligned}
\sum_{j, k}z_{j}C_{X}(t_{j} - t_{k})\overline{z_{k}} &\geq 0\\
\forall t_{1}, \cdots, t_{n} &\in \mathbb{R}\\
\forall z_{1}, \cdots, z_{n} &\in \mathbb{C}\\
\end{aligned}$$

To show this, first note that the complex quadratic form for all $$t_{j, k}, z_{j, k}$$ are nonzero:

$$\begin{aligned}
\sum_{j, k}z_{j}C_{X}(t_{j} - t_{k})\overline{z_{k}} &\geq 0\\
\end{aligned}$$

Then:

$$\begin{aligned}
\sum_{j, k}z_{j}C_{X}(t_{j} - t_{k})\overline{z_{k}} &= \sum_{j, k}\int_{\Omega}z_{j}e^{i(t_{j} - t_{k})X}\overline{z_{k}}dP_{X}\\
&= \sum_{j, k}\int_{\Omega}(z_{j}e^{it_{j}X})(\overline{z_{k}e^{it_{k}X}})dP_{X}\\
&= \sum_{j, k}E[z_{j}e^{it_{j}X}\overline{z_{k}e^{it_{k}X}}]\\
&= E[\sum_{j, k}z_{j}e^{it_{j}X}\overline{z_{k}e^{it_{k}X}}]\\
&\geq E[\sum_{j}\vert z_{j}e^{it_{j}X} \vert^{2}]\\
&\geq 0\\
\end{aligned}$$

<br />

The above 3 properties are defining in the sense that if these three properties are satisfied for an arbitrary function, then the function must be a characteristic function of some random variable. In other words, the converse is also true. This is known as the Bochner's theorem.

## <a name="moments"></a>Moments from Characteristic Function

Let $$X$$ be a random variable with a characteristic function $$C_{X}(t)$$. If $$\frac{d^{k}C_{X}(t)}{dt^{k}}$$ exists at $$t = 0$$, then:

(i) when $$k$$ is even:

$$\begin{aligned}
E[\vert X^{k} \vert] < \infty
\end{aligned}$$

(ii) when $$k$$ is odd:

$$\begin{aligned}
E[\vert X^{k - 1} \vert] < \infty
\end{aligned}$$

And then if $$E[\vert X^{k} \vert] < \infty$$, then:

$$\begin{aligned}
i^{k}E[\vert X^{k} \vert] &= \frac{d^{k}C_{X}(t)}{dt^{k}} \bigg \vert_{t = 0}\\
\end{aligned}$$

Furthermore one can do a Taylor expansion on the characteristic function:

$$\begin{aligned}
C_{X}(t) &= \sum_{j = 0}^{k}\frac{E[X^{j}]}{j!}(it)^{j} + \mathcal{o}(t^{k})\\
\end{aligned}$$

## <a name="references"></a>References

[YouTube Mod-01 Lec-38 MMSE Estimator, Transforms](https://www.youtube.com/watch?v=8LM6qqomHzY&list=PLbMVogVj5nJQqGHrpAloTec_lOKsG-foc&index=38&ab_channel=nptelhrd)
<br />
[Krishna Jagannathan lecture24_pgf.pdf](http://www.ee.iitm.ac.in/~krishnaj/EE5110_files/notes/lecture24_pgf.pdf)

