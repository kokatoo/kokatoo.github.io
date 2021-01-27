---
layout: post
title: "Measurable Mapping And Random Variable"
date: 2020-12-06 01:30:06 +0800
img : 
tags: [probability, measure]
---

A measurable mapping is a function that maps a measurable space to another measurable space. In probability theory, a measurable mapping is called a random variable. We shall explore this in depth in this post.

<div class="toc" markdown="1">
# Contents:
- [Measurable Mapping](#mapping)
- [$$\cap$$-Stable Generating System](#stable)
- [Random Variable](#rv)
- [Multiple Random Variables](#multiple)
- [Lebesgue's Decomposition Theorem](#decomposition)
- [Filtration](#filtration)
</div>

## <a name="mapping"></a>Measurable Mapping

Let $$(\Omega, \mathcal{F})$$, $$(\Omega^{\prime}, \mathcal{F}')$$ be measurable spaces. Then $$f: (\Omega, \mathcal{F}, \mu) \to (\Omega', \mathcal{F}')$$ is called $$(\mathcal{F}, \mathcal{F}')$$-measurable if

$$\begin{aligned}
f^{-1}(A') &\in \mathcal{F}\\
\forall A' &\in \mathcal{F'}
\end{aligned}$$

The measure function $$\mu_{f}: \mathcal{F}' \to \overline{\mathbb{R}}$$ where $$\overline{\mathbb{R}} := \mathbb{R} \cup \{ -\infty, \infty \}$$ is defined by:

$$\begin{aligned}
\mu_{f}(A') &:= \mu(f^{-1}(A'))\\
\forall A' &\in \mathcal{F}'
\end{aligned}$$

## <a name="stable"></a>$$\cap$$-Stable Generating System

Let $$f: (\Omega, \mathcal{F}) \to (\Omega', \mathcal{P}(\Omega'))$$ be a measurable mapping and $$\mathcal{C} \subset \mathcal{F}$$ be a $$\sigma$$-algebra.

The $$\cap$$-stable generating system of $$\sigma(\mathcal{C}, f)$$ is defined as:

$$\begin{aligned}
\{C \cap f^{-1}(\{\omega'\}): \omega' \in \Omega', C \in \mathcal{C}\}\\
\end{aligned}$$

## <a name="rv"></a>Random Variable

If $$\mu$$ in $$f: (\Omega, \mathcal{F}, \mu) \to (\Omega', \mathcal{F}')$$ is a probability measure, then the measurable mapping $$f$$ is also known as a random variable. Note that not all mappings are random variable but only those that are $$(\mathcal{F}, \mathcal{F}')$$-measurable. Furthermore, the name random variable is a misnomer as random variable is neither random (it is a determinstic mapping given $$\omega \in \Omega$$) nor a variable (it is a function $$X(\omega)$$).

We shall denote the measurable mapping as $$X$$:

$$\begin{aligned}
X^{-1}(A') &\in \mathcal{F}\\
\forall A' &\in \mathcal{B}
\end{aligned}$$

$$\begin{aligned}
X^{-1}(A') := \{\omega &\in \Omega: X(\omega) \in A' \}\\
\forall A' &\in \mathcal{F}'_{X}
\end{aligned}$$

And we are mostly interested when  $$X$$ is real-valued $$(\Omega_{X}', \mathcal{F}_{X}') = (\mathbb{R}, \mathcal{B})$$.

$$X^{-1}(A')$$ are elements of the $$\sigma$$-algebra $$\mathcal{F}$$ on $$\Omega$$:

$$\begin{aligned}
\{\omega \in \Omega: X(\omega) \in A' \} &\in \mathcal{F}\\
\end{aligned}$$

### Probability Law of Random Variable

The distribution of $$X$$ w.r.t to, or induced by the, measure $$P$$ is the function $$P_{X}: \mathcal{F}'_{X} \to [0, 1]$$ defined by:

$$\begin{aligned}
P_{X}(A') &= P[X^{-1}(A')]\\
\forall A' &\in \mathcal{F}'_{X}
\end{aligned}$$

$$P_{X}$$ is also known as the probability law of random variable $$X$$.

Since the above notation is kind of verbose, we will define the following shorthands:

$$\begin{aligned}
P(X \in A') := &P[X^{-1}(A')]\\
= &P_{X}(A')\\
P(X = x) := &P[X^{-1}(\{x\})]\\
= &P_{X}(\{x\})\\
\end{aligned}$$

Hence, every random variable has its own probability space with a probability measure $$P_{X}$$ defined as:

$$\begin{aligned}
X: (\Omega, \mathcal{F}, P) \to (\Omega_{X}', \mathcal{F}_{X}', P_{X})\\
\end{aligned}$$

Once $$P_{X}$$ is defined, we will usually only focus on $$(\Omega_{X}', \mathcal{F}_{X}', P_{X})$$ measure space and forget about $$(\Omega, \mathcal{F}, P)$$ in our computation.

### Indicator Random Variable

An example is the indicator mapping of $$A$$, $$I_{A}: (\Omega, \mathcal{F}, P) \to (\{0, 1\}, \mathcal{P}({0, 1}))$$ is a random variable that outputs a $$1$$ if event $$A$$ occurs and $$0$$ otherwise. We can list the distribution as follows:

$$\begin{aligned}
P_{I_{A}}(\{0\}) &= P(A^{c})\\
P_{I_{A}}(\{1\}) &= P(A)\\
P_{I_{A}}(\{0, 1\}) &= P(\Omega) = 1\\
P_{I_{A}}(\emptyset) &= P(\emptyset) = 0\\
\end{aligned}$$

### Coin Toss Random Variable

Another example is tossing coins. The distribution of tossing two coins:

$$\begin{aligned}
P(X = 0) &= P[X^{-1}({0})] = P(\{(T, T)\}) = 0.25\\
P(X = 1) &= P[X^{-1}({1})] = P(\{(H, T), (T, H)\}) = 0.50\\
P(X = 2) &= P[X^{-1}({2})] = P(\{(H, H)\}) = 0.25\\
\end{aligned}$$

### Non-Singleton Random Variable

Note that the above examples are singletons. An example of a non-singleton event:

$$\begin{aligned}
P(X \in \{0, 1\}) &= P[X^{-1}(\{0, 1\})] = P(\{(T, T), (H, T), (T, H)\}) = 0.75\\
\end{aligned}$$

## <a name="multiple"></a>Multiple Random Variables

We can describe two joint random variables sharing a same underlying probability space $$(\Omega, \mathcal{F}, P)$$ to $$\mathcal{B}(\mathbb{R})$$ as:

$$\begin{aligned}
X:& (\Omega, \mathcal{F}, \mu) \to (\mathbb{R}, \mathcal{B}(\mathbb{R}))\\
Y:& (\Omega, \mathcal{F}, \mu) \to (\mathbb{R}, \mathcal{B}(\mathbb{R}))\\
\end{aligned}$$

This is the same as a Borel $$\sigma$$-algebra on $$\mathbb{R}^{2}$$ which we can generate from the $$\pi$$-system:

$$\begin{aligned}
\sigma(\pi(\mathbb{R}^{2})) :&= \sigma\big((-\infty, x] \times (-\infty, y] \mid x \in \mathbb{R}, y \in \mathbb{R}\big)\\
&= \mathcal{B}(\mathbb{R}^{2})\\
\end{aligned}$$

So in the end we will get the following joint measure space:

$$\begin{aligned}
\big(\mathbb{R}^{2},\: &\mathcal{B}(\mathbb{R}^{2}), P_{X,Y}\big)\\
P_{X,Y} := P(\omega \in \Omega &\mid (X(\omega), Y(\omega)) \in B)\\
&B \in \mathcal{B}(\mathbb{R}^{2})\\
\end{aligned}$$

Likewise, we can generalize this to $$\mathbb{R}^{n}$$:

$$\begin{aligned}
\big(\mathbb{R}^{n},\: &\mathcal{B}(\mathbb{R}^{n}), P_{X_{1},\: \cdots, X_{n}}\big)\\
P_{X_{1},\: \cdots, X_{n}} := \big(\mathbb{R}^{n}, \mathcal{B}^{n}, P(\omega \in \Omega &\mid (X_{1}(\omega), X_{2}(\omega),\: \cdots, X_{n}(\omega)) \in \mathcal{B}^{n})\big)\\
&B \in \mathcal{B}^(\mathbb{R}^{n})\\
\end{aligned}$$

## <a name="decomposition"></a>Lebesgue's Decomposition Theorem

In simple and random variables terms, Lebesgue Decomposition Theorem states that all probability measures from $$\mathbb{R}$$ can be decomposed of 3 types of random variables components:

### Discrete Random Variable

A random variable is discrete if there exists a countable set $$E \subset \mathbb{R}$$ such that $$P_{X}(E) = 1$$. Note that from the definition that $$P_{X}(E) = 1$$, there could be some mapping to subsets of $$\mathbb{R}$$ that is uncountable but it is fine as long as those are measures are zero. In other words, $$X$$ mapped to values in a countable set almost surely.

The probability mass function is defined as:

$$\begin{aligned}
p_{X}(x) &:= P_{X}(\{x\})\\
&:= P(X = x)
\end{aligned}$$

###  Continuous Random Variable

A random variable is said to be continuous if $$P_{X}$$ is [absolute continuous]({% post_url 2020-12-05-probability-measure %}#continuity) w.r.t the Lebesgue measure $$\lambda$$. In other words, for every Borel set of Lebesgue measure zero, we have $$P_{X}$$ of zero as well:

$$\begin{aligned}
P_{X}(A) = 0 &\Rightarrow \lambda(A) = 0\\
\forall A &\in \mathcal{F}
\end{aligned}$$

It is also differentiable almost everywhere except possibly on sets with measure zero.

###  Singular Random Variable

A random variable is said to be singular if:

$$\begin{aligned}
\exist B \in &\mathcal{B}(R)\\
P_{X}(B) &= 1\\
\lambda(B) &= 0\\
P_{X}(\{x\}) &= 0\\
\forall x &\in \mathbb{R}\\
\end{aligned}$$

In other words, $$B$$ is an uncountable set of zero Lebesgue measure but contains all the probability.

An example will be the Cantor distribution. As we know Cantor sets have zero measure and so it satisfies the above definition. Next is to somehow assign a uniform probability measure on these Cantor sets. It can be shown that the distribution is continuous everywhere but not absolute continuous and without jumps, but it is not differentiable everywhere except on intervals with zero derivative. Hence it has no discontinuity and zero slope almost everywhere but still able to move from 0 to 1.

## <a name="filtration"></a>Filtration

A random variable $$X: (\Omega, \mathcal{F}, P) \to (\Omega_{X}', \mathcal{F}_{X}')$$ is defined as prior to another random variable $$Y: (\Omega, \mathcal{F}, P) \to (\Omega_{Y}', \mathcal{F}_{Y}')$$ if there is a $$s \in T$$ in a filtration $$\{\mathcal{F}_{t}, t \in T\}$$ in $$\mathcal{F}$$ such that:

$$\begin{aligned}
\sigma(X) &\subset \mathcal{F}_{s}\\
\sigma(Y) &\nsubseteq \mathcal{F}_{s}\\
\end{aligned}$$

And there is a $$t \in T$$, $$t > s$$, such that:

$$\begin{aligned}
\sigma(Y) &\subset \mathcal{F}_{t}\\
\end{aligned}$$

Let's do a coin tossing example of filtration. If we define a random variable $$X_{i}$$ that outputs 1 if the ith toss is heads for two coin tosses:

$$\begin{aligned}
X_{i}[(x_{1}, x_{2})] &:=1,\: \mathrm{if}\: x_{i} = H\\
X_{i}[(x_{1}, x_{2})] &:=0,\: \mathrm{if}\: x_{i} = T\\
\forall (x_{1}, x_{2}) &\in \Omega \times \Omega\\
\end{aligned}$$

For example,

$$\begin{aligned}
X_{1}[(H, T)] &= 1\\
X_{1}[(T, T)] &= 0\\
X_{2}[(H, H)] &= 1\\
X_{2}[(H, T)] &= 0\\
\end{aligned}$$

We can introduce order by defining the following fitration $$\{\mathcal{F}_{1}, \mathcal{F}_{2}\}$$:

$$\begin{aligned}
\mathcal{F}_{1} &:= \sigma(X_{1})\\
\mathcal{F}_{2} &:= \sigma(X_{1}, X_{2})\\
\end{aligned}$$

In this case, $$X_{1}$$ is prior to $$X_{2}$$ in $$(\mathcal{F}_{1}, \mathcal{F}_{2})$$.
