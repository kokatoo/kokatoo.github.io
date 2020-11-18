---
layout: post
title: "Polynomial Regression"
date: 2020-11-15 01:30:06 +0800
img : poly1.png
tags: [statistics, regression, interaction]
---

Up to now we have discussed only linear models (straight lines for 1D and planes for 2Ds), but things are hardly so simple. If we require some flexibility and complexity, we can delve into polynomial models. Polynomial models are multiple regression models that is polynomial but linear to the unknown parameters. We will also be looking at interaction terms from a regression perspective.

<div class="toc" markdown="1">
# Contents:
- [Quadratic Model](#quad)
- [Interaction Analysis](#interaction)
- [Variable Inclusion Principle](#vip)
</div>

## <a name="quadratic"></a>Quadratic Model

Quadratic model in 1 variable and 2 variables is in the form of:

$$\begin{aligned}
f(x) &= \beta_{0} + \beta_{1}x_{1} + \beta_{2}x_{1}^{2}\\
f(x_{1}, x_{2}) &= \beta_{0} + \beta_{1}x_{1} + \beta_{2}x_{1}^{2} + \beta_{3}x_{2} + \beta_{4}x_{2}^{2} + \beta_{5}x_{1}x_{2}\\
\end{aligned}$$

When the quadratic terms $$\beta_{2}, \beta_{4} > 0$$ there is convex curvature and concave convature when $$\beta_{2}, \beta_{4} < 0$$. Let's plot the following 3 quadratic fits and see the difference:

$$\begin{aligned}
f(x_{1}, x_{2}) &= \beta_{1}x_{1} + \beta_{2}x_{1}^{2} + \beta_{3}x_{2} + \beta_{4}x_{2}^{2}\\
f(x_{1}, x_{2}) &= \beta_{1}x_{1} + \beta_{2}x_{1}^{2} - \beta_{3}x_{2} - \beta_{4}x_{2}^{2}\\
f(x_{1}, x_{2}) &= \beta_{1}x_{1} - \beta_{2}x_{1}^{2} - \beta_{3}x_{2} - \beta_{4}x_{2}^{2}\\
\end{aligned}$$

{% highlight r %}
x1 <- seq(-3, 3, length = 100)
x2 <- seq(-3, 3, length = 100)

f <- function(x1, x2) {
  x1 + x1^2 + x2 + x2^2
}

rgl::plot3d(
    f,
    xlim = c(-3, 3),
    ylim = c(-3, 3),
    zlim = c(-20, 20),
    xlab = "x1",
    ylab = "x2",
    zlab = "z",
    alpha = 0.5
)

f <- function(x1, x2) {
    x1 + x1^2 - x2 - x2^2
}
rgl::surface3d(x1, x2, outer(x1, x2, f), col = "red", alpha = 0.6)

f <- function(x1, x2) {
    -x1 - x1^2 - x2 - x2^2
}
rgl::surface3d(x1, x2, outer(x1, x2, f), col = "blue", alpha = 0.6)      
{% endhighlight %}

![](/assets/img/poly1.png)

The black curve is where both $$x_{1} > 0,\: x_{2} > 0$$, red curve is where $$x_{1} > 0,\: x_{2} < 0$$, and the blue curve is where both $$x_{1} < 0,\: x_{2} < 0$$. When both are positive, we get a convex bowl shape and when both are negative, we get a concave bowl shape, and when one is positive and the other is negative, we get a saddle shape.

But how about changing the sign of the linear term and not the quadratic term? Changing the linear term will not affect the convex or concave curvature but change the slope by a constant value and the location of the min/max:

$$\begin{aligned}
\frac{\partial f(x_{1}, x_{2})}{\partial dx_{1}} &= -\beta_{1} + 2\beta_{2}x_{1} = 0\\
\frac{\partial f(x_{1}, x_{2})}{\partial dx_{2}} &= -\beta_{3} + 2\beta_{4}x_{2} = 0\\
\end{aligned}$$

So how would you interprete the coefficients? One can no longer increase one variable while holding the others fixed. For $$\beta_{2},\: \beta_{4}$$ they idicate the curvature and whether it is convex or concave. The linear betas $$\beta_{1},\: \beta_{3}$$ by themselves do not have not much meaning and one would not test its significance but it is still important to include it via the variable-inclusion principle and also important when locating the min/max point and the general shape of the function.

## <a name="interaction"></a>Interaction Analysis

The general form of a 2 variable interaction is a quadratic model with no quadratic term:

$$\begin{aligned}
f(x_{1}, x_{2}) &= \beta_{0} + \beta_{1}x_{1} + \beta_{2}x_{2} + \beta_{3}x_{1}x_{2}\\
\end{aligned}$$

Note that this is still considered a quadratic because if there is a significant interaction, you will get a curved function rather than a plane. Let's simulate an example to illustrate.

{% highlight r %}
x1 <- seq(-3, 3, length = 100)  
x2 <- seq(-3, 3, length = 100)

f <- function(x1, x2) {
  x1 + x2 + x1 * x2
}

rgl::plot3d(
    f,
    xlim = c(-3, 3),
    ylim = c(-3, 3),
    zlim = c(-20, 20),
    xlab = "x1",
    ylab = "x2",
    zlab = "z",
    alpha = 0.5
)
{% endhighlight %}

![](/assets/img/poly2.png)

You can see the slope $$\beta_{1}$$ of $$x_{1}$$ changes as $$x_{2}$$ increases. This means that the value of $$x_{1}$$ is dependent on the value of $$x_{2}$$. 

$$\begin{aligned}
E(Y \mid X_{1} = x_{1}, X_{2} = 1) &= x_{1} + 1 + x_{1} = 1 + 2x_{1}\\
E(Y \mid X_{1} = x_{1}, X_{2} = 3) &= x_{1} + 3 + 3x_{1} = 3 + 4x_{1}\\
\end{aligned}$$

For interaction model, you cannot increase one variable while holding all terms fixed. However, you can change $$X_{1}$$ while holding $$X_{2}$$ fixed:

$$\begin{aligned}
E(Y \mid X_{1} = x_{1}, X_{2} = x_{2}) &= \beta_{0} + \beta_{1}x_{1} + \beta_{2}x_{2} + \beta_{3}x_{1}x_{2}\\
E(Y \mid X_{1} = x_{1} + 1, X_{2} = x_{2}) &= \beta_{0} + \beta_{1}(x_{1} + 1) + \beta_{2}x_{2} + \beta_{3}x_{1}(x + 1)x_{2}\\
&= \beta_{0} + \beta_{1}x_{1} + \beta_{2}x_{2} + \beta_{3}x_{1}x_{2} + \beta_{1} + \beta_{3}x_{2}\\
&= E(Y \mid X_{1} = x_{1}, X_{2} = x_{2}) + \beta_{1} + \beta_{3}x_{2}\\
\end{aligned}$$

As you can see from the above equations, $$\beta{1}$$ does not indicate the changes to $$E(Y)$$ when you increase $$X_{1}$$ by one unit unless $$X_{2} = 0$$. However this does not mean anything if $$X_{2} = 0$$ is not in the range of $$X_{2}$$. In this case $$X_{2}$$ is the moderating variable and you can set a low and high value of $$X_{2}$$ to calculate the resulting estimating mean function. You can pick the 10th and 90th percentile as the low and high values.

When testing for significance of the betas, the only thing that matters is the interaction $$\beta_{3}$$. But even if the other betas are not significant, we should still include them as part of the variable inclusion principle as we shall discuss next.

## <a name="vip"></a>Variable Inclusion Principle

The principle basically state that for higher-order polynomial models, always include the lower-order terms. The reason for this is because if you don't include them, then the coefficient of the higher-order terms do not measure what you think you want it to measure.

For example, if you would to exclude the intercept term, then you would be forcing the intercept to be 0 which might not be what you want. For quadratic model, excluding the linear term might change the direction of the curvature of $$x^{2}$$ because the quadratic term is now replacing the linear term when doing the fit:

{% highlight r %}
set.seed(123)
x <- rnorm(100, 2, 0.5)
y <- 5 * x - 0.1 * x^2 + rnorm(100, 0, 1)

fit_inclusion <- lm(y ~ x + I(x^2))
fit_exclusion <- lm(y ~ I(x^2))

f_inclusion <- function(x) {
    fit_inclusion$coefficients["(Intercept)"] +
      x * fit_inclusion$coefficients["x"] +
      x^2 * fit_inclusion$coefficients["I(x^2)"]
}
f_exclusion <- function(x) {
    fit_exclusion$coefficients["(Intercept)"] +
      x^2 * fit_exclusion$coefficients["I(x^2)"]    
}

plot(x, y)
x_seq <- seq(-1, 5, 0.1)
lines(x_seq, f_inclusion(x_seq), col = "red")
lines(x_seq, f_exclusion(x_seq), col = "blue")
{% endhighlight %}

If you were to look into the fit with the linear term:

{% highlight r %}
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  -1.3318     1.4706  -0.906    0.367    
x             6.3643     1.4462   4.401 2.77e-05 ***
I(x^2)       -0.4568     0.3474  -1.315    0.192        
{% endhighlight %}

You can see that the quadratic term is insignificant. If you were to remove the linear term and fit it again:

{% highlight r %}
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  5.04913    0.26728   18.89   <2e-16 ***
I(x^2)       1.05499    0.05593   18.86   <2e-16 ***    
{% endhighlight %}

Now the quadratic term is significant and you might think this is what you want. Let's plot the graph:

![](/assets/img/poly3.png)

The red curve includes the $$x$$ linear term and we can see that it is a concave curve. However, if you remove the linear term, $$x^{2}$$ would have to stand in for the missing linear term and it is now a convex curve.

Finally for interaction model, excluding the linear terms would mean no interaction at all as it is clear from the equation that is no variation in the slope for any values in the moderating variable:

$$\begin{aligned}
f(x_{1}, x_{2}) &= \beta_{0} + \beta_{1}x_{1}x_{2}\\
\end{aligned}$$
