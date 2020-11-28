---
layout: post
title: "Regression with Indicator Variables"
date: 2020-11-25 01:30:06 +0800
img : indicator9.png
tags: [statistics, regression, anova, ancova, piecewise, confounding]
---

What do you do if your data is nominal and not continuous? And how is regression related to ANOVA and can we do ANOVA using regression? We will get all the answers on today's post!

<div class="toc" markdown="1">
# Contents:
- [Indicator Variable](#indicator)
- [Multiple Indicator Variables (ANOVA)](#multiple)
- [Analysis of Covariance (ANCOVA)](#ancova)
- [ANCOVA with Interaction](#interaction)
- [Two-Way ANOVA](#two-way)
- [Piecewise Regression](#piecewise)
- [Confounding Variables + Repeated Measures](#repeated)
</div>

## <a name="indicator"></a>Indicator Variable

An indicator variable is a binary variable that takes 2 values, which is usually 0 and 1. Let's simulate 2 groups of data and fit a linear fit to it:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}I_{1} + \epsilon\\
\end{aligned}$$

{% highlight r %}
set.seed(123)
group1 <- rnorm(10, 3, 0.1)
group2 <- rnorm(10, 3.5, 0.5)

data <-
    data.frame(
        group = c(
            rep(0, length(group1)),
            rep(1, length(group2))
        ),
        data = c(group1, group2)
    )

plot(data$group, data$data, xlab = "Group", ylab = "Y")    
fit <- lm(data$data ~ data$group)
abline(fit)

{% endhighlight %}

![](/assets/img/indicator1.png)

Group 1 is given the x-label 0 and group 2 is given the x-label 1. Note that there are inherently no order in nominal variable, so we can always switch the labelling and the fit will be negatively sloped instead.

Let's look at the fit:

{% highlight r %}
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   3.0075     0.1180  25.486 1.41e-15 ***     
data$group    0.5968     0.1669   3.576  0.00216 ** 
{% endhighlight %}

How should we interpret the coefficients?

When $$X = 0$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}.(0) + \epsilon\\
&= \beta_{0} + \epsilon\\
\end{aligned}$$

When $$X = 1$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}.(1) + \epsilon\\
&= \beta_{0} + \beta_{1} + \epsilon
\end{aligned}$$

Hence, $$\beta_{0}$$ is the mean of group 1 and $$\beta_{0} + \beta_{1}$$ is the mean of group 2:

$$\begin{aligned}
E(Y \mid X = 0) &= \beta_{0}\\
E(Y \mid X = 1) &= \beta_{0} + \beta_{1}
\end{aligned}$$
 
While $$\beta_{1}$$ is the difference of the means:

$$\begin{aligned}
E(Y \mid X = 1) - E(Y \mid X = 0) &= \beta_{0} + \beta_{1} - \beta_{0}\\
&= \beta_{1}
\end{aligned}$$

We can verify this in R:

{% highlight r %}
mean(group1)
fit$coefficients["(Intercept)"]

> [1] 3.007463
> (Intercept) 
   3.007463 

mean(group2)
fit$coefficients["(Intercept)"] + fit$coefficients["data$group"]     

> [1] 3.604311
> (Intercept) 
   3.604311 
{% endhighlight %}

We can compare the two-sample t-test with the t-test computed from the regression:

{% highlight r %}
> t.test(group2, group1, var.equal = TRUE)

	Two Sample t-test

data:  group2 and group1
t = 3.5765, df = 18, p-value = 0.002157
alternative hypothesis: true difference in means is not equal to 0     
95 percent confidence interval:
 0.2462423 0.9474546
sample estimates:
mean of x mean of y 
 3.604311  3.007463 
{% endhighlight %}

As compared to `summary(fit)` and `confint(fit)`:

{% highlight r %}
> summary(fit)
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   3.0075     0.1180  25.486 1.41e-15 ***    
data$group    0.5968     0.1669   3.576  0.00216 ** 

> confint(fit)
                2.5 %    97.5 %
(Intercept) 2.7595466 3.2553785
data$group  0.2462423 0.9474546
{% endhighlight %}

Note that we specifically state that the variance is the same but we know that this is not true from the simulation. However in regression, we assume the same variance aka homoscedasticity.

We can compare the F-statistic as well:

{% highlight r %}
> summary(fit)
F-statistic: 12.79 on 1 and 18 DF,  p-value: 0.002157   

> summary(aov(data$data ~ data$group))
            Df Sum Sq Mean Sq F value  Pr(>F)   
data$group   1  1.781  1.7811   12.79 0.00216 **   
Residuals   18  2.506  0.1392                   
{% endhighlight %}

## <a name="anova"></a>Multiple Indicator Variables (ANOVA)

Things start to get a little tricky when we have more than 2 levels. We can use multiple indicator variables to represent nominal variable with more than 2 levels. Let's simulate 3 different groups in R:

{% highlight r %}
set.seed(123)
group1 <- rnorm(10, 3, 0.1)
group2 <- rnorm(10, 3.5, 0.5)  
group3 <- rnorm(10, 4, 0.3)
{% endhighlight %}

In order for R to interpret `data$group` as a categorical variable, we would need to set it as a factor using `factor()`.

{% highlight r %}
data <-
    data.frame(
        group = factor(c(
            rep(1, length(group1)),
            rep(2, length(group2)),
            rep(3, length(group3))
        )),
        data = c(group1, group2, group3)   
    )

fit <- lm(data$data ~ data$group)
{% endhighlight %}

Looking at the summary of the fit, we can see 2 indicator variables produced:

{% highlight r %}
> summary(fit)
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   3.0075     0.1090  27.590  < 2e-16 ***
data$group2   0.5968     0.1542   3.872 0.000621 ***
data$group3   0.8652     0.1542   5.612 5.91e-06 ***    
{% endhighlight %}

How should we interpret the coefficients?

$$\begin{aligned}
Y &= \beta_{1} + \beta_{2}I_{2} + \beta_{3}I_{3} + \epsilon\\
\end{aligned}$$

$$\beta_{1}$$ is the mean of group 1 while $$\beta_{1} + \beta_{2}$$ is the mean of group 2 and $$\beta_{1}+ \beta{3}$$ is the mean of group 3. Hence in this case, group 1 is the reference group.

We can also interpret $$\beta_{2}$$ as the difference of the mean between group 2 and the reference group 1. Similarly, $$\beta_{3}$$ is the difference between the mean of group 3 and group 1.

We can verify the results in R:

{% highlight r %}
mean(group1)
fit$coefficients["(Intercept)"]

> [1] 3.007463
> (Intercept) 
   3.007463 

mean(group2)
fit$coefficients["(Intercept)"] + fit$coefficients["data$group2"]

> [1] 3.604311
> (Intercept) 
   3.604311 

mean(group3)
fit$coefficients["(Intercept)"] + fit$coefficients["data$group3"]     

> [1] 3.872632
> (Intercept) 
   3.872632 
{% endhighlight %}

We can also see that the result match with `aov()` anova:

{% highlight r %}
> summary(fit)
Residual standard error: 0.3447 on 27 degrees of freedom
Multiple R-squared:  0.5501,	Adjusted R-squared:  0.5168     
F-statistic: 16.51 on 2 and 27 DF,  p-value: 2.076e-05

> aov(data$data ~ data$group)
Residual standard error: 0.3447089
Estimated effects may be unbalanced

> summary(aov(data$data ~ data$group))
            Df Sum Sq Mean Sq F value   Pr(>F)    
data$group   2  3.922  1.9612    16.5 2.08e-05 ***
Residuals   27  3.208  0.1188                     
{% endhighlight %}

The t-scores reported in `summary(fit)` for the base group (Intercept) $$\beta_{1}$$ is the comparison with the null model $$(\frac{3.0075 - 0}{0.1090} = 27.590)$$ while `data$group2` and `data$group3` are comparisons with the base group 1. We can verify the results with `pairwise.t.test`:

{% highlight r %}
> summary(fit)
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   3.0075     0.1090  27.590  < 2e-16 ***
data$group2   0.5968     0.1542   3.872 0.000621 ***
data$group3   0.8652     0.1542   5.612 5.91e-06 ***

> pairwise.t.test(data$data, data$group, p.adj = "none")     
  1       2      
2 0.00062 -      
3 5.9e-06 0.09315

P value adjustment method: none
{% endhighlight %}

`pairwise.t.test` tests more than just comparison with the base group 1 but all pairwise grouping. Pairwise t-tests would increase the likelihood of Type I error as we are doing $$\frac{n(n - 1)}{2}$$ tests and we should adjust the t-scores by using the `TukeyHSD()` function:

{% highlight r %}
> TukeyHSD(aov(data$data ~ data$group))
TukeyHSD(aov(data$data ~ data$group))
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = data$data ~ data$group)

$`data$group`
         diff        lwr       upr     p adj
2-1 0.5968484  0.2146251 0.9790717 0.0017418
3-1 0.8651698  0.4829465 1.2473931 0.0000172
3-2 0.2683214 -0.1139020 0.6505447 0.2088800     
{% endhighlight %}

## <a name="ancova"></a>Analysis of Covariance (ANCOVA)

If we add a continuous variable together with a nominal variable (regression + ANOVA), we will get what we call an ANCOVA model:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}X_{1} + \beta_{2}X_{2} + \epsilon\\
\end{aligned}$$

When $$X_{2} = 0$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}X_{1} + \beta_{2}.(0) + \epsilon\\
&= \beta_{0} + \beta_{1}X_{1} + \epsilon\\
\end{aligned}$$

When $$X_{2} = 1$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}X_{1} + \beta_{2}.(1) + \epsilon\\
&= (\beta_{0} + \beta_{2}) + \beta_{1}X_{1} + \epsilon\\
\end{aligned}$$

The slope for both equations $$\beta_{1}$$ are the same and the only difference is the intercept which depends whether the nominal variable is 0 or 1. 

Let's simulate some data:

{% highlight r %}
set.seed(123)
x1 <- rnorm(10, 3, 0.1)
x2 <- rnorm(10, 3, 0.1)
x <- c(x1, x2)
data <-
    data.frame(
        group = c(
            rep(0, length(x1)),
            rep(1, length(x2))
        ),
        x = x,
        y = c(2 * x1 + rnorm(10, 0, 0.2), 2 * x2 + 0.5 + rnorm(10, 0, 0.2))     
    )

plot(
    data$x[1:10], data$y[1:10],
    xlab = "X",
    ylab = "Y",
    col = "red",
    ylim = c(5.5, 7),
    xlim = c(2.8, 3.2)
)
points(data$x[11:20], data$y[11:20], col = "blue")
{% endhighlight %}

![](/assets/img/indicator2.png)

Fitting the model and plotting the 2 regression lines:

{% highlight r %}
fit <- lm(y ~ x + group, data = data)
abline(
    fit$coefficients["(Intercept)"],
    fit$coefficients["x"],
    col = "red"
)
abline(
    fit$coefficients["(Intercept)"] + fit$coefficients["group"],     
    fit$coefficients["x"],
    col = "blue"
)
{% endhighlight %}

![](/assets/img/indicator3.png)

Notice that both the slopes of the simulation and fitted models are the same. This is because the model assumes the slopes to be the same. Let's see what happens if we tweak the simulated data to have different slopes:

{% highlight r %}
set.seed(123)
x1 <- rnorm(10, 3, 0.1)
x2 <- rnorm(10, 3, 0.1)
x <- c(x1, x2)
data <-
    data.frame(
        group = c(
            rep(0, length(x1)),
            rep(1, length(x2))
        ),
        x = x,
        y = c(2 * x1 + rnorm(10, 0, 0.2), -2 * x2 + 11 + rnorm(10, 0, 0.2))     
    )
{% endhighlight %}

Although we simulated the red data to be postively sloped and the blue data to be negatively sloped, both fitted slopes turn out to be negative. To deal with this we would need to turn to interaction which we will address next.

![](/assets/img/indicator4.png)

### Covariates

ANCOVA is also used to remove the effects of covariates by controlling the effect of the continuous variable while accessing the differences of means of the categorical variable. This is done by removing the varation of the covariates from the within-group variation of the categorical variable. Note however that the covariate might be related to the categorical variable that it might remove a considerable amount of variation from the within-group variance.

## <a name="interaction"></a>ANCOVA with Interaction

To address the issue of different slopes, we would need to add an interaction term to the model:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}X_{1} + \beta_{2}X_{2} + \beta_{3}X_{1}X_{2} + \epsilon\\
\end{aligned}$$

