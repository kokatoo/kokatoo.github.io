---
layout: post
title: "Transformations"
date: 2020-11-07 01:30:06 +0800
img : trans3.png
tags: [statistics, regression, jensen, elasticity, likelihood]
---

What do you do when your data violates your model assumptions? One of the reason why you might contemplate doing a transformation is to reduce the violations to an acceptable level. But do not transform just for that. Only do it if it makes sense from a subject matter perspective and that you are not just transforming noise or erroneous data.

Other reasons you might want to transform your data is to reduce the effect of outliers and building a more accurate model.

<div class="toc" markdown="1">
# Contents:
- [$$ln(x)$$ Transformation](#lnx)
- [$$x^{-1}$$ Transformation](#inverse)
- [Jensen's Inequality](#jensen)
- [$$ln(y)$$ Transformation](#lny)
- [$$\frac{1}{Y}$$ Transformation](#inversey)
- [Box-Cox Transformation](#box)
- [Elasticity](#elasticity)
- [Likelihood](#likelihood)
</div>

## <a name="lnx"></a>$$ln(x)$$ Transformation

When you do a $$ln(x)$$ transformation, your transformed model will look like this:

$$\begin{aligned}
Y = \beta_{0} + \beta_{1}ln(X) + \epsilon\\
\end{aligned}$$

And the conditional mean function:

$$E(Y \mid X = x) = \beta_{0} + \beta_{1}ln(x)$$

So what does that mean? Let's simulate some data to make this clear. Suppose you have some data that looks like this and you try to fit a linear regression:

{% highlight r %}
x <- seq(0.1, 10, 0.1)
y <- log(x) + rnorm(length(x), 0, 0.6)   
fit <- lm(y ~ x)
plot(x, y)
abline(fit, col = "red")
{% endhighlight %}

![](/assets/img/trans1.png)

Just by eyeballing the fit and the scatterplot, we can see the relationship is nonlinear, and there are other violations to the OLS assumptions. 

But by transforming $$X$$, we get the following linear fit:

{% highlight r %}
fit <- lm(y ~ log(x))
plot(log(x), y)
abline(fit, col = "red")   
{% endhighlight %}

![](/assets/img/trans2.png)

We can see the linear fit is more appropriate for the transformed data and the assumptions of linearity, homoscedasticity, and normality are more satisfied.

To fit the model to the original untransformed $$X$$, we derived the parameters from the fit and plot it accordingly:

{% highlight r %}
b0 <- fit$coefficients[1]
b1 <- fit$coefficients[2]
y_hat <- b0 + b1 * log(x)
points(x, y_hat, type = "l", col = "red")    
{% endhighlight %}

![](/assets/img/trans3.png)

So in summary, $$ln(x)$$ is done to transformed x-y to a linear space in order to do a linear fit. So how do we know when $$ln(x)$$ is a suitable transformation? A simple way is to see whether your data looks like the following plots:

{% highlight r %}
plot(x,
    log(x) + 1,
    type = "l",
    ylim = c(-4, 4),
    ylab = "E(Y | X = x)",
    col = cols[1],
    main = "b0 + b1 * ln(x)")
points(x,
    0.1 * log(x) + 1,
    type = "l",
    col = cols[2]
)
points(x,
    -1 * log(x) + 1,
    type = "l",
    col = cols[3]
)
points(x,
    -0.1 * log(x) + 1,
    type = "l",
    col = cols[4]
)
legend(
    x = 8,
    y = -1.5,
    c("b0 = 1.0, b1 = 1.0", "b0 = 1.0, b1 = 0.1", "b0 = 1.0, b1 = -1.0", "b0 = 1.0, b1 = -0.1"),       
    col = cols,
    cex = 0.8,
    lty = 1
)
{% endhighlight %}

![](/assets/img/trans4.png)

Note that $$\displaystyle{\lim_{x \to 0}f(x) = \pm \infty}$$. If your data have zero values or values close to 0, do a $$ln(x + 1)$$ transformation instead.

So how do we interpret the coefficients? $$\beta_{0}$$ is the intercept when $$ln(x) = 0$$. This occurs when $$x = 1$$. So $$\beta_{0}$$ is the y-intercept when $$x = 1$$. 

$$\beta_{1}$$ is now the multiplier of $$ln(X)$$ so its no longer interpreted as the slope. So rather than adding 1 to $$X$$, let's multiply $$e$$ with $$X$$:

$$\begin{aligned}
\beta_{1}ln(ex) &= \beta_{1}(ln(e) + ln(x))\\[5 pt]
&= \beta_{1}ln(e) + \beta_{1}ln(x)\\[5pt]
&= \beta_{1} + \beta_{1}ln(x)
\end{aligned}$$

So rather than an additive relationship like we have with slope, we are now having a multiplicative relationship. Basically $$\beta_{1}$$ is the increase in $$Y$$ when you multiply by $$e$$. So a higher $$\beta_{1}$$ will result in a steeper increase/curvature in Y. Note one can choose any base they want and the interpretation will change to the particular base accordingly.

## <a name="inverse"></a>$$x^{-1}$$ Transformation

When you do a $$x^{-1}$$ transformation, your transformed model will look like:

$$\begin{aligned}
Y = \beta_{0} + \beta_{1}X^{-1} + \epsilon\\
\end{aligned}$$

And the conditional mean function:

$$E(Y \mid X = x) = \beta_{0} + \beta_{1}x^{-1}$$

Let's do a simulation and fit a linear model:

{% highlight r %}
x <- seq(0.1, 10, 0.1)
x_inv <- x^-1
y <- x_inv + rnorm(length(x), 0, 0.6)   
fit <- lm(y ~ x)
plot(x, y)
abline(fit, col = "red")
{% endhighlight %}

![](/assets/img/trans5.png)

Similarly, by transforming $$X$$, we get the following linear fit:

{% highlight r %}
x_inv <- x^-1
fit <- lm(y ~ x_inv)
plot(x_inv, y)
abline(fit, col = "red")   
{% endhighlight %}

![](/assets/img/trans6.png)

And fitting the model to the original untransformed X:

{% highlight r %}
plot(x, y)
points(x, fit$fitted.values, type = "l", col = "red")    
{% endhighlight %}

![](/assets/img/trans7.png)

And finally, if any of your data looks like the following, an inverse transformation might be appropriate:

![](/assets/img/trans12.png)

Note that similar to $$ln(x)$$ transformation, $$\displaystyle{\lim_{x \to 0}f(x) = \pm \infty}$$ but the difference is $$\displaystyle{\lim_{x \to \infty}f(x) = \beta_{0}}$$.

$$\beta_{0}$$ is now the intercept when $$x^{-1} = 0$$. This occurs when $$x = \infty$$. Hence $$\beta_{0}$$ is the limiting value when $$x$$ approaches infinity. As for $$\beta_{1}$$, it is now a multiplier to $$x^{-1}$$. There is no straightforward interpretation of $$\beta_{1}$$ as far as I know, however we can still visualize an increase of $$a$$ unit of $$x$$:

$$\begin{aligned}
\frac{\beta_{1}}{x + a} - \frac{\beta_{1}}{x} &= \frac{x\beta_{1} - (x + a)\beta_{1}}{x(x + 1)}\\[10pt]
&= \frac{x\beta_{1} - x\beta_{1} - a\beta_{1}}{x(x + 1)}\\[10pt]
&= \frac{-a\beta_{1}}{x(x + 1)}
\end{aligned}$$

Let $$a = x(x + 1)$$:

$$\begin{aligned}
\frac{-a\beta_{1}}{x(x + 1)} &= \frac{-x(x+1)\beta_{1}}{x(x + 1)}\\
&= -\beta_{1}
\end{aligned}$$

Therefore, an increase of $$x(x +1)$$ gives you a one $$\beta_{1}$$ unit of decrease in $$y$$.

Similarly we can look at it from a multiplicative perspective:

$$\begin{aligned}
\frac{\beta_{1}}{ax} - \frac{\beta_{1}}{x} &= \frac{\beta_{1}(1 - a)}{ax}\\[10pt]
&= \frac{\beta_{1}(1 - a)}{ax}
\end{aligned}$$

Let $$a = \frac{1}{x + 1}$$:

$$\begin{aligned}
\frac{\beta_{1}(1 - a)}{ax} &= \frac{\beta_{1}(1 - \frac{1}{x + 1})}{\frac{x}{x + 1}}\\
&= \frac{(x + 1)\beta_{1}(\frac{(x + 1) - 1}{x + 1})}{x}\\
&= \frac{\beta_{1}(x + 1 - 1)}{x}\\
&= \frac{\beta_{1}x}{x}\\
&= \beta_{1}
\end{aligned}$$

Therefore, a multiple of $$\frac{1}{x + 1}$$ gives you one unit increase of $$\beta_{1}$$ in $$y$$. Note this is an increase because multiplying by $$\frac{1}{x + 1}$$ results in a smaller number.

## <a name="jensen"></a>Jensen's Inequality

Before we move on to transformation on the $$Y$$ variable, let's take a diversion to explain Jensen's inequality as we will use it later.

In a nutshell Jensen's inequality states that if we take a secant line consisting of weighted means of the convex function, the secant line lies on top of the convex function. 

To draw a secant line, we can use the parametric equation of a line. Basically it's a weighted average of 2 $$f(x_{1}), f(x_{2})$$ points as you move along the 2 $$x_{1}, x_{2}$$ points:

$$\begin{aligned}
tf(x_{1}) + (1 - t)f(x_{2})\\[6pt]
tx_{1} + (1 - t)x_{2}\\[6pt]
t\: \in\: [0, 1]
\end{aligned}$$

And Jensen's inequality states that any point between $$x_{1}, x_{2}$$ on the convex function $$f(tx_{1} + (1 - t)x_{2})$$ will be below the secant line:

$$\begin{aligned}
f(tx_{1} + (1 - t)x_{2}) \leq tf(x_{1}) + (1 - t)f(x_{2})
\end{aligned}$$

A convex function is a function f which slope is increasing or stays the same:

$$f''(x) \geq 0$$

Thus for any $$c, x$$:

$$\begin{aligned}
f(x) \geq f(c) + f'(c)(x-c)
\end{aligned}$$

Which essentially mean any point in $$f(x)$$ is greater than the first-order taylor approximation (tangent) at point $$c$$. Taking $$f(x) = x_{2}$$ as an example:

{% highlight r %}
x <- seq(-1, 1, 0.1)
y <- x^2
plot(x, y, type = "l", ylim = c(-0.2, 1))
secant <- function(x1, x2, fn) {
  t <- seq(1, 0, -0.05)
  y <- t * fn(x1) + (1 - t) * fn(x2)
  x <- seq(x1, x2, length = length(t))
  points(x, y, type = "l", col = "red")
}
fn <- function(x) {
  x * x
}
fn_prime <- function(x) {
    2 * x
}
secant(-0.5, 1, fn)
c <- 0.5
points(x, fn(c) + fn_prime(c) * (x - c), type = "l", col = "blue")     
legend(
  "bottomright",
  c("secant", "tangent"),
  col = c("red", "blue"),
  cex = 0.8,
  lty = 1
)
{% endhighlight %}

![](/assets/img/trans8.png)

We can see the points of $$x^{2}$$ is below the secant line between $$-0.5 < x < 1.0$$ and $$\forall x; x^{2}$$ is above the tangent line at $$c = 0.5$$.

Finally if we are dealing with random variable $$X$$, we can subsitute $$c = \mathbb{E}[X]$$ and get:

$$\begin{aligned}
f(x) &\geq f(c) + f'(c)(x-c)\\
\mathbb{E}[f(X)] &\geq f(\mathbb{E}[X]) + f'(\mathbb{E}[X])(x-\mathbb{E}[X])\\
\mathbb{E}[f(X)] &\geq f(\mathbb{E}[X]) + f'(\mathbb{E}[X])(0)\\
\mathbb{E}[f(X)] &\geq f(\mathbb{E}[X])
\end{aligned}$$

Thus, we finally arrived at Jensen's inequality from a probabilistic perspective:

$$f(\mathbb{E}[X]) \leq \mathbb{E}[f(X)]$$

## <a name="lny"></a>$$ln(y)$$ Transformation

One can also transform the $$Y$$ variable like so:

$$\begin{aligned}
f(Y) &= \beta_{0} + \beta_{1}X + \epsilon\\
Y &= f^{-1}(\beta_{0} + \beta_{1}X + \epsilon)
\end{aligned}$$

Substituting $$f(Y) = ln(Y)$$ and $$f^{-1}(Y) = Y$$:

$$\begin{aligned}
ln(Y) &= \beta_{0} + \beta_{1}X + \epsilon\\
Y &= e^{\beta_{0} + \beta_{1}X + \epsilon}\\
Y &= e^{\beta_{0}}e^{\beta_{1}X}e^{\epsilon}
\end{aligned}$$

Notice that the error term is now transformed and no longer additive but multiplicative. Furthermore, the conditional mean function is no longer $$exp(\beta_{0} + \beta_{1}X)$$:

$$\begin{aligned}
E(Y \mid X = x) &= e^{\beta_{0}}e^{\beta_{1}X}E[e^{\epsilon \mid X = x}]\\
&= e^{\beta_{0}}e^{\beta_{1}X}E[e^{\epsilon}]\\
&\neq e^{\beta_{0}}e^{\beta_{1}X}
\end{aligned}$$

Since $$e^{x}$$ is a convex function and according to Jensen's inequality:

$$\begin{aligned}
E[e^{\epsilon}] &\geq e^{E[\epsilon]} = 1\\
E[e^{\epsilon}] &\geq 1\\
E(Y | X = x) &\geq e^{\beta_{0}}e^{\beta_{1}X}
\end{aligned}$$

However, rather than taking the average ($$E[X]$$), we take the median:

$$\begin{aligned}
Median(e^{\epsilon}) &= e^{0}\\
&= 1
\end{aligned}$$

Therefore implying that $$E(Y \mid X = x)$$ is the conditional median function.

So let's simulate and fit a linear model:

{% highlight r %}
x <- seq(0.1, 3, 0.1)
y <- exp(x + rnorm(length(x), 0, 0.6))    
fit <- lm(y ~ x)
plot(x, y)
abline(fit, col = "red")
{% endhighlight %}

![](/assets/img/trans9.png)

Now let's fit a linear model to the transformed model:

{% highlight r %}
fit <- lm(log(y) ~ x)
plot(x, log(y))
abline(fit, col = "red")   
{% endhighlight %}

![](/assets/img/trans10.png)

And untransformed it back:

{% highlight r %}
plot(x, y)
points(x, exp(fit$fitted.values), type = "l", col = "red")    
{% endhighlight %}

![](/assets/img/trans11.png)

Do note that in the above example, the top-right outlier didn't affect the fitted curve much because it's no longer the mean conditional but the median conditional function.

And finally, if any of your data looks like the following, a $$ln$$ transformation on the $$y$$ might be appropriate:

![](/assets/img/trans13.png)

$$\beta_{1}$$ is now the exponent of $$e$$:

$$\begin{aligned}
e^{\beta_{1}(x + 1)} &= e^{\beta_{1}x}e^{\beta_{1}} 
\end{aligned}$$

So instead of an additive relationship as in the classical regression, or the multiplicative relationship in the $$ln(X)$$ transformation, we are seeing a multiplicative exponent relationship $$e^{\beta_{1}}$$ in the $$ln(Y)$$ transformation.

But how about $$E(Y \mid X = x)$$? We know $$E(Y \mid X = x) \geq e^{\beta_{0} + \beta_{1}X}$$ but what does it exactly equal to?

The distribution turns out to be the log-normal distribution:

$$\begin{aligned}
ln(Y) \mid X &= x \sim N(\mu(x), \sigma^{2})\\[6pt]
Y \mid X &= x \sim e^{N(\mu(x), \sigma^{2})}\\[6pt]
p(y \mid x) &= \frac{1}{\sqrt{2\pi}y\sigma_{y \mid x}} e^{\frac{-(ln(y) - f(x))^{2}}{2\sigma_{y|x}^{2}}}\\[6pt]
\end{aligned}$$

{% highlight r %}
x <- seq(0, 3, 0.01)
plot(x, dlnorm(x, meanlog = 0, sdlog = 0.25), col = "red", type = "l", ylab = "PDF")      
points(x, dlnorm(x, meanlog = 0, sdlog = 0.50), col = "blue", type = "l")
points(x, dlnorm(x, meanlog = 0, sdlog = 1.00), col = "green", type = "l")
legend("topright",
    c("sigma = 0.25, mean = 0", "sigma = 0.5, mean = 0", "sigma = 1, mean = 0"),
    col = c("red", "blue", "green"),
    cex = 0.8,
    lty = 1
)
{% endhighlight %}

![](/assets/img/trans14.png)

Note that the distribution is bounded by 0 on the left.

The following is the mean and variance of a log-normal distribution:

$$\begin{aligned}
E(Y \mid X = x) &= e^{\beta_{0} + \beta_{1}x + \frac{\sigma^2}{2}}\\
Var(Y \mid X = x) &= (e^{\sigma^{2}} - 1)e^{2\beta_{0} + 2\beta_{1}x + \sigma^{2}}
\end{aligned}$$

As we can see from the variance of a log-normal distribution, the variable $$2\beta_{1}x$$ is included in the variance. This would imply heteroskedasticity as the variance would increase as $$x$$ increases. This is one way one can handle heteroskedasticity by log transforming $$Y$$.

## <a name="inversey"></a>$$\frac{1}{Y}$$ Transformation

This is usually done with ratio data, $$\frac{a}{b}$$, that make more sense when transformed to $$\frac{b}{a}$$.

$$\begin{aligned}
\frac{1}{Y} = \beta_{0} + \beta_{1}X + \epsilon\\
Y = \frac{1}{\beta_{0} + \beta_{1}X + \epsilon}
\end{aligned}$$

Let's simulate how an inverse $$Y$$ relationship looks like and fitting a linear model:

{% highlight r %}
x <- seq(1, 4, 0.1)
y <- 1 / (x + rnorm(length(x), 0, 0.5))   
fit <- lm(y ~ x)
plot(x, y)
abline(fit, col = "red")
{% endhighlight %}

![](/assets/img/trans15.png)

Similarly by transforming Y and fitting a linear model:

{% highlight r %}
fit <- lm(1 / y ~ x)
plot(x, 1 / y)
abline(fit, col = "red")

plot(x, y)
points(x, 1/fit$fitted.values, type = "l", col = "red")     
{% endhighlight %}

![](/assets/img/trans16.png)

![](/assets/img/trans17.png)

And finally, if any of your data looks like the following, an inverse transformation on $$y$$ might be appropriate:

![](/assets/img/trans18.png)

## <a name="box"></a>Box-Cox Transformation

Box-Cox transformation a family of power transformation on the $$Y$$ variable:

$$\begin{aligned}
Y^{\lambda} &= \beta_{0} + \beta_{1}X + \epsilon, \: \lambda \neq 0\\
ln(Y) &= \beta_{0} + \beta_{1}X + \epsilon, \: \lambda = 0\\
\end{aligned}$$

Notable cases are the $$\frac{1}{Y}$$ transformation when $$\lambda = -1$$, and the square root transformation when $$\lambda = 0.5$$.

In R, you can use the `boxcox(fit)` function to see which \lambda have the highest log-likelihoods:

{% highlight r %}
fit <- lm(y ~ x)
MASS::boxcox(fit)   
{% endhighlight %}

![](/assets/img/trans19.png)


## <a name="elasticity"></a>Elasticity

Sometimes you might want to transform both $$X$$ and $$Y$$ if they have a linear relationship to begin with and transforming both helps in terms of reducing violations to the assumptions. Another reason is the concept of elasticity, where you compare the % change in the $$Y$$ and $$X$$ variables:

$$\begin{aligned}
ln(Y) &= \beta_{0} + \beta_{1}ln(X) + \epsilon\\
Y &= e^{\beta_{0} + \beta_{1}ln(X) + \epsilon}\\
&= e^{\beta_{0}}e^{\beta_{1}ln(X)}e^{\epsilon}\\
&= e^{\beta_{0}}e^{ln(X)^{\beta_{1}}}e^{\epsilon}\\
&= e^{\beta_{0}}X^{\beta_{1}}e^{\epsilon}
\end{aligned}$$

Let's simulate and see how it looks like where we need to log transform both $$X$$ and $$Y$$:

{% highlight r %}
x <- seq(0, 3, 0.1)
y <- exp(log(x) + rnorm(length(x), 0, 0.6))    
fit <- lm(y ~ x)
plot(x, y)
abline(fit, col = "red")
{% endhighlight %}

![](/assets/img/trans20.png)

And transforming both $$X$$ and $$Y$$:

{% highlight r %}
fit <- lm(log(y) ~ log(x))   
plot(log(x), log(y))
abline(fit, col = "red")
{% endhighlight %}

![](/assets/img/trans21.png)

And finally untransforming:

{% highlight r %}
plot(x, y)
points(x, fit$fitted.values, type = "l", col = "red")    
{% endhighlight %}

![](/assets/img/trans22.png)

Note that $$\beta_{1}$$ is very close to one as we are transforming both sides and the untransformed fit looks pretty linear. Furthermore $$\beta_{1} > 1.0$$ implies that the model is convex and increases will accelerate while if $$0 < \beta_{1} < 1$$, increases will decelerate.

And also we shown earlier that:

$$Median(e^{\epsilon}) = e^{0} = 1$$

Thus,

$$Median(Y | X = x) = e^{\beta_{0}}X^{\beta_{1}}$$

In this model, $$\beta_{1}$$ is known as the elasticity and it measures the % increase in the median of $$Y$$ given a % increase in $$X$$:

$$Elasticity = \beta_{1} = \frac{\% \Delta median\: Y}{\%\ \Delta X}$$

But why is this so? We can use calculus to show this is true:

$$\begin{aligned}
ln(Y) &= \beta_{0} + \beta_{1}ln(X) + \epsilon\\[6pt]
\frac{d(ln(Y))}{dX} &= \frac{d(\beta_{0} + \beta_{1}ln(X) + \epsilon)}{dX}\\[6pt]
\frac{1}{Y}\frac{dY}{dX} &= \frac{\beta_{1}}{X}\\[6pt]
\beta_{1} &= \frac{dY}{dX}\frac{X}{Y}\\[6pt]
&= \frac{dY}{Y}\frac{X}{dX}\\[6pt]
&= \frac{\frac{dY}{Y}}{\frac{dX}{X}}\\[6pt]
&= \frac{\% \Delta median\: Y}{\%\ \Delta X}
\end{aligned}$$

## <a name="likelihood"></a>Likelihood

So how do we know which transformation to use if any? One way we can compare models is to use the likelihood function for each model and compare them. The likelihood function:

$$\begin{aligned}
L(\theta \mid X = x) = p_{\theta}(X = x)
\end{aligned}$$

It is a function that takes in the parameter $$\theta$$ and outputs the probability of seeing the data $$X = x$$. Note that the likelihood function is not a probability density function (pdf), which means it would not integrate to 1 across all parameters. Remember if you integrate across all $$X=x$$, you will get 1:

$$\begin{aligned}
\int_{\Theta} L(\theta) d\theta \neq 1\\
\int_{-\infty}^{\infty} p(x) dx = 1
\end{aligned}$$

To compute the likelihood function, and assuming conditional independence in the observable data $$X$$:

$$\begin{aligned}
L(\theta \mid X) = p(y_{1} \mid X = x_1, \theta) \times p(y_{2} \mid X = x_2, \theta) \times ... \times p(y_{n} \mid X = x_n, \theta)
\end{aligned}$$

Using the classical regression Gaussian distribution for $$p(y)$$:

$$\begin{aligned}
p(y \mid X = x, \theta) &= p(y | X = x, \beta_{0}, \beta_{1}, \sigma)\\
&= \frac{1}{\sqrt{2\pi}\sigma}e^{-\frac{(y - (\beta_{0} + \beta_{1}x))^2}{2\sigma^{2}}}
\end{aligned}$$

We derive the likelihood function:

$$\begin{aligned}
L(\theta \mid X) &= p(y_{1} \mid X = x_1, \theta) \times p(y_{2} \mid X = x_2, \theta) \times ... \times p(y_{n} \mid X = x_n, \theta)\\
&= \frac{1}{\sqrt{2\pi}\sigma}e^{-\frac{(y_{1} - (\beta_{0} + \beta_{1}x_{1}))^2}{2\sigma^{2}}} \times \frac{1}{\sqrt{2\pi}\sigma}e^{-\frac{(y_{2} - (\beta_{0} + \beta_{1}x_{2}))^2}{2\sigma^{2}}} \times ... \times \frac{1}{\sqrt{2\pi}\sigma}e^{-\frac{(y_{n} - (\beta_{0} + \beta_{1}x_{n}))^2}{2\sigma^{2}}}\\
&= \frac{1}{(2\pi\sigma^2)^{\frac{n}{2}}}e^{-\frac{\sum_{i = 1}^{n}(y_{i} - (\beta_{0} + \beta_{1}x_{i}))^2}{2\sigma^2}}
\end{aligned}$$

Note that for random $$X$$ data:

$$X \sim p(x)$$

we would need to multiply $$... \times p(x_{1}) \times ... \times p(x_{n})$$ as well.

The next step would be to find the $$\theta$$ that would maximize the function. Because we are multiplying probabilities, we might run into very small numbers and might face underflow issues and also it is hard to differentiate the equation. So rather than maximizing the likelihood, it is easier to maximize the log-likelihood instead. There is no difference between the two as the $$ln$$ function is a monotonically increasing function and the maximum point will remain the same after the log transformation.

$$\begin{aligned}
LL(\theta \mid X) &= ln(L(\theta \mid X))\\
&= -\frac{n}{2}ln(2\pi\sigma^2) - \frac{1}{2\sigma^2}\sum_{i = 1}^{n}(y_{i} - (\beta_{0} + \beta_{1}x_{i}))^2\\
\end{aligned}$$

Maximizing the log-likelihood is equivalent to minimizing the sum of squares. By taking the derivative of $$LL$$ and setting them to 0:

$$\begin{aligned}
\frac{\partial\: LL(\theta \mid X)}{\partial \beta_{0}} &= \sum_{i = 1}^{n}-2(y_{i} - \beta_{0} - \beta_{1}x_{i}) = 0\\
\frac{\partial\: LL(\theta \mid X)}{\partial \beta_{1}} &= \sum_{i = 1}^{n}-2x_{i}(y_{i} - \beta_{0} - \beta_{1}x_{i}) = 0
\end{aligned}$$

And solving both equations we get the following familiar formulas:

$$\begin{aligned}
\beta_{0} &= \bar{y} - \beta_{1}\bar{x}\\
\beta_{1} &= \frac{\sum_{i = 1}^{n}(x_{i} - \bar{x})(y_{i} - \bar{y})}{\sum_{i = 1}^{n}(x_{i} - \bar{x})^2}\\
&= \frac{\sigma_{xy}}{\sigma_{x}}
\end{aligned}$$

We can do MLE (Maximum Likelihood Estimation) on other probability distributions as well and we will give more examples as we go in future posts. In R, we can easily compute the log-likelihood by invoking `logLik()` after doing a fit with `lm()_`:

{% highlight r %}
fit <- lm(...)  
logLik(fit)
{% endhighlight %}

Note that when comparing models, do not just pick the one with the maximum likelihood blindly as the probability is based on the observable data $$X$$ and might not be representative of the true model. KISS and invoke the subject domain expertise.
