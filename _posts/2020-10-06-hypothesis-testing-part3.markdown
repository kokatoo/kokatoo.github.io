---
layout: post
title: "Hypothesis Testing (Part 3) One-Way ANOVA"
date: 2020-10-05 03:30:06 +0800
img : anova1.png
tags: [statistics, hypothesis testing]
---

Today we will continue with part 3 of the Hypothesis Testing series on One-way ANOVA. If you haven't checked out part 2 please check it out [here]({% post_url 2020-10-05-hypothesis-testing-part2 %})

<div class="toc" markdown="1">
# Contents:
- [Sum of Squares](#ss)
- [Mean Variances](#mean)
- [Simulation](#simu)
- [Assumptions of ANOVA](#assumptions)
- [Scheffé Test](#scheffe)
- [Effect Size](#effect)
</div>

## <a name="ss"></a>Sum of Squares

When there are more than 2 means to compare, we can use ANOVA to detect any significance differences among them (note ANOVA can compare 2 means as well). ANOVA as its name suggests, is an analysis of 2 estimates of variance. It is a ratio between the variance coming from differences between groups and variance coming from differences within groups. 

We calculate the total sum of squares by the following:

$$SS=\sum (Y - \bar{Y})^{2}$$

And the variance:

$$S^{2}=\frac{\sum (Y - \bar{Y})^{2}}{N - 1}$$

For this example, we will simulate 3 different types of treatments performed on 9 subjects equally divided into 3 groups/treatments.

| Treatment 1 | Treatment 2 | Treatment 3 |
|-------------|-------------|-------------|
| Subject 1   | Subject 4   | Subject 7   |
| Subject 2   | Subject 5   | Subject 8   |
| Subject 3   | Subject 6   | Subject 9   |

$$\begin{aligned}
H_{0}&: \mu_{1} = \mu_{2} = \mu_{3}
\end{aligned}$$

$$\begin{aligned}
H_{1}&: \mu_{1} = \mu_{2} \neq \mu_{3}\\
H_{1}&: \mu_{1} \neq \mu_{2} = \mu_{3}\\
H_{1}&: \mu_{1} \neq \mu_{3} \neq \mu_{2}\\
H_{1}&: \mu_{1} \neq \mu_{2} \neq \mu_{3}
\end{aligned}$$

We can break up $$SS_{Total}$$ into $$SS_{Between}$$ and $$SS_{Within}$$ with $$i = 3$$ and $$j = 3$$.

$$Y_{ij} - \bar{Y} = (Y_{ij} - \bar{Y_{j}}) + (\bar{Y_{j}} - \bar{Y})$$

We can square both sides and sum up both the i and j. Note the intermediate cross terms will cancel out to 0.

$$\sum_{i}^{}\sum_{j}^{}(Y_{ij} - \bar{Y})^{2} = n\sum_{j}^{}(\bar{Y_{j}} - \bar{Y})^{2} + \sum_{i}^{}\sum_{j}^{}(Y_{ij} - \bar{Y_{j}})^{2}$$

$$SS_{Total} = SS_{Between} + SS_{Within}$$

## <a name="mean"></a>Mean Variances

$$df_{Between}$$ is number of groups $$k$$ minus 1 due to 1 $$df$$ lost from estimating total mean.

$$df_{Between} = k - 1$$

Within df is $$N$$ minus number of groups due to 3 $$dfs$$ lost from estimating group means.

$$df_{Within} = N - k$$

$$df_{Total}$$ is the number of subjects minus 1 due to 1 $$df$$ lost from estimating total mean.

$$df_{Total} = N - 1$$

$$df_{Total} = df_{Between} + df_{Within}$$

Variance is also similarly broken down into between and within mean squares:

$$MS_{Total} = MS_{Between} + MS_{Within}$$

$$\frac{SS_{Total}}{df_{Total}} = \frac{SS_{Between}}{df_{Between}} + \frac{SS_{Within}}{df_{Within}}$$

Basically $$MS_{Between}$$ is the variance based on the variability between the 3 group means while $$MS_{Within}$$ is the average of the variance within 3 groups.

Finally the $$F$$ score is computed from computing the ratio of the between and within mean squares (variances):

$$F = \frac{MS_{Between}}{MS_{Within}}$$

$$df = (k - 1), (N - k)$$

If the null hypothesis is true, we should get a low $$F$$ score. We will need to compute the p-value from a $$F_{k-1, N-k}$$ distribution.

## <a name="simu"></a>Simulation

In our first simulation example, Treatment 1 and 2 will share the same mean while Treatment 3 will have a different mean and all have the same variance.

{% highlight r %}
mu1 <- 100
mu2 <- 100
mu3 <- 108
sigma <- 5
n <- 3

data1 <- rnorm(n, mean = mu1, sd = sigma)
data2 <- rnorm(n, mean = mu2, sd = sigma)
data3 <- rnorm(n, mean = mu3, sd = sigma)
data <- c(data1, data2, data3)

ybar <- mean(data)

SS_Group <- n *
  sum((mean(data1) - ybar)^2 +
      (mean(data2) - ybar)^2 +
      (mean(data3) - ybar)^2)

SS_Within <- sum((data1 - mean(data1))^2) +
  sum((data2 - mean(data2))^2) +
  sum((data3 - mean(data3))^2)

SS_Total <- sum((data - mean(data))^2)

k <- 3
N <- n * k

fscore <- (SS_Group / (k - 1)) / (SS_Within / (N - k))     

+ SS_Group
+ SS_Within
+ SS_Total
+ SS_Group + SS_Within
+ fscore
+ 1 - pf(fscore, df1 = k - 1, df2 = N - k)
+ 
> [1] 254.7959
> [1] 140.6314
> [1] 395.4273
> [1] 395.4273
> [1] 5.435399
> [1] 0.04498284
{% endhighlight %}

Let's check this with the `aov` function in R:

{% highlight r %}
df <- data.frame(response = data,
                 treatment = as.factor(c(1, 1, 1, 2, 2, 2, 3, 3, 3)))      

fit <- aov(response ~ treatment, data = df)
+ summary(fit)
+ 
            Df Sum Sq Mean Sq F value Pr(>F)
treatment    2  254.8  127.40   5.435  0.045 *
Residuals    6  140.6   23.44
---
{% endhighlight %}

We see the calculations match. But it's barely significant. Let's try plotting the $$F$$ distribution:

{% highlight r %}
x <- seq(0, 8, length = 100)
probs <- df(x, df1 = N - k, df2 = k - 1)

plot(x, probs, type = "l", main = "F Distribution")     
abline(v = fscore, col = "red")
{% endhighlight %}

![](/assets/img/anova1.png)

Now let's try if all the means are the same:

{% highlight r %}
mu1 <- 100
mu2 <- 100
mu3 <- 100
sigma <- 5    
n <- 3

fit <- aov(response ~ treatment, data = df)
> summary(fit)
            Df Sum Sq Mean Sq F value Pr(>F)     
treatment    2  114.3   57.17   1.849  0.237
Residuals    6  185.5   30.91 
{% endhighlight %}

We can see it is non-significant now. How about if the variances are different instead?

{% highlight r %}
mu1 <- 100
mu2 <- 105
mu3 <- 110
n <- 10

data1 <- rnorm(n, mean = mu1, sd = 10)
data2 <- rnorm(n, mean = mu2, sd = 10)
data3 <- rnorm(n, mean = mu3, sd = 30)
data <- c(data1, data2, data3)
df <- data.frame(response = data,
                 treatment = as.factor(c(1, 1, 1, 2, 2, 2, 3, 3, 3)))       

fit <- aov(response ~ treatment, data = df)
> summary(fit)
            Df Sum Sq Mean Sq F value Pr(>F)
treatment    2  114.3   57.17   1.849  0.237
Residuals    6  185.5   30.91 
{% endhighlight %}

We can see even though the means are different, the test is non-significant. Let's check the assumptions for ANOVA next.

## <a name="assumptions"></a> Assumptions for ANOVA

Please check out [assumptions for t-tests](/2020/10/05/hypothesis-testing-part2.html#assumption) for more details as the assumptions are the same.

In summary:

- Each group is normally distributed
- All groups have a common variances
- The independent variable is discrete and dependent variable continuous

$$F$$ test is relatively robust to deviation from normality given that:

- Distributions are symmetrical and uni-modal
- Sample sizes are equal (Balanced Design) and greater than 10 for each group

However $$F$$ test is not robust to violations of variance homogeneity as we can see from the above simuation. A rule of thumb is the ratio between the highest variance and lowest variance < 3.

## <a name="scheffe"></a>Scheffé Test

Once we are done with ANOVA, how can we know which groups are significant? If we do multiple pairwise comparisions we will incur a higher Type I error. We discussed Bonferroni in part 2 of the series. In this series, we will touch on Scheffé. The idea is to do multiple pairwise ANOVA. We will use $$MS_{Within}$$ sas the estimate for the within group variability as one of the assumption of ANOVA is the variance homogeneity. 

$$\begin{aligned}
SS_{Between} &= n(Y_{1} - \bar{Y})^{2} + n(Y_{2} - \bar{Y})^2\\\\
MS_{Between} &= \frac{SS_{Between}}{SS_{Within}}\\\\
F_{k-1, N-k} &= \frac{MS_{Between}}{MS_{Within}}
\end{aligned}$$

## <a name="effect"></a>Effect Size

Back in part 2 we discussed about effect size in terms of t-test. In ANOVA, effect size is defined as:

$$\eta^{2} = \frac{SS_{Between}}{SS_{Total}}$$

Similar to the effect size in t-test, $$\eta^{2}$$ tells us the how much the variability of the dependent variance that is explained by the variability of the independent variable.


In Part 4, we will explore Two-Way ANOVA . Stay tuned!