When $$X_{2} = 0$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}X_{1} + \beta_{2}.(0) + \beta_{3}X_{1}.(0) + \epsilon\\
&= \beta_{0} + \beta_{1}X_{1} + \epsilon\\
\end{aligned}$$

When $$X_{2} = 1$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}X_{1} + \beta_{2}.(1) + \beta_{3}X_{1}.(1) + \epsilon\\
&= (\beta_{0} + \beta_{2}) + (\beta_{1} + \beta_{3})X_{1} + \epsilon\\
\end{aligned}$$

So effectively $$\beta_{2}$$ changes the intercept (difference between the two intercepts) and $$\beta_{3}$$ changes the slope (difference between the two slopes) for $$X_{2} = 1$$.

Using the earlier example, we can fit an interaction term instead:

{% highlight r %}
fit <- lm(y ~ x + group + x * group, data = data)
abline(
    fit$coefficients["(Intercept)"],
    fit$coefficients["x"],
    col = "red"
)
abline(
    fit$coefficients["(Intercept)"] + fit$coefficients["group"],    
    fit$coefficients["x"] + fit$coefficients["x:group"],
    col = "blue"
)

{% endhighlight %}

![](/assets/img/indicator5.png)

Mathematically, this is equivalent to fitting a separate least squares to each group. But does this mean we always fit an interaction term? Other than subject domain reason, if the two slopes are about the same or if the adjusted R-squared is in fact lower, we would prefer no interaction model instead. This is because we wouldn't need to fit the interaction term and have more degree of freedoms for the other parameters resulting in more power to reject the null hypothesis. 

