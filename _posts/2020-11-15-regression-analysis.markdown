---
layout: post
title: "Regression Analysis"
date: 2020-11-15 01:30:06 +0800
img : reg_ana2.png
tags: [statistics, regression, vif, multicollinearity]
---

We will be discussing a few statistics output that one would see when fitting a linear model and seeing the summary in R and multicollinearity.

<div class="toc" markdown="1">
# Contents:
- [$$R^{2}$$ Statistic](#r2)
- [Adjusted $$R^{2}$$ Statistic](#adjustedr2)
- [F Test](#ftest)
- [Multicollinearity](#multi)
- [Variance Inflation Factor (VIF)](#vif)
</div>

## <a name="r2"></a>$$R^{2}$$ Statistic

$$\begin{aligned}
R^{2} &= 1 - \frac{E[Var(Y \mid X = x)]}{\sigma_{Y}^{2}}\\
\end{aligned}$$

In classical regression model, we assume homoscedasticity $$Var(Y \mid X = x) = \sigma^{2}$$ and therefore:

$$\begin{aligned}
R^{2} &= 1 - \frac{\sigma^{2}}{\sigma_{Y}^{2}}\\
\end{aligned}$$

But usually we would not know the true $$\sigma^{2}$$ and will fall back on the MLE $$\hat{\sigma}^{2}$$ and $$\hat{\sigma}_{y}^{2}$$:

$$\begin{aligned}
\hat{\sigma}^{2} &= \frac{SSE}{n}\\[5pt]
\hat{\sigma}_{Y}^{2} &= \frac{SST}{n}\\[5pt]
SSE & = \sum_{i = 1}^{n}(y_{i} - \hat{y}_{i})^{2}\\
SST &= \sum_{i = 1}^{n}(y_{i} - \bar{y})^{2}\\
\end{aligned}$$

And we get the MLE $$R^{2}$$:

$$\begin{aligned}
R^{2} &= 1 - \frac{\hat{\sigma}^{2}}{\hat{\sigma}_{Y}^{2}}\\[5pt]
R^{2} &= 1 - \frac{SSE}{SST}\\
\end{aligned}$$

Note in the earlier Transformation [post]({% post_url 2020-11-07-transformation %}), we say that we tend to choose the transformation with the largest log-likelihood. This would correspond to the transformation with the largest $$R^2$$ and this might not always be what we want.

## <a name="adjustedr2"></a>Adjusted $$R^{2}$$ Statistic

MLE of variance is biased downwards because we are dividing by $$n$$ instead of $$n - k - 1$$. Adjusted $$R^{2}$$ is defined in order to correct the bias in $$\hat{\sigma}^{2}$$:

$$\begin{aligned}
R_{adj}^{2} &= 1 - \frac{\frac{SSE}{n - k - 1}}{\frac{SST}{n - 1}}\\
\end{aligned}$$

Surprisingly, adjusted $$R^{2}$$ is still a biased estimator (although less biased than unadjusted $$R^{2}$$) and it is not necessarily better than unadjusted $$R^{2}$$. You can use simulation to show that in some cases, unadjusted $$R^{2}$$ picks model that are closer to the true model than adjusted $$R^{2}$$. Furthermore, it is possible to get a negative value for adjusted $$R^{2}$$.

## <a name="ftest"></a>F Test

F statistic is defined as:

$$\begin{aligned}
SSR &= SST - SSE\\
F &= \frac{\frac{SSR}{k}}{\frac{SSE}{n - k - 1}}\\
\end{aligned}$$

And it is related to $$R^{2}$$ in the following way:

$$\begin{aligned}
F &= \frac{n - k -1}{k}\times \frac{R^{2}}{1 - R^{2}}\\
\end{aligned}$$

The F statistic is used to test the null hypothesis where $$H_{0}: \beta_{1} = \beta_{2} = \cdots = 0$$ is true and follows the following distribution:

$$\begin{aligned}
F \sim F_{k, n-k -1}
\end{aligned}$$

You can read more about the F test and distribution [here]({% post_url 2020-10-06-hypothesis-testing-part3 %}).

It is similary to $$R^{2}$$ in the sense that if the null hypothesis is true, $$R^{2} = 0$$ and since $$R^{2} > 0$$, F test only test for large positive values and hence only the right tail of the distribution is used.

## <a name="multi"></a>Multicollinearity

Multicollinearity is when 2 or more variables are closely linear related such that:

$$\begin{aligned}
X_{j} &\approx a_{0}X_{0} + \cdots + a_{j-1}X_{j - 1} + a_{j+1}X_{j+1} + \cdots + a_{k}X_{k}\\
\end{aligned}$$

If the above equation is equality, then there will be perfect multicollinearity and the matrix $$\mathbf{X^{T}X}$$ will be singular and invertible. This is not surprising as row/column $$j$$ will be redundnant.

But instead of perfect multicollinearity, if the variables are very closely related, there is very little variation when you fix one of the variable and this would cause standard errors to rise.

For example in the following plot, setting $$x_{2} = 0$$ and varying $$x_{1}$$ from 0 to 1:

{% highlight r %}
set.seed(123)
x1 <- rnorm(100)
x2 <- x1 + rnorm(100, 0, 1)
plot(x1, x2)
abline(h = 0, col = "red")
abline(v = 0, col = "blue")
abline(v = 1, col = "blue")
segments(-3, -3, 3, 3)

z <- x1 + x2 + rnorm(100, 0, 0.5)   
fit <- lm(z ~ x1 + x2)
{% endhighlight %}

![](/assets/img/reg_ana1.png)

We can see some variation between $$0 \leq x_{1} \leq 1$$ when $$x_{2} = 0$$ and simulating and plotting a 3rd dimension $$z$$:

![](/assets/img/reg_ana2.png)

But if $$x_{1}$$ and $$x_{2}$$ are closely related, we can see less variation:

{% highlight r %}
set.seed(123)
x1 <- rnorm(100)
x2 <- x1 + rnorm(100, 0, 0.1)   
{% endhighlight %}

![](/assets/img/reg_ana3.png)

![](/assets/img/reg_ana4.png)

When there are more variation, the estimates of $$\beta_{j}$$ will be more accurate and standard errors will likewise decrease and the overall $$R^{2}$$ will increase.

## <a name="vif"></a>Variance Inflation Factor (VIF)

Back in the multiple regression [post]({% post_url 2020-11-11-multiple-regression %}), we see that:

$$\begin{aligned}
SE(\bm{\hat{\beta_{j}}} \mid \mathbf{X = x}) &= \hat{\sigma}\sqrt{\mathrm{diag}(\mathbf{(x^{T}x)^{-1}})}\\
\end{aligned}$$

With some algebra, we can see the standard error for $$\beta_{j}$$ in terms of $$R_{j}^2$$:

$$\begin{aligned}
SE(\beta_{j}) &= \frac{\hat{\sigma}}{\sum_{i = 1}^{n}(x_{i} - \bar{x})^2} \times \sqrt{\frac{1}{1 - R_{j}^{2}}}\\
\end{aligned}$$

Where $$R_{j}^{2}$$ is the $$R^{2}$$ you get from regressing $$X_{j}$$ on the rest of the $$X_{-j}$$ variables.

Also in the extreme case when $$R_{j}^{2} = 0$$, the standard error is the same as if there is only 1 variable:

$$\begin{aligned}
SE(\beta_{j}) &= \frac{\hat{\sigma}}{\sum_{i = 1}^{n}(x_{i} - \bar{x})^2}
\end{aligned}$$

And when $$R_{j}^{2} = 1$$, the standard error will tend to $$\infty$$ as the matrix becomes singular:

$$\begin{aligned}
SE(\beta_{j}) &= \frac{\hat{\sigma}}{\sum_{i = 1}^{n}(x_{i} - \bar{x})^2} \times \frac{1}{0} = \infty\\
\end{aligned}$$

$$\frac{1}{1 - R_{j}^2}$$ is known as the variance inflation factor (VIF) because it measures how much the variance is inflated due to multiconllinearity.

$$\begin{aligned}
VIF &= \frac{1}{1 - R_{j}^2}\\
SE(\beta_{j}) &= \frac{\hat{\sigma}}{\sum_{i = 1}^{n}(x_{i} - \bar{x})^2} \times \sqrt{VIF}
\end{aligned}$$

In the above example where the first fit as more variation, the summary of the fit:

{% highlight r %}
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  0.06753    0.04807   1.405    0.163    
x1           0.92151    0.07030  13.108   <2e-16 ***
x2           1.01191    0.04950  20.444   <2e-16 ***
---

Residual standard error: 0.4756 on 97 degrees of freedom
Multiple R-squared:  0.9462,	Adjusted R-squared:  0.9451    
F-statistic: 853.5 on 2 and 97 DF,  p-value: < 2.2e-16
{% endhighlight %}

And in the second fit where the variables are more closely related:

{% highlight r %}
Coefficients:
            Estimate Std. Error t value Pr(>|t|)  
(Intercept)  0.06753    0.04807   1.405    0.163  
x1           0.81436    0.49515   1.645    0.103  
x2           1.11906    0.49497   2.261    0.026 *
---

Residual standard error: 0.4756 on 97 degrees of freedom
Multiple R-squared:  0.9334,	Adjusted R-squared:  0.932    
F-statistic: 679.9 on 2 and 97 DF,  p-value: < 2.2e-16
{% endhighlight %}

One can see that the t-statistic of the second fit as gone down for both variables, the p-value and the standard errors have both increased. Despite this, the F-statistic is still significant and pretty high. This is a tell-tale sign that we have multicollinearity in place.

Let's compute the VIF and verify the calculation:

{% highlight r %}
> 1 / sqrt(1 - summary(lm(x1 ~ x2))$r.squared)   
[1] 9.454839
{% endhighlight %}

This means that the standard error will be inflated 9.45 times as compared to if the variables are uncorrelated. This is within the range of the first fit where we have less correlation between the variables:

{% highlight r %}
> 0.49515 / (1 / sqrt(1 - summary(lm(x2 ~ x1))$r.squared))    
[1] 0.05237001
{% endhighlight %}
