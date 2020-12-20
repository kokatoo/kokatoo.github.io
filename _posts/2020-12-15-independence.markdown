---
layout: post
title: "Independence"
date: 2020-12-15 01:30:06 +0800
img : independence.png
tags: [probability, measure]
---

Two events $$A, B$$ are independent under $$P$$ if

$$\begin{aligned}
P(A \cap B) &= P(A)P(B)
\end{aligned}$$

And if $$P(B) > 0$$ then:

$$\begin{aligned}
P(A \mid B) &= P(A)\\
\end{aligned}$$

Note that the events might not be independent under a different measure which is why we specify independence under $$P$$.

For multiple independent events $$A_{1},\: \cdots, A{n} \in \mathcal{F}$$ to be independent, we need the following to be satisfied:

$$\begin{aligned}
P(\cap_{i \in I_{0}}A_{i}) &= \prod_{i \in I_{0}}P(A_{i})\\
\forall I_{0} &\subseteq \{1,\: \cdots, n\}\\
\end{aligned}$$

In other words, we need all possible subsets to have the above property. Technically, we have to test for $$2^{n} - n - 1$$ possible subsets as the $$\emptyset$$ and singletons are trivially excluded.

For a countable infinite or arbitrary $$\{A_{i}, i \in I \}$$ of events, the events are said to be independent if for all non-empty and finite $$I_{0} \subset I$$:

$$\begin{aligned}
P(\cap_{i \in I_{0}}A_{i}) &= \prod_{i \in I_{0}}P(A_{i})\\
\end{aligned}$$