Another way is to compare the two models (with and without interaction term) via F-test:

$$\begin{aligned}
F &= \frac{\frac{SSE_{regression} - SSE_{full}}{df_{regression} - df_{full}}}{\frac{SSE_{full}}{df_{full}}}\\
F &\sim F_{df_{regression} - df_{full}, df_{full}}
\end{aligned}$$

where $$full$$ includes interaction term and $$regression$$ does not. We can do this test in R in a simpler way:

{% highlight r %}
> anova(
      lm(y ~ x + group, data = data),
      lm(y ~ x + group + x * group, data = data)    
  )

Analysis of Variance Table

Model 1: y ~ x + group
Model 2: y ~ x + group + x * group
  Res.Df     RSS Df Sum of Sq      F    Pr(>F)    
1     17 0.73488                                  
2     16 0.35323  1   0.38165 17.287 0.0007412 ***   
{% endhighlight %}

## <a name="two-way"></a>Two-Way ANOVA

What if we have two nominal variables instead of one? This will result in a two-way anova. Let's simulate one nominal variable $$sex$$ with two levels $$male, female) and another variable $$class$$ with three levels $$A, B, C$$:

{% highlight r %}
set.seed(123)
male_classA <- rnorm(10, 3, 0.1)
male_classB <- rnorm(10, 3.5, 0.1)
male_classC <- rnorm(10, 3.5, 0.2)
female_classA <- rnorm(10, 3.5, 0.1)
female_classB <- rnorm(10, 4, 0.2)
female_classC <- rnorm(10, 4.5, 0.2)

