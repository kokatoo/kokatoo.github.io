---
layout: post
title: "Uncover Hypothesis Testing (Part 1)"
date: 2020-10-05 02:30:06 +0800
img : ht.png
categories:
---

We are going to start a series of blog posts that will target hypothesis testing by generating data where we know the distribution and the population parameters in R. We will go through different scenarios and uncover and better understand the concept behind hypothesis testing. We will start off with a simple one-sample t-test.

## Part 1: One-Sample z/t test

We start by creating a function that is able to generate 100 samples each containing n elements. The true underlying population distribution is computed by passing the distribution function and the mean and sigma.

{% highlight r %}
gen_data <- function(fun, mu, sigma, n) {   
  sapply(
    1:100,
    function(i) {
      fun(n, mean = mu, sd = sigma)
    }
  )
}
{% endhighlight %}

Let's start with a simple normal distribution with `mu = 100` and `sigma = 15` with a sample of `n = 25` elements.

{% highlight r %}
mu <- 100
sigma <- 15
n <- 25
data <- gen_data(rnorm, mu, sigma, n)   
{% endhighlight %}

Let's plot the Gaussian distribution with the population parameters.

{% highlight r %}
plot_dist <- function(fun, mu, sigma) {
  x <- mu + seq(-4, 4, length = 100) * sigma
  probs <- fun(x, mean = mu, sd = sigma)
  plot(x, probs, type = "l", main = "Population Distribution")    
}

plot_dist(dnorm, mu, sigma)
{% endhighlight %}

![](/assets/img/ht1.png)

Now let's plot the sampling distribution of the means based on the 100 samples we generated earlier. Because our sample size is less than 30, we would choose to use the t-distribution as the overlapping curve in the histogram.
{% highlight r %}
plot_sampling_dist <- function(data) {
  means <- apply(data, 2, mean)
  x <- seq(min(means), max(means), length = 100)
  ts <- metRology::dt.scaled(x, mean = mean(means), sd = sd(means), df = n - 1)      
  res <- hist(means,
    col = "red",
    xlab = "Sample Mean",
    main = "Sampling Distribution",
    freq = FALSE,
    ylim = c(0, max(ts))
  )
  lines(x, ts)
}

plot_sampling_dist(data)
{% endhighlight %}

![](/assets/img/ht2.png)

As we can see, the sampling distribution looks very normal (and it should be according to CLT). Note that the overlapping curve is a t-distribution with `df = n-1`.

Next let's regenerate the samples and randomly select a sample from `data` to do a t-test.

{% highlight r %}
data <- gen_data(rnorm, mu, sigma, n)    
sample <- data[, 50]
{% endhighlight %}

Next we shall compute the t score for this particular sample and plot the distribution and p-value.

{% highlight r %}
plot_tdist <- function(n, title) {    
  x <- seq(-4, 4, length = 100)
  ts <- dt(x, df = (n - 1))

  plot(
    x,
    ts,
    type = "l",
    xlab = "",
    ylab = "",
    main = title
    )
  )
}

sample <- data[, 80]
tscore <- calc_t_score(sample, mu)

title <- paste(
  "t-distribution (df=",
  (n - 1),
  ", pvalue=",
  round(1 - pt(tscore, n - 1), 2),
  ")"
)
plot_tdist(n, title)
abline(v = tscore, col = "red")
{% endhighlight %}

![](/assets/img/ht3.png)

As you can see from the p-value, we fail to reject the null hypothesis that the population mean is 100. However we might be lucky here as we are taking the significance level of 5%. In other words, out of 100 times when we do this test, on average 5% will reject the hypothesis wrongly (Type I error). Let's try to simulate this.

{% highlight r %}
data <- gen_data(rnorm, mu, sigma, n)
plot_tdist(n, "")
abline(v = qt(0.95, df = n - 1), lwd = 3)    

for (i in seq_len(ncol(data))) {
  sample <- data[, i]
  tscore <- calc_t_score(sample, mu)
  if (tscore > qt(0.95, df = n - 1)) {
    abline(v = tscore, col = "blue")
  }
  else {
    abline(v = tscore, col = "red")
  }
}
{% endhighlight %}

![](/assets/img/ht4.png)

The black line represent the 95th percentile and on average you will have about 5 blue lines on the right.

In Part 2, we will discuss about Power and Type I and Type II errors. Stay tuned!
