---
layout: post
title: "Confusion Matrix"
date: 2020-10-11 03:30:06 +0800
img : 
tags: [statistics]
---

In a binary classification test, you will tend to see the following confusion matrix:

|                    | Actual Positive       | Actual Negative                   |
|--------------------|-----------------------|-----------------------------------|
| Predicted Positive | True Positive (Hit)   | False Positive (False Alarm)      |
| Predicted Negative | False Negative (Miss) | True Negative (Correct Rejection) |

Or in the following format:

|                    | Actual Positive | Actual Negative |
|--------------------|-----------------|-----------------|
| Predicted Positive | True Positive   | Type I Error    |
| Predicted Negative | Type II Error   | True Negative   |

Or in terms of Null/Alternative Hypothesis:

|                    | H0 is False | H0 is True       |
|--------------------|-------------|------------------|
| Predicted Positive | Power       | Alpha            |
| Predicted Negative | Beta        | Correct Decision |

## Sensitivity and Specificity

Consider a patient going for a test for an infection.

Sensitivity is the probability that the test is positive given that the patient is infected:

$$\begin{aligned}
Sensitivity &= \frac{True\: Positive}{True\: Positive + False\: Negative}\\\\
&= \frac{True\: Positive}{Actual\: Positive}
\end{aligned}$$

Specificity is the probability that the test is negative given that the patient is not infected:

$$\begin{aligned}
Specificity &= \frac{True\: Negative}{True\: Negative + False\: Positive}\\\\
&= \frac{True\: Negative}{Actual\: Negative}
\end{aligned}$$

## Odds Ratio

Odds ratio can be defined as the ratio of the odds of the test being positive given that the patient is infected relative to the odds of the test being positive given that the patient is not infected.

|                     | Actual Positive | Actual Negative |
|---------------------|-----------------|-----------------|
| With Risk Factor    | True Positive   | False Positive  |
| Without Risk Factor | False Negative  | True Negative   |

$$Odds\: Ratio = \frac{True\: Positive \mathbin{/} False\: Positive} {False\: Negative \mathbin{/} True\: Negative}$$

Example:

|            | Cancer | No Cancer |
|------------|--------|-----------|
| Smoker     |     10 |       100 |
| Non Smoker |      1 |       100 |

|            | Cancer | No Cancer |
|------------|--------|-----------|
| Smoker     | 10     | 10,000    |
| Non Smoker | 1      | 10,000    |

The Odds Ratio is often used to compare an experimental vs a control condition. Note that the Odds Ratio is independent from the incidence rate (rate of Actual Positive). For example, the OR of `(10/100)/(1/100)` is the same as `(10/10,000)/(1/10,000)` even though the likelihood of a main effect `10/110` vs `10/10,010` (`TP/With Risk Factor` or `TP/(TP+FP)`) has increased by a factor of 100. In other words, a high OR is only a reason to worry about if the main effect is high as well. The converse is true as well. We only worry about a high main effect if only the OR is high as well.