data <-
    data.frame(
        sex = factor(c(
            rep("M", 30),
            rep("F", 30)
        )),
        class = factor(c(
            rep("A", 10), rep("B", 10), rep("C", 10),
            rep("A", 10), rep("B", 10), rep("C", 10)
        )),
        y = c(
            male_classA, male_classB, male_classC,
            female_classA, female_classB, female_classC    
        )
    )

fit <- lm(y ~ sex + class, data = data)

> summary(fit)
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  3.62506    0.05480  66.149  < 2e-16 ***
sexM        -0.71046    0.05480 -12.964  < 2e-16 ***
classB       0.48973    0.06712   7.297 1.12e-09 ***
classC       0.70988    0.06712  10.577 5.76e-15 ***
{% endhighlight %}

We can see three indicator variables. One of them is for the $$sex$$ variable and the other two are for the $$class$$ variable and $$\mu$$ is the mean function:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}I_{sexM} + \beta_{2}I_{classB} + \beta_{3}I_{classC} + \epsilon\\
\end{aligned}$$

When $$sex = F$$ and $$class = A$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}.(0) + \beta_{2}.(0) + \beta_{3}.(0) + \epsilon\\
&= \beta_{0} + \epsilon\\
\beta_{0} &= \mu(sex = F, class = A)
\end{aligned}$$

