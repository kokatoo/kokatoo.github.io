---
layout: post
title: "Transformation of Random Variables"
date: 2020-12-15 01:30:06 +0800
img : sumrand.png
tags: [probability, measure, erlang, chi-square, convolution, rayleigh, jacobian]
---

Sometimes we might be interested not in the random variables per se, but some function of the random variables. It can be showed that if the transformation function $$f: \mathbb{R}^{n} \rightarrow \mathbb{R}$$ is Borel measurable, then the composition of $$f \circ X$$ is also a random variable on $$(\Omega, \mathcal{F}, P)$$. 

<div class="toc" markdown="1">
# Contents:
- [Maximum and Minimum Functions](#max)
- [Sum of Random Variables](#sum)
- [Sum of Random Number of Random Variables](#sumrand)
- [General Transformation](#general)
- [Jacobian Transformation](#jacobian)
</div>

## <a name="max"></a>Maximum and Minimum Functions

Let $$X_{1}, X_{2},\: \cdots, X_{n}$$ be random variables on $$(\Omega, \mathcal{F}, P)$$ with joint CDF $$F_{X_{1}, X_{2},\: \cdots, X_{n}}(x_{1}, x_{2},\: \cdots, x_{n})$$. And let:

$$\begin{aligned}
Y_{n} &= min(X_{1}, X_{2},\: \cdots, X_{n})\\
Z_{n} &= max(X_{1}, X_{2},\: \cdots, X_{n})\\
\end{aligned}$$

Next we will show that both functions are measurable mappings. Let's first start with $$Z_{n}$$:

$$\begin{aligned}
\{\omega \mid Z_{n}(\omega) \leq z\} &= \{\omega \mid max\big(X_{1}(\omega),\: \cdots, X_{n}(\omega)\big) \leq z\}\\
&= \{\omega \mid X_{1}(\omega) \leq z,\: \cdots, X_{n}(\omega) \leq z\}\\
&\in \mathcal{F}\\
\end{aligned}$$

And we know that cuboids are measurable, we can conclude that $$Z_{n}$$ is a measurable mapping.

Similarly for $$Y_{n}$$:

$$\begin{aligned}
\{\omega \mid Y_{n}(\omega) > y\} &= \{\omega \mid min\big(X_{1}(\omega),\: \cdots, X_{n}(\omega)\big) > y\}\\
&= \{\omega \mid X_{1}(\omega) > y,\: \cdots, X_{n}(\omega) > y\}\\
&\in \mathcal{F}\\
\end{aligned}$$

As for the CDFs:

$$\begin{aligned}
F_{Y_{n}}(y) &= 1 - P(\omega \mid y_{n}(\omega) > y)\\
&= 1 - P(\omega \mid X_{1}(\omega) > y,\: \cdots, X_{n} > y)\\
&= 1 - F_{X_{1},\: \cdots, X_{n}}(y,\: \cdots, y)\\
\\
F_{Z_{n}}(z) &= P(\omega \mid Z_{n}(\omega) \leq z)\\
&= P(\omega \mid X_{1}(\omega) \leq z,\: \cdots, X_{n} \leq z)\\
&= F_{X_{1},\: \cdots, X_{n}}(z,\: \cdots, z)\\
\end{aligned}$$

In particular, if $$\{X_{i}\}$$ are independent:

$$\begin{aligned}
F_{Y_{n}}(y) &= \prod_{i = 1}^{n}\big(1 - F_{X_{i}}(y)\big)\\
F_{Z_{n}}(z) &= \prod_{i = 1}^{n}F_{X_{i}}(z)\\
\end{aligned}$$

Furthermore, if $$\{X_{i}\}$$ are independent and identically distrbuted (i.i.d):

$$\begin{aligned}
F_{Y_{n}}(y) &= \big(1 - F_{X}(y)\big)^{n}\\
F_{Z_{n}}(z) &= F_{X}(z)^{n}\\
\end{aligned}$$

Let's do an example. If $$\{X_{i}\}$$ are independent exponential random variables with parameters $$\{\lambda^{i} > 0\}$$:

$$\begin{aligned}
F_{X_{i}}(x) &= 1 - e^{-\lambda_{i}x}\\
\forall x &\geq 0\\
\end{aligned}$$

And take $$Y = min(X_{1},\: \cdots, X_{n})$$. The CDF we get is:

$$\begin{aligned}
(1 - F_{Y}(y)) &= \prod_{i = 1}^{n}e^{-\lambda_{i}y}\\
&= e^{-\sum_{i = 1}^{n}\lambda_{i}y}\\
F_{Y}(y) &= 1 - e^{-\sum_{i = 1}^{n}\lambda_{i}y}\\
f_{Y}(y) &= \big(\sum_{i = 1}^{n}\lambda_{i}\big)e^{-\sum_{i = 1}^{n}\lambda_{i}y}\\
Y &\sim Exp(\sum_{i = 1}^{n}\lambda_{i})\\
\end{aligned}$$

## <a name="sum"></a>Sum of Random Variables

Let $$X, Y$$ be random variables on $$(\Omega, \mathcal{F}, P)$$ and:

$$\begin{aligned}
Z(\omega)&= X(\omega) + Y(\Omega)\\
\end{aligned}$$

To show that $$Z$$ is a random variable on $$(\Omega, \mathcal{F}, P)$$:

$$\begin{aligned}
\{\omega \mid Z(\omega) > z\} &= \cup_{q \in \mathbb{Q}}\{\omega \mid X(\omega) > q, Y(\omega) > z - q\}\\
&= \cup_{q \in \mathbb{Q}}\big(\{X(\omega) > q\} \cap \{Y(\omega) > z - q\})\\[7pt]
\therefore \cup_{q \in \mathbb{Q}}\big(\{X(\omega) > q\} &\cap \{Y(\omega) > z - q\}) \in \mathcal{F}\\
\forall z &\in \mathbb{R}\\
\end{aligned}$$

As $$\mathbb{Q}$$ is dense in $$\mathbb{R}$$, which mean there between any two real numbers there is a rational number, and $$\{\omega \mid Z(\omega) > z\}$$ is closed under countable union of $$\mathcal{F}$$-measurable sets.

### Discrete PMF

Let $$X, Y$$ be discrete random variables with a joint pmf $$P_{X, Y}$$. Then:

$$\begin{aligned}
P_{Z}(z) &= \sum_{(x, y):\: x + y = z}P_{X, Y}(x, y)\\
&= \sum_{x}P_{X, Y}(x, z - x)\\
\end{aligned}$$

If $$X, Y$$ are independent:

$$\begin{aligned}
P_{Z}(z) &= \sum_{x}P_{X}(x)P_{Y}(z - x)\\
&= \sum_{x}P_{X}(x)P_{Y}(z - x)\\
&= P_{X}\ast P_{Y}\\
&= P_{Y}\ast P_{X}\\
&\forall z \in \mathbb{Z}^{+}\\
\end{aligned}$$

This is known as the convolution of $$P_{X}$$ and $$P_{Y}$$ or vice versa.

Let $$X_{1}, X_{2}$$ be independent Poisson random variables with parameters $$\lambda_{1}, \lambda_{2}$$. Consider $$Z = X_{1} + X_{2}$$:

$$\begin{aligned}
P_{Z}(z) &= P_{X_{1}} \ast P_{X_{2}}\\
&= \sum_{k = 0}^{z}\frac{e^{-\lambda_{1}}\lambda_{1}^{k}}{k!}\times\frac{e^{-\lambda_{2}}\lambda_{2}^{k}}{k!}\\
&= \frac{e^{-(\lambda_{1} + \lambda_{2})}}{z!}\sum_{k = 0}^{z}{z \choose k}\lambda_{1}^{k}\lambda_{2}^{z - k}\\
&= \frac{e^{-(\lambda_{1} + \lambda_{2})}(\lambda_{1} + \lambda_{2})^{z}}{z!}\\
&= \frac{e^{-\lambda}\lambda^{z}}{z!}\\
\end{aligned}$$

In other words, the sum of two Poisson random variables equals to a Poisson variable with parameter $$\lambda = \lambda_{1} + \lambda_{2}$$. It can be shown that this generalizes to $$Z = X_{1} +\: \cdots + X_{n}$$.

### Continuous PMF

Let $$X, Y$$ be jointly continuous with joint PDF $$f_{X, Y}$$. Then the CDF:

$$\begin{aligned}
F_{Z}(z) &= \int_{(x, y):\: x + y \leq z}f_{X, Y}(x, y)dydx\\
&= \int_{-\infty}^{\infty}\int_{-\infty}^{z - x}f_{X, Y}(x, y)dydx\\
\end{aligned}$$

To simplify further, let $$t = x + y$$:

$$\begin{aligned}
F_{Z}(z) &= \int_{-\infty}^{\infty}\int_{-\infty}^{z - x}f_{X, Y}(x, y)dydx\\
&= \int_{-\infty}^{\infty}\int_{-\infty}^{z}f_{X, Y}(x, t - x)dydt\\
&= \int_{-\infty}^{z}\int_{-\infty}^{\infty}f_{X, Y}(x, t - x)dxdt\\
&= \int_{-\infty}^{z}f_{Z}(t)dt\\
\end{aligned}$$

Note that $$f_{X, Y}$$ is non-negative and hence we can switch the integrals and we are integrating from $$t = 0$$ to $$t = z$$.

Hence,

$$\begin{aligned}
f_{Z}(z) &= \int_{-\infty}^{\infty}f_{X, Y}(x, z - x)dx\\
\end{aligned}$$

and we have just shown that $$f_{Z}$$ is continuous as well.

If $$X, Y$$ are independent:

$$\begin{aligned}
f_{Z}(z) &= \int_{-\infty}^{\infty}f_{X}(x)f_{Y}(z - x)dx\\
&= f_{X} \ast f_{Y}\\
\end{aligned}$$

Let $$X_{1}, X_{2}$$ be two independent exponential random variables with parameters $$\lambda_{1}, \lambda_{2}$$. Consider $$Z = X_{1} + X_{2}$$:

$$\begin{aligned}
f_{Z}(z) &= f_{X_{1}} \ast f_{X_{2}}\\
&= \int_{0}^{z}f_{X_{1}}(x)f_{X_{2}}(z - x)dx\\
&= \int_{0}^{z}\lambda_{1}e^{-\lambda_{1}x}\lambda_{2}e^{-\lambda_{2}(z - x)}dx\\
&= \lambda_{1}\lambda_{2}e^{\lambda_{2}z}\int_{0}^{z}\lambda_{1}e^{(\lambda_{2} - \lambda_{1})x}dx\\
&= 
\begin{cases}
\frac{\lambda_{1}\lambda_{2}}{\lambda_{2} - \lambda_{1}}(e^{-\lambda_{1}z} - e^{-\lambda_{2}z}) &\lambda_{1} \ne \lambda_{2}\\[7pt]
\lambda^{2}ze^{-\lambda z} &\lambda_{1} = \lambda_{2} = \lambda\\
\end{cases}
\end{aligned}$$

When $$\lambda_{1} = \lambda_{2}$$, we get a Erlang $$(2, \lambda)$$ distribution. In general, an Erlang $$(n, \lambda)$$ distribution:

$$\begin{aligned}
f_{Z}(z) &= \frac{\lambda^{n}z^{n - 1}e^{-\lambda z}}{(n - 1)!}\\
\end{aligned}$$

Another example is when $$X_{1}, X_{2}$$ are both Gaussian distribution and if they are independent we can show that:

$$\begin{aligned}
X_{1} &\sim N(\mu_{1}, \sigma_{1}^2)\\
X_{2} &\sim N(\mu_{2}, \sigma_{2}^2)\\
X_{1} &\perp \!\!\! \perp X_{2}\\
X_{1} + X_{2} &\sim N(\mu_{1} + \mu_{2}, \sigma_{1}^2 + \sigma_{2}^2)\\
\end{aligned}$$

## <a name="sumrand"></a>Sum of Random Number of Random Variables

Let $$\{X_{i} \mid i \geq 1\}$$ be a sequence of independent random variables with marginal CDF $$F_{X_{i}}$$. Let $$N > 0$$ be a random variable with pmf $$p_{N}(n) = P(N = n)$$. Further, assume that $$X_{i}$$ and $$N$$ are independent and both have the same underlying probability space $$(\Omega, \mathcal{F}, P)$$. Consider:

$$\begin{aligned}
S_{N} :&= \sum_{i = 1}^{N(\omega)}X_{i}(\omega)\\
\end{aligned}$$

Because the realization of $$N$$ partitions the sample space:

$$\begin{aligned}
P(S_{N} \leq x) &= \sum_{k = 1}^{\infty}P(S_{N} \leq x \mid N = k)P(N = k)\\
&= \sum_{k = 1}^{\infty}P(S_{k} \leq x \mid N = k)P(N = k)\\
&= \sum_{k = 1}^{\infty}P(S_{k} \leq x)P(N = k)\\
\end{aligned}$$

Let $$\{X_{i}\}$$ be i.i.d exponential random variables with parameter $$\lambda$$, $$N$$ be geometric random variable with parameter $$p$$ and consider $$S_{N} = \sum_{i = 1}^{N}X_{i}$$:

$$\begin{aligned}
P(S_{N} \leq x) &= \sum_{k = 1}^{\infty}P(S_{k} \leq x)P(N = k)\\
&= \sum_{k = 1}^{\infty}\big(1 - \sum_{n = 0}^{k - 1}\frac{1}{n!}e^{-\lambda x}(\lambda x)^{n}\big)(p(1 - p)^{k - 1})\\
&= \sum_{k = 1}^{\infty}p(1 - p)^{k - 1} - \sum_{n = 0}^{k - 1}p(1 - p)^{k - 1}e^{-\lambda x}\big(\sum_{n = 0}^{k - 1}\frac{1}{n!}(\lambda x)^{n}\big)\\
&= 1 - e^{-\lambda x}\sum_{n = 0}^{\infty}\frac{(\lambda x)^{n}}{n!}\frac{p}{1 - p}\sum_{k = n + 1}^{\infty}(1 - p)^{k}\\
&= 1 - e^{-\lambda x}\sum_{n = 0}^{\infty}\frac{(\lambda x (1 - p))^{n}}{n!}\\
&= 1 - e^{-\lambda x}e^{\lambda(1 - p)x}\\
&= 1 - e^{-(p \lambda) x}\\
\end{aligned}$$

Hence, $$S_{N}$$ is exponentially distributed with parameter $$\lambda p$$:

$$\begin{aligned}
S_{N} &\sim Exp(\lambda p)\\
\end{aligned}$$

An interesting example is the time you have to wait for a cab with the interval between cabs being exponentially distributed with parameter $$\lambda$$ and the probability of a cab being full is $$p$$ is also exponentially distributed with parameter $$\lambda p$$.

## <a name="general"></a>General Transformation

In the general case, we can denote the transformation as $$Y = f(X)$$. Let's look at the preimage of $$F_{Y}$$:

$$\begin{aligned}
f^{-1}\big(F_{Y}(y)\big) &= f^{-1}\big((-\infty, y]\big)\\
&= \{x \in \mathbb{R} \mid f(x) \leq y\}\\
\end{aligned}$$

Then using the probability law of $$X$$, $$P_{X}$$:

$$\begin{aligned}
F_{Y}(y) &= P_{X}(\{x \in \mathbb{R} \mid f(x) \leq y\})\\
\end{aligned}$$

### $$\chi^{2}$$ Distribution

Let $$X \sim N(0, 1)$$ and $$Y = X^{2}$$:

$$\begin{aligned}
F_{Y}(y) &= P(Y \leq y)\\
&= P(X^{2} \leq y)\\
&= P(-\sqrt{y} \leq x \leq \sqrt{y})\\
&= 2P(0 \leq X \leq \sqrt{y})\\
&= \frac{2}{\sqrt{2\pi}}\int_{0}^{\sqrt y}e^{-\frac{x^{2}}{2}}dx\\
f_{Y}(y) &= \frac{1}{\sqrt{2\pi y}}e^{-\frac{y}{2}}\\
\forall y &> 0\\
\end{aligned}$$

The resulting distribution is a $$\chi^{2}$$ distribution.

### Log-Normal Distribution

Next we will look at $$Y = e^{X}$$:

$$\begin{aligned}
F_{Y}(y) &= P(e^{X} \leq y)\\
&= P(X \leq ln(y))\\
&= \int_{-\infty}^{\ln(y)}\frac{1}{\sqrt{2\pi}}e^{-\frac{x^{2}}{2}}dx\\
f_{Y}(y) &= \frac{1}{y\sqrt{2\pi}}e^{-\frac{ln(y)^{2}}{2}}\\
\forall y &\geq 0\\
\end{aligned}$$

## <a name="jacobian"></a>Jacobian Transformation

Suppose $$X$$ has a density function $$f_{X}$$ and let $$Y = g(X)$$. If $$g$$ is a monotonically increasing differentiable function:

$$\begin{aligned}
F_{Y}(y) &= P(Y \leq y)\\
&= P(g(X) \leq y)\\
&= \int_{\{x \mid g(x) \leq y \}}f_{X}(x)dx\\
&= \int_{\{x \mid x \leq g^{-1}(y) \}}f_{X}(x)dx\\
&= \int_{-\infty}^{g^{-1}(y)}f_{X}(x)dx\\
\end{aligned}$$

Note that since $$g$$ is a monotonically increasing function:

$$\begin{aligned}
g(x) &\leq y\\
x &\leq g^{-1}(y)\\
\end{aligned}$$

Next we do a change of variable.

$$\begin{aligned}
u &= g(x)\\
g^{-1}(u) &= x\\
du &= g'(x)dx\\
dx &= \frac{1}{g'(x)}du
\end{aligned}$$

Substituting:

$$\begin{aligned}
F_{Y}(y) &= P(Y \leq y)\\
&= P(g(X) \leq y)\\
&= \int_{-\infty}^{y}f_{X}(g^{-1}(u))\frac{du}{g'(x)}\\
\end{aligned}$$

And differentiating to get $$f_{Y}$$:

$$\begin{aligned}
f_{Y}(y) &= \frac{1}{g'(y)}f_{X}(g^{-1}(y))\\
\end{aligned}$$

If $$f_{Y}$$ is monotonically decreasing, we will get a negative slope $$g'(y)$$. So to make it general, we will include a absolute sign on the $$g'(y)$$ and this is known as the Jacobian:

$$\begin{aligned}
f_{Y}(y) &= \frac{1}{|g'(y)|}f_{X}(g^{-1}(y))\\
\end{aligned}$$

For example, let $$Y = e^{X}$$, $$X \sim N(0, 1)$$:

$$\begin{aligned}
g(y) &= e^{x}\\
g'(y) &= e^{x}\\
g^{-1}(y) &= ln(y)\\
g'(g^{-1}(y)) &= e^{ln(y)}\\
&= y\\
f_{Y}(y) &= \frac{1}{\sqrt{2\pi}y}e^{-\frac{ln(y)^{2}}{2}}\\
\forall y &> 0\\
\end{aligned}$$

### Jacobian Matrix

For $$N$$ random variables $$X_{1},\: \cdots, X_{N}$$ with joint density $$f_{X_{1},\: \cdots, X_{N}}$$:

$$\begin{aligned}
\begin{bmatrix}
Y_{1}\\
\vdots\\[3pt]
Y_{N}\\
\end{bmatrix} =
\begin{bmatrix}
g(X_{1})\\
\vdots\\[3pt]
g(X_{N})\\
\end{bmatrix}
\end{aligned}$$

So we have:

$$\begin{aligned}
f_{Y_{1},\: \cdots, Y_{N}}(y_{1},\: \cdots, y_{n}) = &f_{X_{1},\: \cdots, X_{N}}(g^{-1}(y_{1},\: \cdots, y_{n}))|J(y)|\\[10pt]
J(y) := 
&\begin{bmatrix}
\frac{\partial x_{1}}{\partial y_{1}} & \frac{\partial x_{2}}{\partial y_{2}} & \cdots & \frac{\partial x_{n}}{\partial y_{1}}\\
\frac{\partial x_{1}}{\partial y_{2}} & \frac{\partial x_{2}}{\partial y_{2}} & \cdots & \frac{\partial x_{n}}{\partial y_{2}}\\
\vdots & \vdots & \ddots & \vdots \\[3pt]
\frac{\partial x_{1}}{\partial y_{n}} & \frac{\partial x_{2}}{\partial y_{n}} & \cdots & \frac{\partial x_{n}}{\partial y_{n}}\\
\end{bmatrix}\\
\end{aligned}$$

### Rayleigh Fading

Next we will look at transforming from the Cartesian coordinates to the polar coordinates.

Let $$X, Y$$ be i.i.d $$N(0, 1)$$:

$$\begin{aligned}
R &= \sqrt{X^{2} + Y^{2}}\\
\Theta &= tan^{-1}(\frac{Y}{X})\\
x &= r cos(\theta)\\
y &= r sin(\theta)\\
|J(r, \theta) | &= 
\begin{vmatrix}
cos(\theta) & sin(\theta)\\
-r sin(\theta) & r cos(\theta)\\
\end{vmatrix}\\
&= r\\
\end{aligned}$$

For the joint density of the multiplication of the two random variables $$XY$$:

$$\begin{aligned}
f_{X, Y}(x, y) &= \frac{1}{2\pi}e^{-\frac{x^{2}y^{2}}{2}}\\
f_{R, \Theta}(r, \theta) &= \frac{1}{2 \pi}e^{-\frac{r^{2}}{2}}r\\
\forall r &\geq 0\\
\theta &\in [0, 2\pi )\\
\end{aligned}$$

For the marginals:

$$\begin{aligned}
f_{R}(r) &= \int_{0}^{2\pi}f_{R, \Theta}d\theta\\
&= re^{-\frac{r^{2}}{2}}\\
\forall r &\geq 0\\[7pt]
f_{\Theta}(\theta) &= \int_{0}^{\infty}f_{R, \Theta}dr\\
&= \frac{1}{2\pi}\\
\forall \theta &\in [0, 2\pi)\\
\end{aligned}$$

As we can see $$r, \theta$$ are also independent in the polar coordinates. $$f_{R}(r)$$ is known as the Rayleigh distribution and $$f_{\Theta}(\theta)$$ is just a uniform distribution. These distributions are used to model Rayleigh fading where a receiver is reciving a signal from a base station that is being bounced around by buildings and objects. The signal received will be a combination of delayed signals or different phases of the signal.

We can also show that $$\rho = R^{2}$$ is exponentially distributed.

Let's show how we can use transformation to generate Rayleigh, Exponential, and Gaussian distribution from Uniform distribution.

Let $$U_{1}, U_{2}$$ be i.i.d $$Unif(0, 1)$$ distribution and:

$$\begin{aligned}
\Theta &= 2\pi U_{1}\\
Z &= -\frac{ln(U_{2})}{2}\\
R &= \sqrt{Z}
\end{aligned}$$

It can be shown that:

$$\begin{aligned}
\Theta &\sim Unif(0, 2\pi)\\
Z &\sim Exp(0.5)\\
R &\sim Rayleigh(1)\\
\end{aligned}$$

Finally we get two i.i.d Gaussians by setting:

$$\begin{aligned}
X &= R cos(\Theta)\\
Y &= R sin(\Theta)\\
\end{aligned}$$
