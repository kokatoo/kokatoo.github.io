---
layout: post
title: "Hypothesis Testing (Part 2) Power and Type I/II Errors"
date: 2020-10-05 03:30:06 +0800
img : power2.png
categories:
---

Today we will continue with part 2 of the Hypothesis Testing series about Power and Type I/II errors. If you haven't checked out part 1 please check it out [here]({% post_url 2020-10-05-hypothesis-testing %})

## Part 2: Power and Type I/II Errors

### Type I/II Errors

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

## Power

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

We can generate this to a difference of 2 samples as well with a similar process. 

## Effect Size

As previously stated, with a large enough sample size, any test will be eventually significant. To counter this problem, the experimenter have to take account of effect size. Note that p-value does not give any information about effect size. With the same effect size, the p-value can change with a different sample size.

So what exactly is effect size? It is also known as Cohen's $$\delta$$ and is defined as the distance between two population means:

$$\delta = \frac{\mu 1 - \mu 0}{\sigma}$$

For categorical variables, we can define effect size as:

$$\delta = z(Hit\: Rate) - z(Type\:I\:Rate)$$

where $$z$$ is the normal distribution score which cumulative probability equals the rate.

For example, if the hit rate is 0.8 and Type I error rate is 0.2:

{% highlight r %}
> qnorm(0.8) - qnorm(0.2)  
[1] 1.683242
{% endhighlight %}


In Part 3, we will start discussing about Analysis of Variance. Stay tuned!
