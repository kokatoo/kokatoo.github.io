---
layout: post
title: "Multiple Regression"
date: 2020-11-11 01:30:06 +0800
img : multi10.png
tags: [statistics, regression, expectation]
---

Multiple regression refers to a regression model where there are more than 1 predictors. The classical multiple regression model conditional distribution is given as:

$$\begin{aligned}
Y_{i} \mid X_{i1} = x_{i1}, X_{i2} = x_{i2}, ..., X_{ik} = x_{ik} \sim N(\beta_{0} + \beta_{1}x_{i1} + \beta_{2}x_{i2} + ... + \beta_{k}x_{ik}, \sigma^2)
\end{aligned}$$

<div class="toc" markdown="1">
# Contents:
- [Matrix Form](#matrix)
- [Standard Errors](#standard)
- [Confounding Variable](#confounding)
- [Law of Iterated Expectation](#law)
</div>

## <a name="matrix"></a>Matrix Form

In order to explain multiple regression, we would have to use matrix algebra. In matrix form with $$n$$ observations and $$k$$ variables:

$$\begin{aligned}
\mathbf{Y = X\bm{\beta} + \bm{\epsilon}}\\
\end{aligned}$$

$$\begin{aligned}
\begin{bmatrix}
Y_{1}\\
Y_{2}\\
\vdots\\[3pt]
Y_{n}
\end{bmatrix}
 = 
\begin{pmatrix}
1 & X_{11} & X_{12} & \cdots & X_{1k} \\
1 & X_{21} & X_{22} & \cdots & X_{2k} \\
\vdots & \vdots & \vdots & \ddots & \vdots \\[3pt]
1 & X_{n1} & X_{n2} & \cdots & X_{nk} \\
\end{pmatrix}
\begin{bmatrix}
\beta_{0}\\
\beta_{1}\\
\vdots\\[3pt]
\beta_{k}\\
\end{bmatrix}
 + 
\begin{bmatrix}
\epsilon_{0}\\
\epsilon_{1}\\
\vdots\\[3pt]
\epsilon_{k}\\
\end{bmatrix}
\end{aligned}$$

To derive $$\bm{\beta}$$, we need to minimize the sum of squares:

$$\begin{aligned}
SSE(\beta_{0}, \beta_{1}, ..., \beta_{k}) &= \sum_{i = 1}^{n}(y_{i} - (\beta_{0} + \beta_{1}x_{i1} + ... + \beta_{k}x_{ik}))^2
\end{aligned}$$

By taking the partial derivatives and setting them to 0:

$$\begin{aligned}
\frac{\partial SSE}{\partial\beta_{0}} &= n\beta_{0} + \sum_{i = 1}^{n} x_{i1}\beta_{1} + ... + \sum_{i = 1}^{n}\beta_{k}x_{ik} - \sum_{i = 1}^{n} 1y_{i} = 0\\
\frac{\partial SSE}{\partial\beta_{1}} &= \sum_{i1}\beta_{0} + \sum_{i = 1}^{n} x_{i1}^{2}\beta_{1} + ... + \sum_{i = 1}^{n}\beta_{k}x_{i1}x_{ik} - \sum_{i = 1}^{n}x_{i1}y_{i} = 0\\
...\\
\frac{\partial SSE}{\partial\beta_{k}} &= \sum_{ik}\beta_{0} + \sum_{i = 1}^{n} x_{ik}^{2}\beta_{1} + ... + \sum_{i = 1}^{n}\beta_{k}x_{ik}^{2} - \sum_{i = 1}^{n}x_{ik}y_{i} = 0\\
\end{aligned}$$

Moving the $$y$$ component to the right:

$$\begin{aligned}
\frac{\partial SSE}{\partial\beta_{0}} &= n\beta_{0} + \sum_{i = 1}^{n} x_{i1}\beta_{1} + ... + \sum_{i = 1}^{n}\beta_{k}x_{ik} = \sum_{i = 1}^{n} 1y_{i}\\
\frac{\partial SSE}{\partial\beta_{1}} &= \sum_{i1}\beta_{0} + \sum_{i = 1}^{n} x_{i1}^{2}\beta_{1} + ... + \sum_{i = 1}^{n}\beta_{k}x_{i1}x_{ik} = \sum_{i = 1}^{n}x_{i1}y_{i}\\
...\\
\frac{\partial SSE}{\partial\beta_{k}} &= \sum_{ik}\beta_{0} + \sum_{i = 1}^{n} x_{ik}^{2}\beta_{1} + ... + \sum_{i = 1}^{n}\beta_{k}x_{ik}^{2} = \sum_{i = 1}^{n}x_{ik}y_{i}\\
\end{aligned}$$

This is equivalent to:

$$\begin{aligned}
\mathbf{X^{T}X\hat{\bm{\beta}} = X^{T}Y}
\end{aligned}$$

Note that $$\mathbf{X^{T}X}$$ is a square matrix and if it is invertible then:

$$\begin{aligned}
\mathbf{(X^{T}X)^{-1}X^{T}X\hat{\bm{\beta}} = (X^{T}X)^{-1}X^{T}Y}\\
\mathbf{I\bm{\hat{\beta}} = (X^{T}X)^{-1}X^{T}Y}\\
\mathbf{\bm{\hat{\beta}} = (X^{T}X)^{-1}X^{T}Y}\\
\end{aligned}$$

Note that you don't really need to derive the partial differentiation as using matrix algebra alone is able to solve the above equation intuitively. But it is good to know that it is equivalent to the partial derivatives.

We can show that:

$$\begin{aligned}
\bm{\hat{\beta}} &= \mathbf{\bm{\beta} + (X^{T}X)^{-1}X^{T}\bm{\epsilon}}\\
\end{aligned}$$

And that:

$$\begin{aligned}
E[\mathbf{(X^{T}X)^{-1}X^{T}\bm{\epsilon} \mid X = x]} &= 0
\end{aligned}$$

And hence:

$$\begin{aligned}
E[\bm{\hat{\beta}} \mid \mathbf{X = x}] &= \bm{\beta}
\end{aligned}$$

In other words, $$\bm{\hat{\beta}}$$ is an unbiased estimator of $$\bm{\beta}$$ conditional on $$\mathbf{X = x}$$.

By law of total/iterated expectation:

$$\begin{aligned}
E[\bm{\hat{\beta}}] &= E[E[\bm{\hat{\beta}} \mid \mathbf{X = x}]]\\
&= E[\bm{\beta}]\\
&= \bm{\beta}
\end{aligned}$$

So even for random-X data, $$\bm{\hat{\beta}}$$ is unbiased estimator.

## <a name="standard"></a>Standard Errors

First note the following identities:

$$\begin{aligned}
\mathrm{Cov}(\mathbf{AY}) &= \mathbf{A}\mathrm{Cov}(\mathbf{Y})\mathbf{A^{T}}\\
\mathbf{(AB)^{T}} &= \mathbf{B^{T}A^{T}}\\
\mathbf{(A^{T}A)^{T}} &= \mathbf{A^{T}(A^{T})^{T}} = \mathbf{A^{T}A}\\
\mathbf{A^{T}(A^{-1})^{T}} &= \mathbf{(A^{-1}A)^{T}} = \mathbf{I}\\
\end{aligned}$$

Next let's derive the covariance of the coefficient vector $$\bm{\hat{\beta}}$$:

$$\begin{aligned}
\mathrm{Cov}(\mathbf{\bm{\hat{\beta}} \mid X = x)} &= \mathrm{Cov}(\mathbf{(X^{T}X)^{-1}X^{T}Y \mid X = x)}\\
&= \mathbf{(x^{T}x)^{-1}x^{T}(\sigma^2I)((x^{T}x)^{-1}x^{T})^{T}}\\
&= \sigma^{2}\mathbf{(x^{T}x)^{-1}x^{T}((x^{T}x)^{-1}x^{T})^{T}}\\
&= \sigma^{2}\mathbf{(x^{T}x)^{-1}x^{T}x[(x^{T}x)^{-1}]^{T}}\\
&= \sigma^{2}\mathbf{(x^{T}x)^{-1}x^{T}x(x^{T}x)^{-1}}\\
&= \sigma^{2}\mathbf{(x^{T}x)^{-1}I}\\
&= \sigma^{2}\mathbf{(x^{T}x)^{-1}}
\end{aligned}$$

The matrix expansion of $$\mathbf{x^{T}x}$$:

$$\begin{aligned}
\mathbf{x^{T}x} &= 
\begin{pmatrix}
1 & x_{11} & x_{12} & \cdots & x_{1k} \\
1 & x_{21} & x_{22} & \cdots & x_{2k} \\
\vdots & \vdots & \vdots & \ddots & \vdots \\[3pt]
1 & x_{n1} & x_{n2} & \cdots & x_{nk} \\
\end{pmatrix}^{T}
\begin{pmatrix}
1 & x_{11} & x_{12} & \cdots & x_{1k} \\
1 & x_{21} & x_{22} & \cdots & x_{2k} \\
\vdots & \vdots & \vdots & \ddots & \vdots \\[3pt]
1 & x_{n1} & x_{n2} & \cdots & x_{nk} \\
\end{pmatrix}\\
&=
\begin{pmatrix}
1 & 1 & 1 & \cdots & 1\\
x_{11} & x_{21} & x_{31} & \cdots & x_{n1}\\
\vdots & \vdots & \vdots & \ddots & \vdots \\[3pt]
x_{1k} & x_{2k} & x_{3k} & \cdots & x_{nk}
\end{pmatrix}
\begin{pmatrix}
1 & x_{11} & x_{12} & \cdots & x_{1k} \\
1 & x_{21} & x_{22} & \cdots & x_{2k} \\
\vdots & \vdots & \vdots & \ddots & \vdots \\[3pt]
1 & x_{n1} & x_{n2} & \cdots & x_{nk} \\
\end{pmatrix}\\
&=
\begin{pmatrix}
n & \sum_{i = 1}^{n}x_{i1} & \sum_{i = 1}^{n}x_{i2} & \cdots & \sum_{i = 1}^{n}x_{ik}\\
\sum_{i = 1}^{n}x_{i1} & \sum_{i = 1}^{n}x_{i1}^{2} & \sum_{i = 1}^{n}x_{i1}x_{i2} & \cdots & \sum_{i = 1}^{n}x_{i1}x_{ik}\\
\vdots & \vdots & \vdots & \ddots & \vdots \\[3pt]
\sum_{i = 1}^{n}x_{ik} & \sum_{i = 1}^{n}x_{ik}x_{i1} & \sum_{i = 1}^{n}x_{ik}x_{i2} & \cdots & \sum_{i = 1}^{n}x_{ik}^{2}\\
\end{pmatrix}\\
\end{aligned}$$

Follow by the variance:

$$\begin{aligned}
Var(\bm{\hat{\beta_{j}}} \mid \mathbf{X = x}) &= \sigma^{2}\mathrm{diag}(\mathbf{(x^{T}x)^{-1}})\\
SE(\bm{\hat{\beta_{j}}} \mid \mathbf{X = x}) &= \hat{\sigma}\sqrt{\mathrm{diag}(\mathbf{(x^{T}x)^{-1}})}\\
\end{aligned}$$

For a single variable classical regression, we get the following formulas:

$$\begin{aligned}
Var(\hat{\beta_{0}}) &= \sigma^{2}(\frac{1}{n} + \frac{\bar{x}^{2}}{\sum_{i = 1}^{n}(x_{i} - \bar{x})^{2}})\\
Var(\hat{\beta_{1}}) &= \frac{\sigma^{2}}{\sum_{i = 1}^{n}(x_{i} - \bar{x})^{2}}\\
\end{aligned}$$


## <a name="Confounding"></a>Confounding Variable

In multiple regression, the coefficients have different interpretation depending on which parameters appear in the particular model. Each coefficient for each parameter is interpretated as all other parameters held fixed. Let's illustrate this more clearly using an example.

Let's picture this scenario where drowning increases during summer and likewise icecream sales increases during summer as well. If you were to fit a linear model between icecream sales and drowning, we will get a pretty good fit because icecream sales is positively associated with drowning. But this relationship is clearly not causal because there is an underlying common confounding variable that is related to both icecream sales and drowning, namely the temperature. Multiple regression has a way to eliminate this dubious relationship by the way we interpret the coefficients.

So let's simulate some dummy data to mimick the confounding relationship:

{% highlight r %}
temp <- rnorm(100, 30, 5)
icecream <- 100 + 0.5 * temp + rnorm(100, 0, 3)   
drowning <- -60 + 1 * temp + rnorm(100, 0, 5)
{% endhighlight %}

Let's fit a model to temperature and icecream sales:

{% highlight r %}
fit <- lm(icecream ~ temp)  
plot(temp, icecream)
summary(fit)
abline(fit, col = "red")
{% endhighlight %}

![](/assets/img/multi1.png)

Not surprisingly we see a positive relationship between temperature and icecream sales with a significant temperature coefficient:

{% highlight r %}
Coefficients:
             Estimate Std. Error t value Pr(>|t|)
(Intercept) 100.63608    1.97440  50.971  < 2e-16 ***
temp          0.46852    0.06413   7.306 7.43e-11 ***
---
Residual standard error: 2.912 on 98 degrees of freedom
Multiple R-squared:  0.3526,	Adjusted R-squared:  0.346    
F-statistic: 53.38 on 1 and 98 DF,  p-value: 7.428e-11
{% endhighlight %}

Similarly for temperature vs drowning:

{% highlight r %}
fit <- lm(drowning ~ temp)   
plot(temp, drowning)
abline(fit, col = "red")
summary(fit)
{% endhighlight %}

![](/assets/img/multi2.png)

Also not surprisingly we see a positive relationship between temperature and drowning with a significant temperature coefficient:

{% highlight r %}
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   4.6957     3.2093 -17.233  < 2e-16 ***
temp          0.8656     0.1042   8.304 5.67e-13 ***
---
Residual standard error: 4.734 on 98 degrees of freedom       
Multiple R-squared:  0.413,	Adjusted R-squared:  0.407 
F-statistic: 68.96 on 1 and 98 DF,  p-value: 5.672e-13
{% endhighlight %}

And finally we come to the positive relationship between icecream sales and drowning and we know that it comes from the confounding temperature variable as we are the one that simulate this data.

{% highlight r %}
fit <- lm(drowning ~ icecream)  
plot(icecream, drowning)
abline(fit, col = "red")
summary(fit)
{% endhighlight %}

![](/assets/img/multi3.png)

And the relationship is just as significant:

{% highlight r %}
Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) -46.7520    18.1970  -2.569   0.0117 *  
icecream      0.6771     0.1583   4.278 4.39e-05 ***
---
Residual standard error: 5.672 on 98 degrees of freedom
Multiple R-squared:  0.1574,	Adjusted R-squared:  0.1488     
F-statistic:  18.3 on 1 and 98 DF,  p-value: 4.392e-05

{% endhighlight %}

But what happens if we do a multiple regression instead?

{% highlight r %}
fit <- lm(drowning ~ icecream + temp)    
summary(fit)
{% endhighlight %}

Surprise surprise, the icecream sales variable is no longer statistically significant:

{% highlight r %}
Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept)  0.70193   16.91433   0.041    0.967    
icecream     0.03969    0.16499   0.241    0.810    
temp         0.84699    0.13018   6.506 3.38e-09 ***
---
Residual standard error: 4.756 on 97 degrees of freedom
Multiple R-squared:  0.4134,	Adjusted R-squared:  0.4013     
F-statistic: 34.18 on 2 and 97 DF,  p-value: 5.829e-12
{% endhighlight %}

To get a clearer view, let's plot the regression plane in 3D:

{% highlight r %}
f <- function(x, y) {
  x * fit$coefficients["temp"] + y * fit$coefficients["icecream"]     
}

rgl::plot3d(
    f,
    xlim = c(15, 45),
    ylim = c(105, 125),
    xlab = "Temperature",
    ylab = "Icecream",
    zlab = "Drowning",
    alpha = 0.5
)
rgl::plot3d(temp, icecream, drowning, type = "p", add = TRUE, col = "blue")     
{% endhighlight %}

![](/assets/img/multi4.png)

We can see the plane is almost parallel to icecream sales axis and that is because the coefficient of icecream is very close to 0. But why is this so?

{% highlight r %}
  (Intercept)     icecream         temp    
-59.29807498   0.03968548   0.84698573 
{% endhighlight %}

If you rotate the 3D plot to the right angle, you can see the similarity with the 2D scatterplot.

<img src="/assets/img/multi5_1.png" style="float:left;width: 40%;padding-right: 5px;">
<img src="/assets/img/multi5_2.png" style="clear:both;width: 40%">

<div style="padding-bottom:40px">
<img src="/assets/img/multi6_1.png" style="float:left;width: 40%;padding-right: 5px;">
<img src="/assets/img/multi6_2.png" style="clear:both;width: 40%">
</div>

<img src="/assets/img/multi7_1.png" style="float:left;width: 40%;padding-right: 5px;">
<img src="/assets/img/multi7_2.png" style="clear:both;width: 40%">

<div style="clear:both;">
</div>

As you can see from the plot below, the plane that minimizes the sum of squares slices the data points pretty much the same as what we get from Drowning vs Temperature scatterplot:

![](/assets/img/multi8.png)

How do one interpret the coefficients? For example when looking at temperature coefficient, you need to fix the other coefficients and in this case icecream sales. By fixing icecream sales at 115, we can see temperature slope of 0.85:

{% highlight r %}
rgl::planes3d(0, 1, 0, -115, col = "red", alpha = 0.6)    
{% endhighlight %}

![](/assets/img/multi9.png)

And by fixing temperature, we can see the effect of icecream sales. As you can see the slope is close to 0:

{% highlight r %}
rgl::planes3d(1, 0, 0, -30, col = "red", alpha = 0.6)    
{% endhighlight %}

![](/assets/img/multi10.png)

The way I see this is if the plane is perpendicular to itself, then icecream sales coefficient will be significant and not temperature. Because both icecream sales and temperature are correlated, they point to about the same direction and hence the plane would be perpendicular but because temperature is a better fit, all the variability went to be explained by temperature and leaving icecream sales in the dust.

## <a name="law"></a>Law of Iterated Expectation

To wrap things up, let's review an important proposition in probability theory known as law of iterated/total expectation:

Given $$E[Y] < \infty$$:

$$\begin{aligned}
E[E[Y \mid \mathbf{X}]] &= E[Y]\\
\end{aligned}$$

If $$\mathbf{X}$$ is discrete:

$$\begin{aligned}
E[E[Y \mid \mathbf{X}]] &= \sum_{i = 1}^{\infty}E[Y \mid \mathbf{X}]p(\mathbf{x_{i}}) = E[Y]\\
\end{aligned}$$

If $$\mathbf{X}$$ is continuous:

$$\begin{aligned}
E[E[Y \mid \mathbf{X}]] &= \int_{\mathbb{R}^{k}}E[Y \mid \mathbf{X}]f(\mathbf{x})d\mathbf{x} = E[Y]\\
\end{aligned}$$

In other words, we will be able to simplify and get rid of the conditional probability by summing up the weighted average of all possible $$\mathbf{X = x}$$.

Similarly, we can do this for multiple variables:

$$\begin{aligned}
E[E[Y \mid \mathbf{X_{1}, X_{2}}] \mid \mathbf{X_{1}}] &= E[Y \mid \mathbf{X_{1}}]\\
\end{aligned}$$

Note that both sides are conditioned on $$\mathbf{X_{1}}$$ and $$\mathbf{X_{2}}$$ is the variable that is averaged out:

$$\begin{aligned}
E[E[Y \mid \mathbf{X_{1}, X_{2}}] \mid \mathbf{X_{1}}] &= \sum_{i = 1}^{\infty}E[Y \mid \mathbf{X_{1}, X_{2}}]p(\mathbf{x_{2i} \mid x_{1}}) = E[Y \mid \mathbf{X_{1}}]\\
&= \int_{\mathbb{R}^{k}}E[y \mid \mathbf{X_{1}, X_{2}}]f(\mathbf{x_{2} \mid x_{1}})d\mathbf{x_{2}} = E[Y \mid \mathbf{X_{1}}]\\
\end{aligned}$$

When conditioned on $$\mathbf{X}$$, you are essentially treating it as a constant $$\mathbf{X = x}$$ so:

$$\begin{aligned}
E[\mathbf{X|X}] &= \mathbf{X}\\
E[\mathbf{g(X)|X}] &= \mathbf{g(X)}\\
\end{aligned}$$

Furthermore,

$$\begin{aligned}
E[g(\mathbf{X})Y \mid \mathbf{X}] &= g(\mathbf{X})E[Y \mid \mathbf{X}]\\
E[g(\mathbf{X})Y] &= E[g(\mathbf{X})E[Y \mid \mathbf{X}]]\\
\end{aligned}$$