When $$sex = F$$ and $$class = B$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}.(0) + \beta_{2}.(1) + \beta_{3}.(0) + \epsilon\\
&= \beta_{0} + \beta_{2} + \epsilon\\
\beta_{0} + \beta_{2} &= \mu(sex = F, class = B)
\end{aligned}$$

When $$sex = F$$ and $$class = C$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}.(0) + \beta_{2}.(0) + \beta_{3}.(1) + \epsilon\\
&= \beta_{0} + \beta_{3} + \epsilon\\
\beta_{0} + \beta_{3} &= \mu(sex = F, class = C)
\end{aligned}$$

When $$sex = M$$ and $$class = A$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}.(1) + \beta_{2}.(0) + \beta_{3}.(0) + \epsilon\\
&= (\beta_{0} + \beta_{1}) + \epsilon\\
(\beta_{0} + \beta_{1}) &= \mu(sex = M, class = A)
\end{aligned}$$

When $$sex = M$$ and $$class = B$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}.(1) + \beta_{2}.(1) + \beta_{3}.(0) + \epsilon\\
&= (\beta_{0} + \beta_{1}) + \beta_{2} + \epsilon\\
(\beta_{0} + \beta_{1}) + \beta_{2} &= \mu(sex = M, class = B)
\end{aligned}$$

When $$sex = M$$ and $$class = C$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}.(1) + \beta_{2}.(0) + \beta_{3}.(1) + \epsilon\\
&= (\beta_{0} + \beta_{1}) + \beta_{3} + \epsilon\\
(\beta_{0} + \beta_{1}) + \beta_{3} &= \mu(sex = M, class = C)
\end{aligned}$$

Note that the coefficients w.r.t to $$sex$$ is always either $$\beta_{0}$$ for female and $$\beta_{0} + \beta_{1}$$ for male. This is because this is a non-interaction model. We can better see the predicted means by the following interaction plot and note the parallel lines:

{% highlight r %}
interaction.plot(
    data$class,
    data$sex,
    predict(fit, data[c("sex", "class")]),
    pch = c(16, 18),
    ylab = "Y",
    xlab = "Class",
    trace.label = "Sex",
    main = "Interaction between Class and Sex"    
)
{% endhighlight %}

![](/assets/img/indicator6.png)

If you suspect there is an interaction, we can fit an interaction model:

{% highlight r %}
fit <- lm(y ~ sex + class + sex * class, data = data)

> summary(fit)
Coefficients:
            Estimate Std. Error t value Pr(>|t|)         
(Intercept)  3.53220    0.04717  74.876  < 2e-16 ***
sexM        -0.52474    0.06671  -7.866 1.63e-10 ***
classB       0.46605    0.06671   6.986 4.34e-09 ***
classC       1.01213    0.06671  15.171  < 2e-16 ***
sexM:classB  0.04735    0.09435   0.502    0.618    
sexM:classC -0.60451    0.09435  -6.407 3.77e-08 ***
{% endhighlight %}

![](/assets/img/indicator7.png)

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}I_{sexM} + \beta_{2}I_{classB} + \beta_{3}I_{classC} + \beta_{4}I_{sexM}I_{classB} + \beta_{5}I_{sexM}I_{classC} + \epsilon\\
\end{aligned}$$

