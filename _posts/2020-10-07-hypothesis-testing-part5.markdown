---
layout: post
title: "Hypothesis Testing (Part 5) Fixed, Random and Mixed Effects"
date: 2020-10-10 03:30:06 +0800
img : interaction2.png
categories:
---
Today we will continue with part 5 of the Hypothesis Testing series on Fixed and Random Effects. If you haven't checked out part 4 please check it out [here]({% post_url 2020-10-07-hypothesis-testing-part4 %})

## Part 5: Fixed, Random and Mixed Effects

Until now we have assumed the two independent variables (treatment vs gender) had fixed effects and we had a fixed effects model. What this mean is that the levels are not chosen at random but chosen deliberately. However, if the levels are chosen at random from a population of possible levels, we have a random effects model.

The test statistics used to test the hypothesis are different across these 3 effects. For the fixed effects model:

$$\begin{aligned}
F_{Treatment} &= \frac{SS_{Treatment} \mathbin{/} (a - 1)}{SS_{Error} \mathbin{/} (N - ab)} = \frac{MS_{Treatment}}{MS_{Error}}\\\\
F_{Gender} &= \frac{SS_{Gender} \mathbin{/} (b - 1)}{SS_{Error} \mathbin{/} (N - ab)} = \frac{MS_{Gender}}{MS_{Error}}\\\\
F_{Treatment, Gender} &= \frac{SS_{Treatment, Gender} \mathbin{/} (a - 1)(b - 1)}{SS_{Error} \mathbin{/} (N - ab)} = \frac{MS_{Treatment,Gender}}{MS_{Error}}
\end{aligned}$$

For the random effects model:

$$\begin{aligned}
F_{Treatment} &= \frac{SS_{Treatment} \mathbin{/} (a - 1)}{SS_{Treatment,Gender} \mathbin{/} (a - 1)(b - 1)} = \frac{MS_{Treatment}}{MS_{Treatment,Gender}}\\\\
F_{Gender} &= \frac{SS_{Gender} \mathbin{/} (b - 1)}{SS_{Treatment,Gender} \mathbin{/} (a - 1)(b - 1)} = \frac{MS_{Gender}}{MS_{Treatment,Gender}}\\\\
F_{Treatment, Gender} &= \frac{SS_{Treatment, Gender} \mathbin{/} (a - 1)(b - 1)}{SS_{Treatment,Gender} \mathbin{/} (N - ab)} = \frac{MS_{Treatment,Gender}}{MS_{Error}}
\end{aligned}$$

For the mixed effects model, let's assume `Treatment` is random and `Gender` is fixed:

$$\begin{aligned}
F_{Treatment} &= \frac{SS_{Treatment} \mathbin{/} (a - 1)}{SS_{Treatment,Gender} \mathbin{/} (N - ab)} = \frac{MS_{Treatment}}{MS_{Error}}\\\\
F_{Gender} &= \frac{SS_{Gender} \mathbin{/} (b - 1)}{SS_{Treatment,Gender} \mathbin{/} (a - 1)(b - 1)} = \frac{MS_{Gender}}{MS_{Treatment,Gender}}\\\\
F_{Treatment, Gender} &= \frac{SS_{Treatment, Gender} \mathbin{/} (a - 1)(b - 1)}{SS_{Treatment,Gender} \mathbin{/} (N - ab)} = \frac{MS_{Treatment,Gender}}{MS_{Error}}
\end{aligned}$$

Note that the fixed factor has mean square interaction in the denominator for the mixed effects model.

The reason for these different test statistics have to do with the expected value of the mean squared term. For fixed effects, the expected value contain the population variance term while for random effects contain the variances of the effect sizes for the treatment, gender and interaction factors.
