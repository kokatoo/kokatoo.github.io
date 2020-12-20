---
layout: post
title: "Probability Measure"
date: 2020-12-05 01:30:06 +0800
img : probability.png
tags: [probability, measure]
---

## END

A measure $$P$$ on $$(\Omega, \mathcal{F})$$ is a probability measure on $$\mathcal{F}$$ and is also known as a distribution on $$(\Omega, \mathcal{F})$$. Normally a distribution is used on random variables (which we will cover on future posts).

<div class="toc" markdown="1">
# Contents:
- [Probability Measure Space](#measure)
- [Conditional Probability](#conditional)
- [Absolute Continuity](#continuity)
- [Bayes' Theorem](#bayes)
- [Filtration](#filtration)
- [Borel-Cantelli Lemmas](#cantelli)
</div>

## <a name="measure"></a>Probability Measure Space

Let $$(\Omega, \mathcal{F})$$ be a measurable space. A probability measure is a function $$P: \mathcal{F} \to [0, 1]$$ with the following conditions:

(a)<span style="margin-left: 30px;"></span>  $$P(\Omega) = 1$$

(b)<span style="margin-left: 30px;"></span>  $$P(A) \geq 0, \forall A \in \mathcal{F}$$

(c)<span style="margin-left: 30px;"></span>  $$\sigma$$-additivity: If $$A_{1}, A_{2}, \cdots \in \mathcal{F}$$ are pairwise disjoint, then $$P(\cup_{i = 1}^{\infty} A_{i}) = \sum_{i = 1}^{\infty}P(A_{i})$$

Note that this is exactly the same definition of a measure function in the measure [post]({% post_url 2020-11-20-measure %}#measure) except the range $$[0, 1]$$ is a subset of $$\mathbb{R}$$ and $$(\Omega, \mathcal{F}, P)$$ is known as a probability space.

$$A \in \mathcal{F}$$ is an event and a singleton $$\{\omega\} \in \mathcal{F}$$ is called an elementary event. Note that $$\omega \in \Omega$$ is an outcome while $$\{\omega\} \in \mathcal{F}$$ is an elementary event. Event is also known as a measurable set.

For example, let's define a continuous uniform distribution $$P$$ over $$\Omega$$. $$\mathcal{B}^{2}$$ is a Borel set on $$\mathbb{R}^{2}$$, $$\lambda^{2}$$ is the Lebesgue measure on $$\mathbb{R}^{2}$$, and $$\mathcal{F} = \mathcal{B}^2 \mid _{\Omega} := \{\Omega \cap A: A \in \mathcal{B}^{2}\}$$. Then:

$$\begin{aligned}
P(A) &= \frac{\lambda^{2}(A)}{\lambda^{2}(\Omega)}\\
\forall &A \in \mathcal{F}
\end{aligned}$$

## <a name="conditional"></a>Conditional Probability

Conditional probabilities are used when there are dependencies among events.

Let $$A, B \in \mathcal{F}$$, and let $$P(B) > 0$$:

$$\begin{aligned}
P(A \mid B) := \frac{P(A \cap B)}{P(B)}\\
\end{aligned}$$

$$P(A \mid B)$$ is the probablity of $$A$$ given $$B$$ has occurred $${P(B \mid B) = 1}$$ and $$P(B)$$ is the normalization constant.

### Multiplication Rule

$$P(A_{1} \cap \cdots A_{n})$$ can be factorized into products of unconditional and conditional probablities given that $$P(A) > 0$$:

$$\begin{aligned}
P(A_{1} \cap A_{2}) &= P(A_{1})P(A_{2} \mid A_{1})\\
P(A_{1} \cap A_{2} \cap A_{3}) &= P(A_{1})P(A_{2} \mid A_{1})P(A_{3} \mid P(A_{1} \cap A_{2}))\\
P(\cap_{i = 1}^{n} A_{i}) &= P(A_{1})\prod_{j = 1}^{n}P(A_{j} \mid \cap_{i = 1}^{j - 1} A_{i})\\
\end{aligned}$$

And if $$\{A_{i}\}$$ are countably infinite, we can show using continuity of a measure:

$$\begin{aligned}
\lim\limits_{n \rightarrow \infty} P(\cap_{i = 1}^{n}A_{i}) &= \lim\limits_{n \rightarrow \infty} P(A_{1})\prod_{j = 1}^{n}P(A_{j} \mid \cap_{i = 1}^{j - 1} A_{i})\\
&= P(\cap_{i = 1}^{\infty} A_{i})
\end{aligned}$$


### Theorem of Total Probability

If $$A_{1}, \cdots, A_{n}$$ are pairwise disjoint, $$A_{i} \cap A_{j} = \emptyset$$, then:

$$\begin{aligned}
P(B) &= \sum_{i = 1}^{n}P(B \cap A_{i})\\
\forall i, j &= 1,\: \cdots, n\\
i &\ne j\\
\end{aligned}$$

And if $$\{A_{i}\}$$ are countably infinite:

$$\begin{aligned}
P(B) &= \sum_{i = 1}^{\infty}P(B \cap A_{i})\\
\end{aligned}$$

And if $$P(A_{i}) > 0$$, $$\forall i = 1,\: \cdots, n$$:

$$\begin{aligned}
P(B) &= \sum_{i = 1}^{n}P(B \mid A_{i})P(A_{i})\\
\end{aligned}$$

And if $$\{A_{i}\}$$ are countably infinite:

$$\begin{aligned}
P(B) &= \sum_{i = 1}^{\infty}P(B \mid A_{i})P(A_{i})\\
\end{aligned}$$

And $$\{B \cap A_{i}\}$$ are pairwise disjoint as well given that $$\{A_{i}\}$$ are disjoint.

Note that elementary events are always disjoint too.

### Conditional Probability Measure

Conditional probability of event $$A \in \mathcal{F}$$ is itself a probability measure.

$$\begin{aligned}
P_{B}(A) &= P(A \mid B)\\
\forall A &\in \mathcal{F}
\end{aligned}$$

is a probablity measure on $$(\Omega, \mathcal{F})$$ and $$(\Omega, \mathcal{F}, P_{B})$$ is a probability space.

We can show that the following conditions are fulfilled given $$B \in \mathcal{F}$$ and $$P(B) > 0$$:

(a)<span style="margin-left: 30px;"></span>  $$P(\Omega \mid B) = \frac{P(\Omega \cap B)}{P(B)} = \frac{P(B)}{P(B)} = 1$$

(b)<span style="margin-left: 30px;"></span>  $$P(A \mid B) \geq 0, \forall A \in \mathcal{F}$$

(c)<span style="margin-left: 30px;"></span>  If $$A_{1}, A_{2}, \cdots \in \mathcal{F}$$ are pairwise disjoint, then:

$$\begin{aligned}
P(\cup_{i = 1}^{\infty} A_{i} \mid B) &= \frac{P((\cup_{i = 1}^{\infty} A_{i}) \cap B)}{P(B)}\\
&= \frac{P(\cup_{i = 1}^{\infty} (A_{i} \cap B))}{P(B)}\\
&= \frac{\sum_{i = 1}^{\infty} P(A_{i} \cap B)}{P(B)}\\
&= \sum_{i = 1}^{\infty}P(A_{i} \mid B)\\
\end{aligned}$$

We can also have conditional probabilities on a conditional measure:

$$\begin{aligned}
P_{B}(A \mid C) &= P(A \mid B \cap C)\\
\end{aligned}$$

And total conditional probablity given $$P(B \cap C) > 0$$ and $$P(B \cap C^{c}) > 0$$:

$$\begin{aligned}
P_{B}(A) &= P_{B}(A \mid C)P_{B}(C) + P_{B}(A \mid C^{c})P_{B}(C^{c})\\
P(A \mid B) &= P(A \mid B \cap C)P(C \mid B) + P(A \mid B \cap C^{c})P(C^{c} \mid B)\\
\end{aligned}$$

## <a name="continuity"></a>Absolute Continuity

We say that probability measure $$\mathcal{Q}$$ is absolutely continuous w.r.t probability measure $$\mathcal{P}$$ if:

$$\begin{aligned}
P(A) = 0 &\Rightarrow Q(A) = 0\\
\forall A &\in \mathcal{F}
\end{aligned}$$

We will denote this as:

$$\begin{aligned}
P &\ll_{\mathcal{F}} Q\\
\end{aligned}$$

In particular, $$P_{B} \ll_{\mathcal{F}} P$$ but $$P \ll_{\mathcal{F}} P_{B}$$ does not necessarily hold.

## <a name="bayes"></a>Bayes' Theorem

We can flip the conditional probabilities using Bayes' Theorem:

$$\begin{aligned}
P(A_{i} \mid B) &= \frac{P(B \mid A_{i})P(A_{i})}{P(B)}\\
\end{aligned}$$

If $$A_{1}, \cdots, A_{n}$$ are pairwise disjoint, then

$$\begin{aligned}
P(A_{i} \mid B) &= \frac{P(B \mid A_{i})P(A_{i})}{\sum_{j = 1}^{n} P(B \mid A_{j})P(A_{j})}\\
\end{aligned}$$

And if $$\{A_{i}\}$$ are countably infinite:

$$\begin{aligned}
P(A_{i} \mid B) &= \frac{P(B \mid A_{i})P(A_{i})}{\sum_{j = 1}^{\infty} P(B \mid A_{j})P(A_{j})}\\
\end{aligned}$$

## <a name="filtration"></a>Filtration

Time order between events are taken into account in filtration. 

Let $$(\Omega, \mathcal{F}, P)$$ be a probability space and $$T > 0$$.

Assume $$0 \leq t \leq T$$, $$\exist$$ a $$\sigma$$-algebra, $$\mathcal{F}_{t}$$ such that:

$$\begin{aligned}
\mathcal{F}_{t} &\subset \mathcal{F}\\
\mathcal{F}_{s} &\subseteq \mathcal{F}_{t}\\
\forall &s \leq t\\
\end{aligned}$$

Then $$\{\mathcal{F}_{t}\}_{0 \leq t \leq T}$$ is called a filtration associated with $$(\Omega, \mathcal{F}, P)$$.

For example, if event A is prior to event B and event B is prior to event C, we can represent this as the following filtration:

$$\begin{aligned}
\mathcal{F}_{1} &:= \sigma(\{A\})\\
\mathcal{F}_{2} &:= \sigma(\{A, B\})\\
\mathcal{F}_{3} &:= \sigma(\{A, B, C\})\\
\end{aligned}$$

Let's take an example of 3 successive coin tosses.

The sample space $$\Omega$$ is defined as:

$$\begin{aligned}
\Omega := \{HHH, HHT, HTH, HTT, THH, THT, TTH, TTT\}\\
\end{aligned}$$

And the $$\sigma$$-algebra:

$$\begin{aligned}
\mathcal{F} &:= \mathcal{P}(\Omega)\\
\end{aligned}$$

At time $$0$$, we define $$F_{0}$$:

$$\begin{aligned}
\mathcal{F}_{0} := \{\emptyset, \Omega\}\\
\end{aligned}$$

Given the following events at time 1:

$$\begin{aligned}
A_{H} &:= \{HHH, HHT, HTH, HTT\}\\
A_{T} &:= \{THH, THT, TTH, TTT\}\\
\end{aligned}$$

We get the following $$\sigma$$-algebra:

$$\begin{aligned}
\mathcal{F}_{1} := &\sigma(\{A_{H}, A_{T}\})\\
&\mathcal{F}_{0} \subset \mathcal{F}_{1}\\
\end{aligned}$$

Given the following events at time 2:

$$\begin{aligned}
A_{HH} &:= \{HHH, HHT\}\\
A_{HT} &:= \{HTH, HTT\}\\
A_{TH} &:= \{THH, THT\}\\
A_{TT} &:= \{TTH, TTT\}\\
\end{aligned}$$

We get the following $$\sigma$$-algebra:

$$\begin{aligned}
\mathcal{F}_{2} := \sigma(&\{A_{HH}, A_{HT}, A_{TH}, A_{TT}\})\\
&\mathcal{F}_{0} \subset \mathcal{F}_{1} \subset \mathcal{F}_{2}\\
\end{aligned}$$

And finally at time 3:

$$\begin{aligned}
\mathcal{F}_{3} := \sigma(\{HHH, HHT&, HTH, HTT, THH, THT, TTH, TTT\}) = \mathcal{F}\\
&\mathcal{F}_{0} \subset \mathcal{F}_{1} \subset \mathcal{F}_{2} \subset \mathcal{F}_{3}\\
\end{aligned}$$

## <a name="cantelli"></a>Borel-Cantelli Lemmas

Given a measure space $$(\Omega, \mathcal{F}, P)$$, and defining the limit supremum of a sequence of events $$\{A_{i}\}$$ as the set of outcomes that occur infinitely many times:

$$\begin{aligned}
\limsup\limits_{i \rightarrow \infty} A_{i} &= \cap_{n = 1}^{\infty}\cup_{i = n}^{\infty}A_{i}\\
\end{aligned}$$

$$\cup_{i = n}^{\infty}A_{i}$$ also known as the "nth tail event" can be interpreted that at least one of $$\{A_{n + 1}, A_{n + 2}, \cdots\}$$ will occur.

### First Borel-Cantelli Lemma

If $$\{A_{1}, A_{2}, \: \cdots \}$$ are a sequence of events such that $$\sum_{i = 1}^{\infty}P(A_{i}) < \infty$$, then almost surely (with probability one) only finitely many $$\{A_{i}\}$$ will occur.

What the first Borel-Cantelli lemma is effectively saying that beyond a certain $$i$$, all the rest of the $$\{A_{i}\}$$ will fail to occur.

Using the limit supremum:

$$\begin{aligned}
P(\cap_{n = 1}^{\infty}\cup_{i = n}^{\infty}A_{i}) &= 0\\
\end{aligned}$$

Using the fact that $$\{A_{i}\}$$ are monotonically decreasing, continuity of a measure and union bound:

$$\begin{aligned}
P(\cap_{n = 1}^{\infty}\cup_{i = n}^{\infty}A_{i}) &= \lim\limits_{i \rightarrow \infty} P(\cup_{i = n}^{\infty}A_{i})\\
&\leq \lim\limits_{i \rightarrow \infty} \sum_{i = n}^{\infty} P(A_{i})\\
&= 0
\end{aligned}$$

### Second Borel-Cantelli Lemma

If $$\{A_{1}, A_{2}, \: \cdots \}$$ are independent events such that $$\sum_{i = 1}^{\infty}P(A_{i}) = \infty$$, then almost surely infinitely many $$\{A_{i}\}$$ occurs.

What the second Borel-Cantelli lemma is effectively saying that no matter how large $$i$$ is, at least one of $$\{A_{i + 1}, A_{i + 2}, \cdots\}$$ will occur.

Using the limit supremum:

$$\begin{aligned}
P(\cap_{n = 1}^{\infty}\cup_{i = n}^{\infty}A_{i}) &= 1\\
\end{aligned}$$

Similarly we can show the above by proving the complement:

$$\begin{aligned}
1 - P(\cap_{n = 1}^{\infty}\cup_{i = n}^{\infty}A_{i}) &= P(\cup_{n = 1}^{\infty}\cap_{i = n}^{\infty}A_{i}^{c})\\
&\leq \sum_{i = 1}^{\infty}P(\cap_{i = n}^{\infty}A_{i}^{c})\\
&= \sum_{i = 1}^{\infty}\lim\limits_{m \rightarrow \infty}\prod_{i = n}^{m}(1 - P(A_{i}))\\
&= \prod_{i = n}^{\infty}(1 - P(A_{i}))\\
&= 0\\
\end{aligned}$$

Therefore,

$$\begin{aligned}
P(\cap_{n = 1}^{\infty}\cup_{i = n}^{\infty}A_{i}) &= 1\\
\end{aligned}$$