When $$sex = F$$ and $$class = A$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}.(0) + \beta_{2}.(0) + \beta_{3}.(0) + \beta_{4}.(0).(0) + \beta_{5}.(0).(0) + \epsilon\\
&= \beta_{0} + \epsilon\\
\beta_{0} &= \mu(sex = F, class = A)
\end{aligned}$$

When $$sex = F$$ and $$class = B$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}.(0) + \beta_{2}.(1) + \beta_{3}.(0) + \beta_{4}.(0).(1) + \beta_{5}.(0).(0) + \epsilon\\
&= \beta_{0} + \beta_{2} \epsilon\\
\beta_{0} + \beta_{2} &= \mu(sex = F, class = B)
\end{aligned}$$

When $$sex = F$$ and $$class = C$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}.(0) + \beta_{2}.(0) + \beta_{3}.(1) + \beta_{4}.(0).(0) + \beta_{5}.(0).(1) + \epsilon\\
&= \beta_{0} + \beta_{3} + \epsilon\\
\beta_{0} + \beta_{3} &= \mu(sex = F, class = C)
\end{aligned}$$

When $$sex = M$$ and $$class = A$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}.(1) + \beta_{2}.(0) + \beta_{3}.(0) + \beta_{4}.(1).(0) + \beta_{5}.(1).(0) + \epsilon\\
&= (\beta_{0} + \beta_{1}) + \epsilon\\
(\beta_{0} + \beta_{1}) &= \mu(sex = M, class = A)
\end{aligned}$$

When $$sex = M$$ and $$class = B$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}.(0) + \beta_{2}.(1) + \beta_{3}.(0) + \beta_{4}.(1).(1) + \beta_{5}.(1).(0) + \epsilon\\
&= (\beta_{0} + \beta_{2}) + \beta_{4} + \epsilon\\
(\beta_{0} + \beta_{2}) + \beta_{4} &= \mu(sex = M, class = B)
\end{aligned}$$

When $$sex = M$$ and $$class = C$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}.(1) + \beta_{2}.(0) + \beta_{3}.(1) + \beta_{4}.(1).(0) + \beta_{5}.(1).(1) + \epsilon\\
&= (\beta_{0} + \beta_{1}) + \beta_{3} + \beta_{5} + \epsilon\\
(\beta_{0} + \beta_{1}) + \beta_{3} + \beta_{5} &= \mu(sex = M, class = C)
\end{aligned}$$

Note that the interaction terms $$\beta_{4}, \beta_{5}$$ only appear for $$sex = M, class = B, C$$, but all coefficients will change accordingly when compared with a non-interaction model. 

We can also use the F-test to compare whether the interaction can be explained by chance alone:

{% highlight r %}
> anova(
      lm(y ~ sex + class, data = data),
      lm(y ~ sex + class + sex * class, data = data)    
  )
  
Analysis of Variance Table

Model 1: y ~ sex + class
Model 2: y ~ sex + class + sex * class
  Res.Df    RSS Df Sum of Sq     F    Pr(>F)    
1     56 2.5227                                 
2     54 1.2017  2     1.321 29.68 2.015e-09 ***
{% endhighlight %}

In fact we can test all the nested models in one shot:

{% highlight r %}
> anova(
      lm(y ~ 1, data = data),
      lm(y ~ class, data = data),
      lm(y ~ sex + class, data = data),
      lm(y ~ sex + class + sex * class, data = data)    
  )
  
Analysis of Variance Table

Model 1: y ~ 1
Model 2: y ~ class
Model 3: y ~ sex + class
Model 4: y ~ sex + class + sex * class
  Res.Df     RSS Df Sum of Sq      F    Pr(>F)    
1     59 15.3755                                  
2     57 10.0940  2    5.2815 118.66 < 2.2e-16 ***
3     56  2.5227  1    7.5713 340.23 < 2.2e-16 ***
4     54  1.2017  2    1.3210  29.68 2.015e-09 ***
{% endhighlight %}

The comparison is done with the model immediately preceding it. The `Df` column shows the additional degree of freedom as compared to the model immediately preceding it. As we can see adding each term in this case are all significant.

