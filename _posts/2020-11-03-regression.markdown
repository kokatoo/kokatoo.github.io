---
layout: post
title: "Regression"
date: 2020-11-03 01:30:06 +0800
img : regression4.png
tags: options
---

Regression models are used to relate a response/dependent variable $$Y$$ to one or more predictor/independent variables $$X$$. One reason why we might want to do this is to predict what will (forecast) or might happen under different scenarios (what-if). This will hopefully better help us understand the relationship we are modeling.

<div class="toc" markdown="1">
# Contents:
- [Probabilistic Model](#prob)
- [Experimental vs Observational Data](#data)
- [Conditional Mean Function](#conditional)
- [Classical Regression Assumptions](#classical)
- [Simulation](#simulation)
- [Bivariate Normal Distribution](#bivariate)
- [Regression to the Mean](#mean)
</div>

## <a name="prob"></a>Probabilistic Model

Regression model is an example of a probabilistic model in the sense that it is not deterministic. We will denote the model as:

$$(Y \mid X=x) \sim p(y \mid x)$$

It is more helpful if we think of $$p(y \mid x)$$ as a process that generate data based on the probablity distribution. In this way we are not constrained by the particular distribution (it doesn't have to be normal) and it doesn't even need to depend on $$X$$. We will say that $$Y$$ is independent of $$X$$ if $$p(y \mid x) = p(y)$$. Note that the conditional probability above states that there is a different distribution for each value of $$x$$ that produces a $$y$$ observation.

Thinking of it as a probablistic model also help you differentiate between interpolation and extrapolation. Interpolation means coming from the same data generating process $$p(y \mid x)$$ while extrapolation means using $$p(y \mid x)$$ to generalize to a similar but different data generating process $$p_{new}(y \mid x)$$. How similar are the two process is subjective and require domain knowledge of the subject matter.

Frequently when we model our model probablistically, we are more interested in the infinite number of potentially observable $$Y$$ values rather than from the underlying finite population. For example, there might be many values in $$X$$ that have 0 or few instances in the finite population. Nonetheless, we will most likely be interested to predict them even if they are non-existent in the population.

## <a name="data"></a>Experimental vs Observational Data

Experimental data are $$X$$ values that are fixed in advance of the data collection and are controlled by the experimenter. While observational data are $$X$$ values that are random and not controlled by the researcher. With experimental data, causal effect are more likely to be ascertained while causality cannot be determined from observational data. Furthermore, random $$X$$ values has a distribution of its own:

$$X \sim p(x)$$

## <a name="conditional"></a>Conditional Mean Function

When we normally think of regression, we are actually referring to the conditional mean function:

$$f(x) = E(Y \mid X = x)$$

And if $$X$$ is discrete:

$$f(x) = \sum y\: p(y \mid x)$$

And if $$X$$ is continuous:

$$f(x) = \int y\: p(y \mid x) dx$$

For linear regression, $$f(x) = \beta_{0} + \beta_{1}x$$.

We will visit more kinds of functions in future posts.

In classical regression, the model is linear in the coefficients ($$\beta$$ parameters). However in nonlinear regression like logistic and neural networks, are not linear w.r.t to the coefficients. We will also show in future posts that exponential functions are not linear to the coefficients but multiplicative instead.

## <a name="assumptions"></a>Classical Regression Assumptions


### Homoscedasticity

In classical regression, one of the assumption of the data is constant variance aka homoscedasticity. This means that the variance $$\sigma$$ is constant across all $$X = x$$:

$$\begin{aligned}
\sigma_{y \mid x}^{2} &= Var(Y \mid X = x)\\
&= \int (y - E[Y \mid X = x]^{2})\: p(y \mid x)\: dy\\
&= constant
\end{aligned}$$

### Conditional Independence

Basically it assumes the errors are independent:

$$\begin{aligned}
\epsilon_{i} \perp \!\!\! \perp \epsilon_{j}\\
\end{aligned}$$

$$\begin{aligned}
\epsilon_{i} &= y_{i} - f(x_{i})\\
\epsilon_{j} &= y_{j} - f(x_{j})
\end{aligned}$$

This also implies that the $$Y$$ are independent given $$X = x$$:

$$p(y \mid x_{i}) \perp \!\!\! \perp p(y \mid x_{j})$$

### Normality

Given $$X = x$$:

$$p(y \mid x) = \frac{1}{\sqrt{2\pi}\sigma_{y \mid x}} e^{\frac{-(y - f(x))^{2}}{2\sigma_{y|x}^{2}}}$$

Note that $$\sigma_{y \mid x}$$ doesn't have to be constant in normality assumption and neither $$f(x)$$ needs to be linear, but the errors are uncorrelated.

## <a name="simulation"></a>Simulation

One way to check whether your model reflects your data is to simulate data from your model and cross check with the real data and see whether it's reasonably similar. For example if the homoscedasticity assumption is violated, the data generated from your model will show constant variance and will be different from the real data you got.

Let's generate some data using the following relationship:

$$\begin{aligned}
ln(Y) &= \beta_{0} + \beta_{1}X + \epsilon\\[5pt]
\epsilon &\sim N(0, 0.2)
\end{aligned}$$

Using the following R code:

{% highlight r %}
x <- seq(-1, 20, 0.1)
y <- exp(0.1 + 0.1 * x + rnorm(length(x), 0, 0.2))    
{% endhighlight %}

Let's plot and fit using OLS regression and using the actual exponential function:

{% highlight r %}
plot(x, y)
fit  <- lm(y ~ x)
abline(fit)

fit_actual <- lm(log(y) ~ x)
points(x, exp(fit_actual$fitted.values), type = "l", col = "red")    
{% endhighlight %}

![](/assets/img/regression1.png)

We know the underlying relationship is not linear and there is heteroskedasticity but the linear fit seem to be doing quite well so it is hard to tell whether the fit is good. Let's generate the data from the linear fit and the exponential fit and plot them:

{% highlight r %}
plot(
    x,
    predict(fit) + rnorm(length(x), 0, summary(fit)$sigma^2),
    ylab = "y",
    main = "Data generated from linear fit"
)

plot(
    x,
    exp(predict(fit_actual) + rnorm(length(x), 0, summary(fit_actual)$sigma)),     
    ylab = "y",
    main = "Data generated from exponential fit"
)
{% endhighlight %}

![](/assets/img/regression2.png)

![](/assets/img/regression3.png)

We can see the exponential fit looks much closer to the real data.

## <a name="bivariate"></a>Bivariate Normal Distribution

In classical OLS regression, assuming all assumptions are fulfilled, essentially we are assuming a bivariate normal distribution between $$X$$ and $$Y$$:

$$\begin{aligned}
p(x, y) &= \frac{1}{vol} e^{kernel}\\[10pt]
kernel &= -\frac{1}{2}\frac{z_{x}^{2} + z_{y}^{2} - 2\rho z_{x}z_{y}}{1 - \rho^{2}}\\[5pt]
vol &= 2\pi\sigma_{x}\sigma_{y}\sqrt{1-\rho^{2}}\\[5pt]
z_{x} &= \frac{x - u_{x}}{\sigma_{x}}\\[5pt]
z_{y} &= \frac{y - u_{y}}{\sigma_{y}}
\end{aligned}$$

And in matrix notation:

$$\begin{aligned}
p(x, y) &= \frac{1}{2\pi \sqrt{|\mathbf{\Sigma}|}} e^{-\frac{1}{2}(\mathbf{x} - \mathbf{\mu})^{\mathbf{T}}\mathbf{\Sigma^{-1}}(\mathbf{x} - \mathbf{\mu})}
\end{aligned}$$

Francis Galton, a famous statistician who discovered regression, noticed that the children of very tall parents tend to be taller than average but shorter than their parents and children of very short parents tend to be short on average but taller than their parents. Let's show this phenomenon by a simulation. Assuming the following parameter:

{% highlight r %}
mux <- 180  
muy <- 180
sx <- 8
sy <- 8
r <- 0.4
{% endhighlight %}

Plotting the scatterplot and contours:

{% highlight r %}
x <- seq(150, 200, length = 50)
y <- x
pxy <- function(x, y) {
    zx <- (x - mux) / sx
    zy <- (y - muy) / sy
    volume <- 2 * pi * sx * sy * sqrt(1 - r^2)
    kernel <- exp(-.5 * (zx^2 + zy^2 - 2 * r * zx * zy) / (1 - r^2))     
    kernel / volume
}

cov_mat <-
  matrix(
    c(sx^2, r * sx * sy,
      r * sx * sy, sy^2),
    nrow = 2
)
density <- outer(x, y, pxy)
data <- MASS::mvrnorm(n = 10000, mu, cov_mat)
plot(data,
    pch = ".", xlab = "Parent's Height (cm)",
    ylab = "Child's Height (cm)"
)
contour(
  x = x,
  y = y,
  z = density,
  nlevels = 5,
  lwd = 1.6,
  add = TRUE,
  drawlabels = FALSE
)
{% endhighlight %}

![](/assets/img/regression4.png)

And in 3D:

{% highlight r %}
persp(
    x,
    y,
    density,
    theta = 10, phi = 20, r = 50, d = 0.5, expand = 0.5,
    ticktype = "detailed",
    xlab = "\nX=Parent's Height (cm)", ylab = "\nY=Child's Height (cm)",      
    zlab = "\n\np(x,y)", cex.axis = 0.7, cex.lab = 0.7
)
{% endhighlight %}

![](/assets/img/regression5.png)

## <a name="mean"></a>Regression to the Mean

We are going to use the earlier parent and child example to demonstrate regression to the mean. 

If the $$(X, Y)$$ comes from a bivariate normal distribution, we will have the following conditional distribution:

$$\begin{aligned}
p(y \mid X = x) &\sim N(\beta_{0} + \beta_{1}x, \sigma^{2})\\[5pt]
\beta_{1} &= \rho\frac{\sigma_{y}}{\sigma_{x}}\\
\beta_{0} &= \mu_{y} - \beta_{1}\mu_{x}\\
\sigma^{2} &= (1 - \rho^{2})\sigma_{y}^{2}
\end{aligned}$$

We will plot 2 regression lines. The solid line indicates a perfect correlation. Parent's height predicts child's height while the dashed line has a lower correlation of 0.4:

{% highlight r %}
x <- 160:200
y <- x
y_rho <- (muy - r * mux) + r * x
plot(x, y,
     type = "l",
     xlab = "Parent's Height",
     ylab = "Child's Height"
)
points(x, y_rho, type = "l", lty = 2)   
abline(h = 180, lty = 3)
arrows(200, 200, 200, 190.5)
arrows(160, 160.5, 160, 168)
{% endhighlight %}

![](/assets/img/regression6.png)

We can see the extreme ends regress to the mean of the child's height. This shouldn't be surprising as we do know that the bulk of the density of a normal distribution lies in the middle. How about if the child's mean height is lower than the parent's?

{% highlight r %}
muy <- 170
x <- 150:190
y <- x
y_rho <- (muy - r * mux) + r * x
plot(x, y,
     type = "l",
     xlab = "Parent's Height",
     ylab = "Child's Height"
)
points(x, y_rho, type = "l", lty = 2)    
abline(h = 170, lty = 3)
arrows(190, 190, 190, 180.5)
arrows(150, 150.5, 150, 158)
{% endhighlight %}

![](/assets/img/regression7.png)

We see a similar regression to the mean. And finally when the mean of child's height is greater than the parents:

{% highlight r %}
muy <- 190
x <- 170:210
y <- x
y_rho <- (muy - r * mux) + r * x
plot(x, y,
    type = "l",
    xlab = "Parent's Height",
    ylab = "Child's Height"
)
points(x, y_rho, type = "l", lty = 2)   
abline(h = 190, lty = 3)
arrows(210, 210, 210, 205)
arrows(170, 170.5, 170, 178)
{% endhighlight %}

![](/assets/img/regression8.png)

