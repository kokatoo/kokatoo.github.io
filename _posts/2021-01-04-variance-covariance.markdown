---
layout: post
title: "Variance and Covariance"
date: 2021-01-04 01:30:06 +0800
img : 
tags: [probability, measure, cauchy-schwarz, hilbert]
---

In this post we will talk about variance and covariance of random variables.

<div class="toc" markdown="1">
# Contents:
- [Variance](#variance)
- [Covariance](#covariance)
- [Sum of Variances](#sum)
- [Correlation](#correlation)
- [Cauchy-Schwarz Inequality](#cauchy)
- [Hilbert Space](#hilbert)
- [References](#references)
</div>

## <a name="variance"></a>Variance

The variance of $$X$$ given that $$E[X] < \infty$$ is defined as:

$$\begin{aligned}
Var(X) :=\: &E[(X - E[X])^{2}]\\
=\: &\sigma_{X}^{2}\\
\end{aligned}$$

We can easily see that the variance of $$X$$ is nonnegative because of $$X - E[X] \geq 0$$. 

In fact, $$\sigma_{X}^{2} = 0$$ iff X is a constant almost surely:

If $$X$$ is a constant, $$X$$ has to be equal to $$E[X]$$:

$$\begin{aligned}
X &= E[X]\\
\therefore X -\: &E[X] = 0\\
\end{aligned}$$

To prove the other direction:

$$\begin{aligned}
E[(X - E[X])^{2}] &= 0\\
\implies
\int_{\Omega} (X - E[X])^{2} dP_{X} &= 0\\
\end{aligned}$$

In the properties of integrals, we showed that given above integral $$\int_{\Omega} (X - E[X])^{2} dP_{X} = 0$$, we can conclude that $$(X - E[X])^{2} = 0$$ almost surely and therefore $$X = E[X]$$, which make $$X$$ a constant.

There is another way to represent variance which is often easier to compute:

$$\begin{aligned}
\sigma_{X}^{2} &= E[(X - E[X])^{2}]\\
&= E[X^{2} - 2XE(X) + E(X^{2})]\\
&= E[X^{2}] - 2E(X)E(X) + E[X]^{2}\\
&= E[X^{2}] - 2E(X)^{2} + E[X]^{2}\\
&= E[X^{2}] - E[X]^{2}\\
\end{aligned}$$

As variance is always nonnegative, we can conclude that:

$$\begin{aligned}
E[X^{2}] \geq E[X]^{2}\\
\end{aligned}$$

This is due to [Jensen's Inequality]({% post_url 2020-11-07-transformation %}#jensen) as $$X^{2}$$ is a convex function.

Let's do some examples:

### Bernoulli Random Variable

Let $$X$$ be a Bernoulli random variable with parameter $$p$$:

$$\begin{aligned}
E[X] &= p \times 1 + (1 - p) \times 0\\
&= p\\
E[X^{2}] &= p \times 1^{2} + (1 - p) \times 0^{2}\\
&= p\\
\sigma_X^{2} &= E[X^{2}] - E[X]^{2}\\
&= p - p^{2}\\
&= p(1 - p)\\
\end{aligned}$$

### Poisson Random Variable

Let $$X$$ be a Poisson random variable with parameter $$\lambda$$:

$$\begin{aligned}
E[X] &= \sum_{k = 0}^{\infty}k\frac{e^{-\lambda}\lambda^{k}}{k!}\\
&= 0 + \sum_{k = 1}^{\infty}k\frac{e^{-\lambda}\lambda^{k}}{k!}\\
&= \sum_{k = 1}^{\infty}\frac{e^{-\lambda}\lambda^{k}}{(k - 1)!}\\
&= \lambda e^{-\lambda} \sum_{k = 1}^{\infty}\frac{\lambda^{k - 1}}{(k - 1)!}\\
&= \lambda e^{-\lambda}\bigg(\frac{\lambda^{0}}{0!} + \frac{\lambda^{1}}{1!} + \frac{\lambda^{2}}{2!} + \: \cdots \bigg)\\
&= \lambda e^{-\lambda} \sum_{k = 0}^{\infty}\frac{\lambda^{k}}{k!}\\
&= \lambda e^{-\lambda} e^{\lambda}\\
&= \lambda\\
E[X^{2}] &= \sum_{k = 0}^{\infty}k^{2}\frac{e^{-\lambda}\lambda^{k}}{k!}\\
&= \sum_{k = 0}^{\infty}k\frac{\lambda e^{-\lambda}\lambda^{k - 1}}{(k - 1)!}\\
&= \sum_{k = 0}^{\infty}\frac{\lambda\big((k - 1) + 1\big)e^{-\lambda}\lambda^{k - 1}}{(k - 1)!}\\
&= \lambda^{2} e^{-\lambda} \sum_{k = 2}^{\infty}\frac{\lambda^{k - 2}}{(k - 2)!} + \lambda e^{-\lambda} \sum_{k = 1}^{\infty}\frac{\lambda^{k - 1}}{(k - 1)!}\\
&= \lambda^{2} + \lambda\\[7pts]
\sigma_X^{2} &= E[X^{2}] - E[X]^{2}\\
&= \lambda^{2} + \lambda - \lambda^{2}\\
&= \lambda\\
\end{aligned}$$

## <a name="covariance"></a>Covariance

Let $$X, Y$$ be two random variables on $$(\Omega, \mathcal{F}, P)$$ and $$E[X] < \infty, E[Y] < \infty$$. The covariance is defined as:

$$\begin{aligned}
Cov(X, Y) :=\: &E[(X - E[X])(Y - E[Y])]\\
=\: &E[XY] - E[X]E[Y]\\
=\: &\sigma_{X, Y}\\
\end{aligned}$$

Let $$X, Y$$ be two random variables on $$(\Omega, \mathcal{F}, P)$$ and $$E[X] < \infty, E[Y] < \infty$$. If $$X, Y$$ are independent random variables, then:

$$\begin{aligned}
E[XY] &= E[X]E[Y]\\
\sigma_{X, Y} &= 0\\
\end{aligned}$$

First we will show this hold for simple functions:

$$\begin{aligned}
X &= \sum_{i = 1}^{m}x_{i}I_{A{i}}\\
Y &= \sum_{i = 1}^{n}y_{i}I_{B{i}}\\
\end{aligned}$$

Assuming canonical representation:

$$\begin{aligned}
XY = \sum_{i = 1}^{m}\sum_{j = 1}^{n}(x_{i}y_{j})I_{A_{i}\cap B_{j}}\\
\end{aligned}$$

Then:

$$\begin{aligned}
E[XY] &= \int_{\Omega}XY dP\\
&= \sum_{i = 1}^{m}\sum_{j = 1}^{n}(x_{i}y_{j})P(A_{i}\cap B_{j})\\
\end{aligned}$$

From the definition of independence:

$$\begin{aligned}
P(A_{i}\cap B_{j}) &= P(A_{i})P(B_{j})\\
\forall &i, j\\
\end{aligned}$$

Hence:

$$\begin{aligned}
E[XY] &= \sum_{i = 1}^{m}\sum_{j = 1}^{n}(x_{i}y_{j})P(A_{i}\cap B_{j})\\
&= \sum_{i = 1}^{m}\sum_{j = 1}^{n}(x_{i}y_{j})P(A_{i})P(B_{j})\\
&= \sum_{i = 1}^{m}P(A_{i})x_{i}\sum_{j = 1}^{n}y_{j}P(B_{j})\\
&= E[X]E[Y]\\
\end{aligned}$$

Next we will show this for nonnegative functions.

Let $$X_{n}, Y_{n}$$ be simple random variables that converges from below to $$X, Y$$.

Then by invoking MCT and the fact that simple functions $$X_{n}Y_{n}$$ were shown to be independent from above:

$$\begin{aligned}
E[XY] &= E[\lim\limits_{n \rightarrow \infty}X_{n}\lim\limits_{n \rightarrow \infty}Y_{n}]\\
&= \lim\limits_{n \rightarrow \infty}E[X_{n}Y_{n}]\\
&= \lim\limits_{n \rightarrow \infty}E[X_{n}]\lim\limits_{n \rightarrow \infty}E[Y_{n}]\\
&= E[\lim\limits_{n \rightarrow \infty}X_{n}]E[\lim\limits_{n \rightarrow \infty}Y_{n}]\\
&= E[X]E[Y]\\
\end{aligned}$$

For the general functions, we would need to expand out the positive and negative parts.

First let:

$$\begin{aligned}
X &= X_{+} - X_{-}\\
Y &= Y_{+} - Y_{-}\\
\end{aligned}$$

Then we would expand out $$E[XY]$$ and invoke the linearity of expectations:

$$\begin{aligned}
E[XY] &= E[(X_{+} - X_{-})(Y_{+} - Y_{-})]\\
&= E[X_{+}Y_{+} - X_{+}Y_{-} - X_{-}Y_{-} + X_{-}Y_{-}]\\
&= E[X_{+}Y_{+}] - E[X_{+}Y_{-}] - E[X_{-}Y_{-}] + E[X_{-}Y_{-}]\\
&= E[X_{+}]E[Y_{+}] - E[X_{+}]E[Y_{-}] - E[X_{-}]E[Y_{-}] + E[X_{-}]E[Y_{-}]\\
&= E[X_{+}](E[Y_{+} - Y_{-}]) - E[X_{-}](E[Y_{+}] - E[Y_{-}])\\
&= (E[X_{+}] - E[X_{-}])(E[Y_{+}] - E[Y_{-}])\\
&= E[X]E[Y]\\
\end{aligned}$$

## <a name="sum"></a>Sum of Variances

Consider two random variables $$X,Y$$. Then:

$$\begin{aligned}
Var(X + Y) &= Var(X) + Var(Y) + 2Cov(X, Y)\\
\end{aligned}$$

From the definition of variance, we can see that:

$$\begin{aligned}
Var(X + Y) &= E[(X + Y)^{2}] - (E[X + Y])^{2}\\
&= E[X^{2} + 2XY + Y_{2}] - (E[X] + E[Y])^{2}\\
&= E[X^{2}] + 2E[XY] + E[Y_{2}] - E[X]^{2} - 2E[X]E[Y] - E[Y]^{2}\\
&= \big(E[X^{2}] - E[X]^{2}\big) + \big(E[Y_{2}] - E[Y]^{2}\big) - 2\big(E[XY] - E[X]E[Y]\big)\\
&= Var(X) + Var(Y) - 2Cov(X, Y)\\
\end{aligned}$$

And to generalize the sum of variances:

$$\begin{aligned}
Var(\sum_{i = 1}^{n}) &= \sum_{i = 1}^{n}\sum_{j = 1}^{n}Cov(X_{i}, X_{j})\\
&= \sum_{i = 1}^{n}Var(X_{i}) + 2 \times \sum_{1 \leq i < j \leq n}Cov(X_{i}, X_{j})\\
\end{aligned}$$

## <a name="correlation"></a>Correlation

The correlation coefficient for two random variables $$X, Y$$ is defined as:

$$\begin{aligned}
\rho_{X, Y} := \: &\frac{Cov(X, Y)}{\sqrt{Var(X)Var(Y)}}\\
= &\frac{\sigma_{X, Y}}{\sigma_{X}\sigma_{Y}}\\
\end{aligned}$$

We can see from the definition that the correlation is a scaled version of the covariance.

## <a name="cauchy"></a>Cauchy-Schwarz Inequality

For any two random variables $$X, Y$$, we have:

$$\begin{aligned}
-1 \leq \rho_{X, Y} \leq 1\\
\end{aligned}$$

Furthermore, if $$\rho_{X, Y} = 1$$ then there exists a constant $$a > 0$$ such that:

$$\begin{aligned}
Y - E[Y] &= a(X - E[X])\\
\end{aligned}$$

Similarly, if $$\rho_{X, Y} = -1$$ then there exists a constant $$a < 0$$ such that:

$$\begin{aligned}
Y - E[Y] &= a(X - E[X])\\
\end{aligned}$$

In other words:

$$\begin{aligned}
Cov(X, Y)^{2} \leq Var(X)Var(Y)\\
\end{aligned}$$

To show this, first let:

$$\begin{aligned}
\hat{X} &= X - E[X]\\
\hat{Y} &= Y - E[Y]\\
\end{aligned}$$

And we can see that the below inequality is true because of the inner square term:

$$\begin{aligned}
E\bigg[\hat{X} - \frac{E[\hat{X}\hat{Y}]}{E[\hat{Y}]^{2}}\hat{Y}\bigg] \geq 0\\
\end{aligned}$$

Then:

$$\begin{aligned}
E\bigg[\big(\hat{X} - \frac{E[\hat{X}\hat{Y}]}{E[\hat{Y}]^{2}}\hat{Y}\big)^{2}\bigg] &\geq 0\\
E\bigg[\hat{X}^{2} - 2\hat{X}\frac{E[\hat{X}\hat{Y}]}{E[\hat{Y}^{2}]}\hat{Y} + \frac{E[\hat{X}\hat{Y}]^{2}}{E[\hat{Y}^{2}]^{2}}\hat{Y}^{2}\bigg] &\geq 0\\
E[\hat{X}^{2}] - 2E[\hat{X}]\frac{E[\hat{X}\hat{Y}]}{E[\hat{Y}^{2}]}E[\hat{Y}] + \frac{E[\hat{X}\hat{Y}]^{2}}{E[\hat{Y}^{2}]^{2}}E[\hat{Y}^{2}] &\geq 0\\
E[\hat{X}^{2}] - \frac{E[\hat{X}\hat{Y}]^{2}}{E[\hat{Y}^{2}]^{2}}E[\hat{Y}^{2}] &\geq 0\\
E[\hat{X}^{2}] \geq \frac{E[\hat{X}\hat{Y}]^{2}}{E[\hat{Y}^{2}]}\: &\\
E[\hat{X}^{2}]E[\hat{Y}^{2}] \geq E[\hat{X}\hat{Y}]^{2}\: &\\
\sqrt{E[\hat{X}^{2}]E[\hat{Y}^{2}]} \geq \sqrt{E[\hat{X}\hat{Y}]^{2}} &\geq -\sqrt{E[\hat{X}^{2}]E[\hat{Y}^{2}]}\\
-\sqrt{E[\hat{X}^{2}]E[\hat{Y}^{2}]} \leq E[\hat{X}\hat{Y}] &\leq \sqrt{E[\hat{X}^{2}]E[\hat{Y}^{2}]}\\
-1 \leq \frac{E[\hat{X}\hat{Y}]}{\sqrt{E[\hat{X}^{2}]}\sqrt{E[\hat{Y}^{2}]}} &\leq 1\\
-1 \leq \frac{(X - E[X])(Y - E[Y])}{\sqrt{E[(X - E[X])^{2}]}\sqrt{E[(Y - E[Y])^{2}]}} &\leq 1\\[10pts]
-1 \leq \frac{\sigma_{X, Y}}{\sigma_{X}\sigma_{Y}} &\leq 1\\
-1 \leq \rho_{X, Y} &\leq 1\\
\end{aligned}$$

Hence when $$\vert \rho_{X, Y} \vert = 1$$ then:

$$\begin{aligned}
a &= \frac{E\big[\hat{X}\hat{Y}]}{E[\hat{Y}\big]^{2}}\\
&= \frac{E\big[(X - E[X])(Y - E[Y])\big]}{E[(Y - E[Y])^{2}]}\\
\end{aligned}$$

## <a name="hilbert"></a>Hilbert Space

When one talks about Cauchy-Schwarz inequality, one would usually think of inner products in the Euclidean space. Instead of Euclidean space, what we have is a Hilbert Space, which is a complete vector space. To give the notion of zero, we will let $$\mathcal{L}_{2}$$ be a collection of zero-mean real random variables defined over a $$(\Omega, \mathcal{F}, P)$$ probability space. It can be shown that $$\mathcal{L}_{2}$$ with addition of function additions and scalar multiplication is a Hilbert Space. The equivalent of an inner/dot product is the covariance function and the correlation can be interpreted as the cosine of the angle between two random variables. Furthermore, a correlation zero implies orthogonal random variables.

We say that two random variables are equivalent if they have the same probability except on a set of measure zero:

$$\begin{aligned}
&X \sim Y\\
\implies &P(X = Y)\\
\forall &X, Y \in \mathcal{L_{2}}\\
\end{aligned}$$

In other words, $$\mathcal{L}_{2}$$ is partitioned into several equivalence relations based on the aboce.

## <a name="references"></a>References

[YouTube Mod-01 Lec-35 VARIANCE AND COVARIANCE](https://www.youtube.com/watch?v=SQl4_jpVfZU&list=PLbMVogVj5nJQqGHrpAloTec_lOKsG-foc&index=35&ab_channel=nptelhrd)
<br />
[Krishna Jagannathan lecture22_variance_covariance.pdf](http://www.ee.iitm.ac.in/~krishnaj/EE5110_files/notes/lecture22_variance_covariance.pdf)