Another version of the nested model show the same as well:

{% highlight r %}
> anova(
      lm(y ~ 1, data = data),
      lm(y ~ sex, data = data),
      lm(y ~ sex + class, data = data),
      lm(y ~ sex + class + sex * class, data = data)    
  )

Analysis of Variance Table

Model 1: y ~ 1
Model 2: y ~ sex
Model 3: y ~ sex + class
Model 4: y ~ sex + class + sex * class
  Res.Df     RSS Df Sum of Sq      F    Pr(>F)    
1     59 15.3755                                  
2     58  7.8042  1    7.5713 340.23 < 2.2e-16 ***
3     56  2.5227  2    5.2815 118.66 < 2.2e-16 ***
4     54  1.2017  2    1.3210  29.68 2.015e-09 ***
{% endhighlight %}

## <a name="piecewise"></a>Piecewise Regression

It is possible to use indicator variable to fit a piecewise regression as we shall demonstrate:

{% highlight r %}
set.seed(123)
x1 <- seq(10, 20, 0.5)
y1 <- x1 + rnorm(length(x1), 0, 2)
x2 <- seq(21, 30, 0.5)
y2 <- 0.5 * x2 + rnorm(length(x2), 0, 2)   
x <- c(x1, x2)
y <- c(y1, y2)
plot(x, y)
{% endhighlight %}

![](/assets/img/indicator8.png)

To fit a disconnected piecewise linear regression, we would need to create an indicator variable distinguish the discontinuity point:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}X + \beta_{2}I_{X < 20} + \beta_{3}XI_{X < 20} + \epsilon\\
\end{aligned}$$

When $$X < 20$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}X + \beta_{2}.(0) + \beta_{3}X(0) + \epsilon\\
&= \beta_{0} + \beta_{1}X + \epsilon\\
\end{aligned}$$

When $$X >= 20$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}X + \beta_{2}.(1) + \beta_{3}X(1) + \epsilon\\
&= (\beta_{0} + \beta_{2}) + (\beta_{1} + \beta_{3})X + \epsilon\\
\end{aligned}$$

{% highlight r %}
indicator <- ifelse(x < 20, 0, 1)
fit <- lm(y ~ x + indicator + x * indicator)

abline(
    fit$coefficients["(Intercept)"],
    fit$coefficients["x"],
    col = "red"
)
abline(
    fit$coefficients["(Intercept)"] + fit$coefficients["indicator"],     
    fit$coefficients["x"] + fit$coefficients["x:indicator"],
    col = "blue"
)
{% endhighlight %}

![](/assets/img/indicator9.png)

How about when the point is not disconnected but segmented instead? For example:

{% highlight r %}
set.seed(123)
x1 <- seq(10, 20, 0.5)
y1 <- 0.1 * x1 + rnorm(length(x1), 0, 1)   
x2 <- seq(21, 30, 0.2)
y2 <- x2 + rnorm(length(x2), 0, 2) - 18
x <- c(x1, x2)
y <- c(y1, y2)
plot(x, y)
{% endhighlight %}

![](/assets/img/indicator10.png)

We would need to fit the following model:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}X + \beta_{2}I_{X < 20}.(X - 20) + \epsilon\\
\end{aligned}$$

When $$X < 20$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}X + \beta_{2}.(0).(X - 20) + \epsilon\\
&= \beta_{0} + \beta_{1}X + \epsilon\\
\end{aligned}$$

When $$X >= 20$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}X + \beta_{2}.(1).(X - 20) + \epsilon\\
&= (\beta_{0} - 20\beta_{2}) + (\beta_{1} + \beta_{2})X + \epsilon\\
\end{aligned}$$

In the code, it will be easier to assign a new variable $$X_{2}$$ and fit this model instead:

$$\begin{aligned}
X_{2} &= I_{X < 20}.(X - 20)\\
Y &= \beta_{0} + \beta_{1}X + \beta_{2}X_{2} + \epsilon\\
\end{aligned}$$