<div class="toc" markdown="1">
# Contents:
- [Independence of $$\sigma$$_Algebras](#sigma)
- [Independent Random Variables](#rvs)
- [Discrete Random Variables](#discrete)
- [Continuous Random Variables](#continuous)
</div>


## <a name="sigma"></a>Independence of $$\sigma$$_Algebras

Let $$\mathcal{F}_{1}, \mathcal{F}_{2}$$ be sub-$$\sigma$$-algebras of $$\mathcal{F}$$. 

$$\mathcal{F}_{1}, \mathcal{F}_{2}$$ are said to be independent $$\mathcal{F}_{1} \perp \!\!\! \perp \mathcal{F}_{2}$$ if:

$$\begin{aligned}
&A_{1} \perp \!\!\! \perp A_{2}\\
&\forall A_{1} \in \mathcal{F}_{1}\\
&\forall A_{2} \in \mathcal{F}_{2}\\
\end{aligned}$$

Similarly, for an arbitrary collection of sub-$$\sigma$$-algebras $$\{\mathcal{F}_{i}, i \in I \}$$ are said to be independent if:

$$\begin{aligned}
P(\cap_{i \in I_{0}}A_{i}) &= \prod_{i \in I_{0}}P(A_{i})\\
\forall A_{i} &\in \mathcal{F}_{i}\\
\end{aligned}$$

## <a name="rvs"></a>Independent Random Variables

Given two random variables $$X, Y$$:

$$\begin{aligned}
\sigma(X) &:= \{A \subseteq \Omega \mid A = X^{-1}(B), B \in \mathcal{B}(\mathbb{R}) \}\\
\sigma(Y) &:= \{A \subseteq \Omega \mid A = X^{-1}(B), B \in \mathcal{B}(\mathbb{R}) \}\\
\end{aligned}$$

$$X, Y$$ are said to be independent if $$\sigma(X), \sigma(Y)$$ are independent $$\sigma$$-algebras: 

$$\begin{aligned}
\sigma(X) &\perp \!\!\! \perp \sigma(Y)\\
\end{aligned}$$

In other words, for any two Borel sets $$B_{1}, B_{2}$$ we have:

$$\begin{aligned}
\{\omega \mid X(\omega) \in B_{1}\} &\perp \!\!\! \perp \{\omega \mid Y(\omega) \in B_{2}\}\\
\forall B_{1}, B_{2} &\in \mathcal{B}(\mathbb{R})\\
\end{aligned}$$

And:

$$\begin{aligned}
P(x \in B_{1}, y \in B_{2}) &= P(x \in B_{1})P(x \in B_{2})\\
\end{aligned}$$

And in particular the generating class of CDF intervals:

$$\begin{aligned}
P(X \leq x, Y \leq y) &= P(X \leq x)P(Y \leq y)\\
F_{X, Y}(x, y)  &= F_{X}(x)F_{Y}(y)\\
\forall x, y &\in \mathbb{R}\\
\end{aligned}$$

We can also show the converse holds true by showing that if it holds true for two $$\pi$$-system $$\mathcal{G}, \mathcal{H}$$, it also holds true for the whole $$\sigma$$-algebra:

$$\begin{aligned}
\sigma(\mathcal{G}) &\perp \!\!\! \perp \sigma(\mathcal{H})\\
\end{aligned}$$

It also generalizes to $$n$$ random variables. If $$X_{1},\: \cdots, X_{n}$$ are independent random variables, $$\sigma(X_{1}),\: \cdots, \sigma(X_{n})$$ are independent. In fact we can show that $$\{X_{i} \mid i \in I\}$$ are said to be independent if the family of $$\sigma$$-algebras $$\{\sigma(X_{i}) \mid i \in I\}$$ are independent. And this applies even if set $$I$$ is uncountable.

## <a name="discrete"></a>Discrete Random Variables

Let $$X, Y$$ be discrete random variables. Then the following are equivalent:

(a)<span style="margin-left: 30px;"></span>  $$X, Y$$ are independent

(b)<span style="margin-left: 30px;"></span>  The events $$\{X = x \mid x \in \mathbb{R}\}$$ and $$\{Y = y \mid y \in \mathbb{R}\}$$ are independent

(c)<span style="margin-left: 30px;"></span>  $$P_{X, Y}(x, y) = P_{X}(x)P_{Y}(y)$$
<br />
<span style="margin-left: 50px;"></span>$$\forall x, y \in \mathbb{R}$$

(d)<span style="margin-left: 30px;"></span>  $$P_{Y}(y) > 0 \rightarrow P_{X \mid Y}(x \mid y) = P_{X}(x)$$
<br />
<span style="margin-left: 50px;"></span> $$\forall x, y \in \mathbb{R},$$

For any Borel sets $$B_{1}, B_{2}$$, given that $$X, Y$$ are independent:

$$\begin{aligned}
P(\{X = x \mid x \in B_{1}, Y = y \in \mid y \in B_{2}\}) &= P(\{X = x \mid x \in B_{1}\})P(\{Y = y \mid y \in B_{2}\})\\
\end{aligned}$$

Taking the singletons as events:

$$\begin{aligned}
\{X = x \mid x \in B_{1}\} = \{x\}\\
\{Y = y \mid y \in B_{2}\} = \{y\}\\
\end{aligned}$$

we can see the two events are independent.

Similarly, if for any Borel sets $$B_{1}, B_{2}$$, given that the events $$\{X = x \mid x \in \mathbb{R}\}$$ and $$\{Y = y \mid y \in \mathbb{R}\}$$ are independent:

$$\begin{aligned}
P(\{X = x \mid x \in B_{1}, Y = y \mid y \in B_{2}\}) &= \sum_{(x \in B_{1}, y \in B_{2})}P(X = x, Y = y)\\
&= \sum_{(x \in B_{1}, y \in B_{2})}P(X = x)P( Y = y)\\
&= \sum_{x \in B_{1}}P(X = x)\sum_{y \in B_{2}}P(Y = y)\\
\end{aligned}$$

Hence, $$X, Y$$ are independent as their $$\sigma$$-algebras are independent.

## <a name="continuous"></a>Continuous Random Variables

If $$X, Y$$ are discrete, both takes only countable values on $$\mathbb{R}$$ with probability one and the Cartesian product also take countable values in $$\mathbb{R}^{2}$$ However, this is not always true for continuous random variables.

In particular, let $$X, Y$$ be jointly continuous if the joint probability law $$P_{X, Y}$$ is absolutely continuous w.r.t the Lebesgue measure on $$\mathbb{R}^{2}$$ which is the area. The reason why the above for continuous variables is not true is because both the marginals being continuous on $$\mathbb{R}$$ don't mean that they will be jointly continuous in $$\mathbb{R}^{2}$$.

An example will be to take $$X \sim N(0, 1)$$ and $$Y = 2X \sim N(0, 4)$$. When you plot the two random variables in a Cartesian plot, all the points will lie on a straight line $$y = x$$ with Lebesgue measure or area of 0. Hence jointly continuous is a stronger condition than marginal continuous.

If $$X, Y$$ are jointly continouous random variables, Radon Nikodym's theorem states that there exists a measurable function $$f_{X, Y}: \mathbb{R}^{2} \rightarrow [0, \infty)$$ such that for any $$B \in \mathcal{B}(\mathbb{R}^{2})$$:

$$\begin{aligned}
P_{X, Y}(B) &= \int_{B}f_{X, Y}d\lambda^{2}\\
\end{aligned}$$

In particular, taking the generating interval $$B = (-\infty, a] \times (-\infty, b]$$ we can define the joint CDF:

$$\begin{aligned}
F_{X, Y}(x, y) &= \int_{-\infty}^{a}\int_{-\infty}^{b}f_{X, Y}(x, y)dxdy\\
F_{X, Y}(x, y) &= \int_{-\infty}^{b}\int_{-\infty}^{a}f_{X, Y}(x, y)dydx\\
\end{aligned}$$

Because $$f_{X, Y}$$ is a non-negative function, the order of the integration doesn't matter.

We can get the marginals by integrating out the other variable:

$$\begin{aligned}
F_{X}(x) &= \lim\limits_{y \rightarrow \infty}F_{X, Y}(x, y)
&= \int_{-\infty}^{a}\int_{-\infty}^{\infty}f_{X, Y}(x, y)dydx\\
F_{Y}(y) &= \lim\limits_{x \rightarrow \infty}F_{X, Y}(x, y)
&= \int_{-\infty}^{b}\int_{-\infty}^{\infty}f_{X, Y}(x, y)dxdy\\
\end{aligned}$$

### Independence of Continuous Random Variables

If $$X, Y$$ are jointly continuous and independent random variables, we know that:

$$\begin{aligned}
F_{X, Y}(x, y) &= F_{X}(x)F_{Y}(y)\\
\forall x, y &\in \mathbb{R}\\
\end{aligned}$$

This implies that:

$$\begin{aligned}
\int_{-\infty}^{a}\int_{-\infty}^{b}f_{X, Y}(x, y)dxdy &= \int_{-\infty}^{a}f_{X}dx\int_{-\infty}^{b}f_{Y}dy\\
&= \int_{-\infty}^{a}\int_{-\infty}^{b}f_{X}f_{Y}dxdy\\
\forall x, y &\in \mathbb{R}\\
\end{aligned}$$

Hence,

$$\begin{aligned}
f_{X, Y}(x, y) &= f_{X}f_{Y}\\
\forall x, y &\in \mathbb{R}\\
\end{aligned}$$

except possibly on a set of $$\lambda$$ measure zero (almost everywhere). Note that the converse is also true.
