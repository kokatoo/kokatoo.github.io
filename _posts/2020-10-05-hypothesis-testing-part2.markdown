---
layout: post
title: "Hypothesis Testing (Part 2) Power and Type I/II Errors"
date: 2020-10-05 03:30:06 +0800
img : power2.png
tags: [statistics, hypothesis testing]
---

Today we will continue with part 2 of the Hypothesis Testing series about Power and Type I/II errors. If you haven't checked out part 1 please check it out [here]({% post_url 2020-10-05-hypothesis-testing %})

<div class="toc" markdown="1">
# Contents:
- [Type I/II Errors](#type)
- [Power](#power)
- [Two-Sample t-test](#two)
- [Paired-Sample t-test](#paired)
- [Assumptions t-test](#assumption)
- [Effect Size](#effect)
</div>

## <a name="type"></a>Type I/II Errors

We can represent the above null/alternative hypothesis by the below confusion matrix:

|           | H0 True                    | H0 False               |
|-----------|----------------------------|------------------------|
| Reject H0 | Type I error (False Alarm) | Power (Hit)            |
| Accept H0 | Correct                    | Type II error (Miss)   |

From the confusion matrix we can see that 4 things can happen, If H0 is true, the probability of making a wrong decision is $$\alpha$$ and the probability of making a right decision is $$1 - \alpha$$. If H0 is false, the probability of making a right decision to reject H0 is $$1 - \beta$$ and the probability of making a wrong decision is $$\beta$$.

Type I error is determined by the significance level alpha. In our above example, $$\alpha = 0.05$$. This mean out of 100 times, on average we will reject the null hypothesis when the null hypothesis is in fact true. On the contrary, if null hypothesis is false and we fail to reject the null hypothesis, we have made a Type II error. We can plot the 2 different hypothesis below:

{% highlight r %}
plot_dists <- function(fun, fun2, mu, sigma) {
  x <- mu + seq(-4, 6, length = 100) * sigma / sqrt(n)
  plot(x, fun(x), ylab = "Probs", type = "l", main = "Null vs Alternative Distribution")      
  lines(x, fun2(x), col = "blue")
}

mu0 <- 100
mu1 <- 108
sigma <- 15
n <- 25

plot_dists(
  purrr::partial(metRology::dt.scaled, mean = mu0, sd = sigma / sqrt(n), df = n - 1),
  purrr::partial(metRology::dt.scaled, mean = mu1, sd = sigma / sqrt(n), df = n - 1),
  mu0,
  sigma
)

alpha_pt <- mu0 + qt(0.95, df = n - 1) * sigma / sqrt(n)
abline(
  v = alpha_pt,
  col = "red"
)
{% endhighlight %}

![](/assets/img/power2.png)

The shaded black represents alpha (Type I error). The area under the curve will be equal to 0.05. On the left side shaded blue under the alternative hypothesis will be beta (Type II error). This is so because we will fail to reject the null hypothesis when the alternative hypothesis is true.

## <a name="power"></a>Power

Power is defined as the ability to reject the null hypothesis when the alternative hypothesis is true. This is shown as shaded blue below:

![](/assets/img/power7.png)

Let's calculate the power for the above distributions and compare the result with `pwr` package.

{% highlight r %}
> 1 - pt((alpha_pt - mu1) * sqrt(n) / sigma, df = n - 1)    
[1] 0.8256449
{% endhighlight %}

{% highlight r %}
+ pwr::pwr.t.test(
+   d = (mu1 - mu0) / sigma,
+   sig.level = 0.05,
+   type = "one.sample",
+   alternative = "greater",
+   n = n
+ )
+ 
     One-sample t test power calculation     

              n = 25
              d = 0.5333333
      sig.level = 0.05
          power = 0.8277834
    alternative = greater
{% endhighlight %}

So how can we increase the power? We can increase the probability of making a Type I error by shifting the dividing line to the left. But is there a better way? We can increase the effect size (standardized difference). Let's move the mean of `mu1` to `110`.

{% highlight r %}
mu0 <- 100
mu1 <- 108
sigma <- 10   
n <- 25
{% endhighlight %}

![](/assets/img/power3.png)

As you can see the blue curve has moved more to the right. We can also decrease the variance:

{% highlight r %}
mu0 <- 100
mu1 <- 108
sigma <- 15   
n <- 50
{% endhighlight %}

![](/assets/img/power4.png)

We can see the distributions become thinner. However, we can little control over the effect size or the variance. There is a better way which is to just increase the sample size.

{% highlight r %}
mu0 <- 100
mu1 <- 108
sigma <- 15   
n <- 50
{% endhighlight %}

![](/assets/img/power5.png)

Note that with a large enough sample size, the null hypothesis will eventually be rejected as it is almost definitely never exactly true. This can also be seen in the formula for the test statistic where we multiply by $$\sqrt{n}$$ and with a big enough n the test statistic can be made arbitrary large. Usually what practitioners do is to use power analysis to calculate the sample size needed to detect a particular effect size with the levels of $$\alpha$$ and $$\beta$$ specificed.

## <a name="two"></a> Two-Sample t-test

A two-sample t test is similar to the one-sample t test except that we have a second mean, variance, and a potentially different sample size. 

$$\begin{aligned}
t &= \frac{\bar{x}_{A} - \bar{x}_{B}}{\sqrt{\frac{S_{Pool}^2}{n_{A}} + \frac{S_{Pool}^2}{n_{B}}}}\\\\
S_{Pool} &= \frac{\sum{(x - \bar{x}_{A})^{2}} + \sum{(x - \bar{x}_{B})^{2}}}{n_{A} + n_{B} - 2}\\\\
df &= n_{A} + n_{B} - 2
\end{aligned}$$

## <a name="paired"></a>Paired-Sample t-test

Also known as the dependent t-test, within-subjects or repeated-measures test. This test is used when the two groups are related such that the same participant is being tested more than once. So essentially we pair the same individuals up and reduce the overall variation as each pair is his or her own control.

$$\begin{aligned}
t &= \frac{\sum_{i}x_{Ai} - x_{Bi}}{\frac{S_{diff}}{\sqrt{n}}}
\end{aligned}$$

$$S_{diff}$$ is the standard deviation of the differences of the two groups.

## <a name="assumption"></a>Assumptions t-test

The violation of key assumptions usually affect the Type I error rate. This mean the Type I error rate intended is not what it is in reality.

### Independent and Identitically Distributed (IID)

The key requirement of the sampled data is that they have to be IID. Firstly the data needs to be independent. If you design an experiment, it is important that each participant only participate one time. Even for paired t-tests, each pair has to be unique. A way to get around the problem of multiple identical participants is to average the score for each participant. Next the data in the sample should come from the same distribution and have the same variance (identically distributed). Do not mix them if they come from different distribution. For example if you are comparing the heights for two groups of people in different region, take note that one sample might include more females than males.

Let us simulate a population that is not independent. First we construct a covariance matrix with `variance = 1`:

{% highlight r %}
corr <- 0.9
cov.mat <-
  matrix(
    c(1, corr,
      corr, 1),   
    nrow = 2)
{% endhighlight %}

Then we simulate 100 trials with `data1` containing correlated data:

{% highlight r %}
set.seed(123)
diffs <- c()
n <- 25
for (i in 1:100) {
  df <-
      data.frame(
          MASS::mvrnorm(
              n = n,
              mu = c(0, 0),
              Sigma = cov.mat
          )
      )
  data1 <- c(df[, 1], df[, 2])
  data2 <- rnorm(n * 2, 0, 1)
  mu1 <- mean(data1)
  mu2 <- mean(data3)
  diffs <- c(mu1 - mu2, diffs)
}
> length(diffs[abs(diffs) > 1.96 * sqrt(2 * 1 / (n * 2))])    
[1] 14
{% endhighlight %}

We can see a false alarm rate of 14% vs an expected Type I error of 5%. Using the same seed but reverting back to independent data we got a decent 4%.

{% highlight r %}
set.seed(123)
data1 <- rnorm(n * 2, 0, 1)
data2 <- rnorm(n * 2, 0, 1)
> length(diffs[abs(diffs) > 1.96 * sqrt(2 * 1 / (n * 2))])    
[1] 4
{% endhighlight %}

Next we simulate the non-identical distribution part. We will split the population into 2 groups with different means. During the sample process, we over sample from the first group. This will result in data not coming from the same population distribution (like oversampling males vs females when comparing heights).

{% highlight r %}
set.seed(123)
data1 <- rnorm(1000, 1, 1)
data2 <- rnorm(1000, 3, 1)
data3 <- c(data1, data2)
variance <- var(data3)
diffs <- c()
n <- 8
for(i in 1:100) {
  mu1 <- mean(c(sample(data1, n-1, TRUE), sample(data2, 1, TRUE)))     
  mu2 <- mean(sample(data3, n, TRUE))
  diffs <- c(mu1 - mu2, diffs)
}
> length(diffs[abs(diffs) > 1.96 * sqrt(2 * variance / n)])
17
{% endhighlight %}

We get a more decent Type I rate when we sample from the same distribution:

{% highlight r %}
set.seed(123)
mu1 <- mean(sample(data3, n, TRUE))
mu2 <- mean(sample(data3, n, TRUE))
> length(diffs[abs(diffs) > 1.96 * sqrt(2 * variance / n)])     
4
{% endhighlight %}

T-test also require that the population distributions are Gaussian. This can be violated as long as the distribution is unimodal and not too skewed. The sample size need to be > 30 especially if it's non-Gaussian.

Lastly the two population should have the same variance. This is especially problematic if the sample sizes are different. Let's simulate different sample sizes and variances. First we look at the base case:

{% highlight r %}
set.seed(1234)
sigma1 <- 1
sigma2 <- 1
n1 <- 5
n2 <- 5

diffs <- c()
data1 <- rnorm(10000, 0, sigma1)
data2 <- rnorm(10000, 0, sigma2)
pool <- sum((data1 - mean(data1))^2) + sum((data2 - mean(data2))^2)     
pool <- pool / (n1 + n2 - 2)

for (i in 1:100) {
  d1 <- sample(data1, n1, replace = TRUE)
  d2 <- sample(data2, n2, replace = TRUE)

  pool <- sum((d1 - mean(d1))^2) + sum((d2 - mean(d2))^2)
  pool <- pool / (n1 + n2 - 2)
  
  mu1 <- mean(d1)
  mu2 <- mean(d2)
  if (abs(mu1 - mu2) > 1.96 * sqrt(pool / n1 + pool / n2)) {     
    diffs <- c(mu1 - mu2, diffs)
  }
}
> length(diffs)
[1] 8
{% endhighlight %}

Now let's increase $$\sigma_{2}$$ to 5:

{% highlight r %}
sigma1 <- 1
sigma2 <- 5
n1 <- 5
n2 <- 5
> length(diffs)   
[1] 10
{% endhighlight %}

We can see a slight increase in Type I error. How about if we increase n2 to 25:

{% highlight r %}
sigma1 <- 1
sigma2 <- 5
n1 <- 5
n2 <- 25
> length(diffs)   
[1] 0
{% endhighlight %}

We get 0 Type I error. This is because when we pair the small sample with the small population variance, the pooled estimated variance is inflated making it hard to reject the null hypothesis. Similary if we pair the small sample with the large population variance, the pooled estimated variance is deflated making tType I error to be inflated. Let's simulate this:

{% highlight r %}
sigma1 <- 1
sigma2 <- 5
n1 <- 25
n2 <- 5
> length(diffs)   
[1] 38
{% endhighlight %}

The following table summarizes the result:

| $$n_{1} = 5 \mathbin{,} n_{2} = 5$$ | $$\sigma_{2} = 1$$ | $$\sigma_{2} = 5$$ |
|-----------------------|--------------------|--------------------|
| $$\sigma_{1} = 1$$    |               0.08 |               0.10 |
| $$\sigma_{1} = 5$$    |               0.09 |               0.08 |


| $$n_{1} = 5 \mathbin{,} n_{2} = 25$$ | $$\sigma_{2} = 1$$ | $$\sigma_{2} = 5$$ |
|--------------------------------------|--------------------|--------------------|
| $$\sigma_{1} = 1$$                   |               0.05 |               0.00 |
| $$\sigma_{1} = 5$$                   |               0.38 |               0.05 |

## <a name="effect"></a>Effect Size

As previously stated, with a large enough sample size, any test will be eventually significant. To counter this problem, the experimenter have to take account of effect size. This is because larger effect size are less susceptible to the sample size problem. Note that p-value does not give any information about effect size. With the same effect size, the p-value can change with a different sample size. In other words, you should not compare p-values among experiments when the sample sizes are not the same and be especially wary of small effect size with large sample.

So what exactly is effect size? It is also known as Cohen's $$\delta$$ and is defined as the distance between two population means:

$$\delta = \frac{\mu 1 - \mu 0}{\sigma}$$

In signal detection theory (detecting signal vs noise), we can define effect size as:

$$\begin{aligned}
\delta &= z(Hit\: Rate) - z(False\:Alarm\:Rate)\\\\
Hit\: Rate &= \frac{Hit}{Hit + Miss}\\\\
False\:Alarm\:Rate &= \frac{Type\: I\: Error}{Correct}
\end{aligned}$$

where $$z$$ is the normal distribution score which cumulative probability equals the rate.

For example, if the hit rate is 0.8 and Type I error rate is 0.2:

{% highlight r %}
> qnorm(0.8) - qnorm(0.2)  
[1] 1.683242
{% endhighlight %}


In Part 3, we will start discussing about Analysis of Variance. Stay tuned!