{% highlight r %}
indicator <- ifelse(x < 20, 0, 1)
x2 <- x * indicator - 20 * indicator
fit <- lm(y ~ x + x2)

abline(
    fit$coefficients["(Intercept)"],
    fit$coefficients["x"],
    col = "red"
)
abline(
    fit$coefficients["(Intercept)"] -  20 * fit$coefficients["x2"],     
    fit$coefficients["x"] + fit$coefficients["x2"],
    col = "blue"
)
{% endhighlight %}

![](/assets/img/indicator11.png)

Back to the first example of the piecewise regression, if you were to inspect how well is the fit:

{% highlight r %}
> summary(fit)
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   1.2299     2.5881   0.475   0.6375    
x             0.9358     0.1722   5.434 3.96e-06 ***
indicator     0.4232     5.0263   0.084   0.9334    
x:indicator  -0.4856     0.2418  -2.009   0.0521 .       
{% endhighlight %}

The piecewise regression doesn't seem to fit well according to the t-test but we know apriori and from the graph that it is indeed a good fit. When comparing nested models, we should use the anova test instead:

{% highlight r %}
> anova(
    lm(y ~ x),
    lm(y ~ x + indicator + x * indicator)
  )

Analysis of Variance Table

Model 1: y ~ x
Model 2: y ~ x + indicator + x * indicator
  Res.Df    RSS Df Sum of Sq      F   Pr(>F)    
1     38 398.42                                 
2     36 177.48  2    220.94 22.408 4.77e-07 ***    
{% endhighlight %}

Similarly for the segmented regression:

{% highlight r %}
> summary(fit)
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  0.89440    1.37845   0.649    0.519    
x            0.04669    0.08198   0.569    0.571    
x2           0.98667    0.13644   7.231 7.29e-10 ***    

> anova(
      lm(y ~ x),
      lm(y ~ x + x2)
  )
  
Analysis of Variance Table

Model 1: y ~ x
Model 2: y ~ x + x2
  Res.Df    RSS Df Sum of Sq      F    Pr(>F)    
1     65 270.60                                  
2     64 148.92  1    121.68 52.293 7.295e-10 ***
{% endhighlight %}

## <a name="repeated"></a>Confounding Variables + Repeated Measures

What do you do if you are missing a confounding variable and getting unintuitive coefficients from your regression model? In the multiple regression [post]({% post_url 2020-10-05-hypothesis-testing %}#confounding), we explore the issue of missing confounding variable. But what if you do not know what's the confounding variable and would like to control for it? If you have repeated measurements of the same subject across time, you can control for the unobserved confounding effect by adding an subject indicator/categorical variable. It is essential that you have multiple measurements for each subject because if not you would not have enough degree of freedoms for the errors.

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}X_{1} + \beta_{2}X_{2} + \beta_{3}I_{2} + \cdots + \beta_{n}I_{N - 1} + \epsilon\\
\end{aligned}$$

The above equation assumes $$N$$ subjects with one left out due to dummy coding.

For example, for subject 2: $$I_{2} = 1$$:

$$\begin{aligned}
Y &= \beta_{0} + \beta_{1}X_{1} + \beta_{2}X_{2} + \beta_{3}.(1) + \cdots + \beta_{n}.(0) + \epsilon\\
&= \beta_{0} + \beta_{1}X_{1} + \beta_{2}X_{2} + \beta_{3} + \epsilon\\
\end{aligned}$$

The coefficients $$\beta_{2}$$ is interpreted as the mean difference of $$Y$$ for a particular subject in two different time measurements while holding $$\beta_{1}$$ the same.

However there is a catch with this approach. The independence assumption of linear regression is clearly violated as the different measurements across time for the same subjects are not independent. This would inflate the standard errors as we have artificially boost the number of $$N$$ when in fact many of these measurements are from the same subject. In practical cases, the analysts would mistakenly lump up these repeated measures as independent without the subject-indicator variable. This would be a worse problem than not controlling for subject effects. So either use just one measurement or at least add the subject-indicator variable to control for confounding effects and reduce dependency violation. This has the same effect as making the subject a random-effects model vs assuming it as a fixed-effects model.
