---
layout: post
title: "Model Selection"
date: 2020-11-30 01:30:06 +0800
img : selection.png
tags: [statistics, regression]
---

We know from the Law of Total Expectation that additional variables will never make the prediction worse, and so if you know the conditional mean function of $$N$$ variables, one should always use all of them since the conditional mean function is the most optimal:

$$\begin{aligned}
E(Y \mid X_{1} = x_{1}, \cdots, X_{N} = x_{n})
\end{aligned}$$

We also know from the Law of Total Variance that having more predictors would reduce the variance of the conditional distribution of $$Y \mid X$$ as the expected conditional mean function explains more of the variance of $$Y$$:

$$\begin{aligned}
E[Var(Y \mid X_{1}, \cdots, X_{N})] &\leq E[Var(Y \mid X_{1}, \cdots, X_{N - 1})]\\
&\leq \cdots\\
&\leq E[Var(Y \mid X_{1})]\\
\end{aligned}$$

However, one would almost never know the true conditional means but rather an estimate of them using a regression model based on the estimated parameters. Not surprisingly, a subset of the $$N$$ variables will often a more accurate prediction than using all of them.

Note that model selection pertains to finding good predictive model and not models that are casually connected with $$Y$$. For causal studies, variable selection is not recommended.


<div class="toc" markdown="1">
# Contents:
- [Bias-Variance Tradeoff](#tradeoff)
- [Information Criteria and Cross-Validation](#info)
- [Stepwise Regression](#stepwise)
</div>

## <a name="tradeoff"></a>Bias-Variance Tradeoff

Assuming we know the true conditional mean model for the $$Y$$ distribution $$E(Y \mid X)$$, but the estimates of the parameters $$\bm{\hat{\beta}}$$ would differ from the true estimates $$\bm{\beta}$$. Having more parameters to estimate would naturally increase the error due to estimation. Reducing this error estimation would however increase the bias as you are using a reduced model.

Let's break down the variance of $$Y$$ using a model $$\hat{\mu} = E(Y \mid X = x)$$ and the true $$\mu = E(Y \mid X)$$:

$$\begin{aligned}
E[(Y - \hat{\mu})^{2}] &= E[(Y - \mu + \mu - \hat{\mu})^{2}]\\
&= E[(Y - \mu)^{2}] + 2E[(Y - \mu)(\mu - \hat{\mu})] + E[(\mu - \hat{\mu})^{2}]\\
\end{aligned}$$

Since we are assuming the errors $$E(Y - \mu)$$ are independent of $$\hat{\mu}$$:

$$\begin{aligned}
E[(Y - \hat{\mu})^{2}] &= \sigma_{Y \mid X}^{2} + 0 + E[(\mu - \hat{\mu})^{2}]\\
&= \sigma_{Y \mid X}^{2} + E[(\mu - \hat{\mu})^{2}]\\
\end{aligned}$$

Breaking down $$E[(\mu - \hat{\mu})^{2}]$$ further:

$$\begin{aligned}
E[(\mu - \hat{\mu})^{2}] &= E[(\mu - E[\hat{\mu}] + E[\hat{\mu}] - \hat{\mu})^{2}]\\
&= E[(\mu - E[\hat{\mu}])^{2}] + 2E[(\mu - E[\hat{\mu}])(E[\hat{\mu}] - \hat{\mu})] + E[(E[\hat{\mu}] - \hat{\mu})^{2}]\\
\end{aligned}$$

Since $$E[\hat{\mu}] = E[\mu]$$,

$$\begin{aligned}
E[(\mu - \hat{\mu})^{2}] &= E[(\mu - E[\hat{\mu}])^{2}] + 2E[(\mu - \mu])(E[\hat{\mu}] - \hat{\mu})] + E[(E[\hat{\mu}] - \hat{\mu})^{2}]\\
&= E[(\mu - E[\hat{\mu}])^{2}] + 0 + [(E[\hat{\mu}] - \hat{\mu})^{2}]\\
&= E[(\mu - E[\hat{\mu}])^{2}] + [(E[\hat{\mu}] - \hat{\mu})^{2}]\\
&= Bias(\hat{\mu}) + Var(\hat{\mu})
\end{aligned}$$

Putting them together:

$$\begin{aligned}
E[(Y - \hat{\mu})^{2}] &= E[(Y - \mu)^{2}] + E[(\mu - E[\hat{\mu}])^{2}] + [(E[\hat{\mu}] - \hat{\mu})^{2}]\\
&= \sigma_{Y \mid X}^{2} + Bias(\hat{\mu}) + Var(\hat{\mu})\\
\end{aligned}$$

In the context of a reduced model, the smaller model has a smaller number of parameters to estimate which will increase the bias but reduce the variance of the model. If the reduction in the variance is bigger than the increase of the bias, the smaller model will end up having a lower prediction error compared to the fuller model.

Let's simulate an example. Suppose we have three variables where we simulate different means but the pairwise correlation between them are all 0.5 and they come from a multivariate normal distribution:

{% highlight r %}
set.seed(123)
nsim <- 10000
n <- 20

covs <-
  diag(c(5, 5, 0.3)) %*%
  matrix(c(1, 0.5, 0.5,
           0.5, 1, 0.5,
           0.5, 0.5, 1), nrow = 3) %*%   
  diag(c(5, 5, 0.3))

means <- c(250, 150, 3)
X <- MASS::mvrnorm(n, means, covs)
X1 <- round(X[, 1], 0)
X2 <- round(X[, 2], 0)
X3 <- round(X[, 3], 0)
{% endhighlight %}

Next we set up a "true" model by making up some parameters:

{% highlight r %}
b0 <- -0.5
b1 <- 0.02
b2 <- 0.005
b3 <- 0.02
EY <- b0 + b1 * X1 + b2 * X2 + b3 * X3   
{% endhighlight %}

Let's do some prediction. Assume we have a data point we want to predict. We will assign three variables for the full model but only one variable for the reduced model:

{% highlight r %}
x_full <- c(1, 140, 160, 2.7)   
x_reduced <- c(1, 140)
{% endhighlight %}

Assuming the population standard deviation to be 0.2, we can generate some random data based on the parameters we set above and fit a full and reduced linear models `nsim` times and for each time we will simulate `n` data points:

{% highlight r %}
sigma <- 0.2
model_full <-
    replicate(
        nsim,
        lm(EY + rnorm(n, 0, sigma) ~ X1 + X2 + X3)$coefficients %*% x_full      
    )
model_reduced <-
    replicate(
        nsim,
        lm(EY + rnorm(n, 0, sigma) ~ X1)$coefficients %*% x_reduced
    )
{% endhighlight %}

The true conditional mean for our data point based our model:

{% highlight r %}
actual_mu <- x_full %*% c(b0, b1, b2, b3)   
> actual_mu
      [,1]
[1,] 3.154
{% endhighlight %}

And based on the model mean, we will simulate `nsim` data points for error comparisons with our predictions:

{% highlight r %}
data <- rnorm(nsim, actual_mu, sigma)   

err_full <- data - model_full
err_reduced <- data - model_reduced
err_true <- data - actual_mu

> sqrt(mean(err_full^2))
[1] 1.519184
> sqrt(mean(err_reduced^2))
[1] 1.152797
> sqrt(mean(err_true^2))
[1] 0.201023
{% endhighlight %}

We can see the true actual mean give a RMSE (Root-Mean-Square Deviation) of 0.2 which is essentially the same as what we specified earlier. So there is no surprise there. We can see the full model has a higher error deviation while the reduced model suprisingly has a lower error deviation.

But by looking at the standard deviation of the model prediction:

{% highlight r %}
sd(model_full)
[1] 1.506697
> sd(model_reduced) 
[1] 1.04741
{% endhighlight %}

The reduced model standard deviation is clearly lower. This is the high bias low variance tradeoff we are getting.

Plotting the histogram predictions:

{% highlight r %}
par(mfrow = c(2, 1))

hist(model_full, xlim = c(-2, 8), main = "Predicted Y using Full Model")
abline(v = actual_mu, lwd = 2, col = "red")

hist(model_reduced, xlim = c(-2, 8), main = "Predicted Y using Reduced Model")      
abline(v = actual_mu, lwd = 2, col = "red")

par(mfrow = c(1, 1))
{% endhighlight %}

![](/assets/img/selection1.png)

We can see the reduced model is biased but has a lower variation.

And now plotting the error histogram:

{% highlight r %}
par(mfrow = c(3, 1))

hist(data - model_full, xlim = c(-6, 6), main = "Full Model Prediction Errors")
hist(data - model_reduced, xlim = c(-6, 6), main = "Reduced Model Prediction Errors")      
hist(data - actual_mu, xlim = c(-6, 6), main = "True Model Prediction Errors")

par(mfrow = c(1, 1))
{% endhighlight %}

![](/assets/img/selection2.png)

We can see the true model has the smallest standard deviation of about 0.2 while the reduced model has a lower variance but has postive bias errors and lastly the full model is non-biased but has the biggest variance.

As we can see from the above examples, a tradeoff with a little bit of bias reduced the variance of $$\hat{\mu}$$ and if the reduction in variance is enough to justified the increase in bias.

Putting all the variances together for the various model:

{% highlight r %}
> var(model_full)
[1] 2.270136
> mean(err_full^2) 
[1] 2.307921
{% endhighlight %}

$$\begin{aligned}
\sigma_{Y \mid X}^{2} &= 0.2^{2}\\
Bias(\hat{\mu})^{2} &= 0\\
Var(\hat{\mu}) &= 2.270136\\
E[(Y - \hat{\mu})^{2}] &= \sigma_{Y \mid X} + Bias(\hat{\mu}) + Var(\hat{\mu})\\
&= 0.2^{2} + 0 + 2.307921\\
&= 2.307921
\end{aligned}$$

{% highlight r %}
> (mean(model_reduced) - actual_mu)^2   
          [,1]
[1,] 0.1921607
> var(model_reduced)
[1] 1.097068
> mean(err_reduced^2) 
[1] 1.328941
{% endhighlight %}

$$\begin{aligned}
\sigma_{Y \mid X}^{2} &= 0.2^{2}\\
Bias(\hat{\mu})^{2} &= 0.1921607\\
Var(\hat{\mu}) &= 1.097068\\
E[(Y - \hat{\mu})^{2}] &= \sigma_{Y \mid X} + Bias(\hat{\mu}) + Var(\hat{\mu})\\
&= 0.2^{2} + 0.1921607 + 1.097068\\
&= 1.329229
\end{aligned}$$

{% highlight r %}
> (actual_mu - actual_mu)^2  
    [,1]
[1,] 0
> var(actual_mu)
0
> mean(err_true^2)
[1] 0.04041024
{% endhighlight %}

$$\begin{aligned}
\sigma_{Y \mid X}^{2} &= 0.2^{2}\\
Bias(\hat{\mu})^{2} &= 0\\
Var(\hat{\mu}) &= 0\\
E[(Y - \hat{\mu})^{2}] &= \sigma_{Y \mid X} + Bias(\hat{\mu}) + Var(\hat{\mu})\\
&= 0.2^{2} + 0 + 0\\
&= 0.04
\end{aligned}$$

## <a name="info"></a> Information Criteria and Cross-Validation

So we have seen a little increase bias can result in a reduction of variance of the model. But how do we determine which model, full or reduced and how much reduced is better? We do not know the true mean or variance of the distribution, and the data we have at hand might not be representative of the true distribution. However given our idiosyncratic data, we can identity good models based on penalized fit statistics or out-of-sample prediction accuracy.

### AIC and BIC

Akaike's Information Criterion (AIC) is defined as:

$$\begin{aligned}
AIC &= -2ln(L) + 2k\\
\end{aligned}$$

where $$L$$ is the likelihood and $$k$$ is the number of estimated parameters. Note the number of estimated parameters include more than the number of variables in a multiple regression as we shall see later in the example.

We can see the lower the AIC the better the model. AIC penalizes more complicated model by increasing the AIC based on the number of parameters.

Similar to AIC, Bayesian Information Criterion (BIC) is defined as:

$$\begin{aligned}
BIC &= -2ln(L) + kln(n)\\
\end{aligned}$$

Whereas BIC penalizes more than AIC when sample size is larger than 7 as $$ln(8) > 2$$. The reason for this is because as sample size gets larger, it is easier to reject the null hypothesis as the null hypothesis is never exactly true and with a large enough sample size the null hypothesis will always be rejected. However the growth of the penalty term will decrease as sample size increases due to the growth of $$ln(n)$$.

Let's use the earlier example in the bias-variance tradeoff section where we have 3 variables:

{% highlight r %}
set.seed(123)
Y <- EY + rnorm(n, 0, sigma)  

model1 <- lm(Y ~ X1 + X3)
model2 <- lm(Y ~ X2 + X3)
model3 <- lm(Y ~ X2)
{% endhighlight %}

For `model1`, let's compute the AIC and BIC. Note the number of parameters is the number of variables plus the intercept plus the error variance $$\sigma_{Y \mid X}^{2}$$ we are estimating:

{% highlight r %}
> -2 * logLik(model1) + 2 * (2 + 1 + 1)   
'log Lik.' -44.7 (df=4)
> AIC(model1)
[1] -44.7
{% endhighlight %}

Similarly for `model2` and `model3`:

{% highlight r %}
> -2 * logLik(model2) + 2 * (2 + 1 + 1)
'log Lik.' -102 (df=4)
> AIC(model2)
[1] -102

> -2 * logLik(model3) + 2 * (1 + 1 + 1)   
'log Lik.' -103 (df=3)
> AIC(model3)
[1] -103
{% endhighlight %}

As we can see AIC picks `model3` despite `model2` and `model3` being the more complicated models. 

As for BIC:

{% highlight r %}
> -2 * logLik(model1) + log(n) * (2 + 1 + 1)
'log Lik.' -40.7 (df=4)
> BIC(model1)
[1] -40.7

> -2 * logLik(model2) + log(n) * (2 + 1 + 1)   
'log Lik.' -98.3 (df=4)
> BIC(model2)
[1] -98.3

>-2 * logLik(model3) + log(n) * (1 + 1 + 1)
'log Lik.' -100 (df=3)
>BIC(model3)
[1] -100
{% endhighlight %}

And we can see BIC comes to the same conclusion.

In R, we can find the best subsets in one go in the following way:

{% highlight r %}
data <- data.frame(Y, X1, X2, X3)
fits <- leaps::regsubsets(Y ~ X1 + X2 + X3, data = data, nbest = 2^3)     
car::subsets(fits, statistic = "bic")
{% endhighlight %}

![](/assets/img/selection3.png)

Unfortunately `car::subsets` do not support AIC as a statistic. We can see that the plot match with our results.

### Cross-Validation

Next we shall look at cross-validation. In a k-fold cross validation, we will divide the dataset randomly into k different groups randomly and leave out one of the group as test data set and train on the remaining $$k - 1$$ groups. Repeat this $$k$$ times by switching the test set and finally you will get $$k$$ sum of squared prediction errors and add them up to get the final statistic for model selection.

Leave-one-out (LOOCV) cross-validation like its name suggests, only leave a point out for test data and train on the remaining $$n - 1$$ data points. 

Using the `DAAG::CVlm` in R, we can quickly carried out k-fold cross-validation. Let's begin with 5-folds:

{% highlight r %}
res <- DAAG::CVlm(
    data = data,
    form.lm = formula(Y ~ X1 + X3),  
    m = 5,
    plotit = FALSE
)
{% endhighlight %}

We can calculate the out-of-sample RMSE:

{% highlight r %}
sqrt(mean(res$Y - res$cvpred)^2)  
{% endhighlight %}

To do a LOOCV, we would just need to assign $$k$$ to be the num of rows:

{% highlight r %}
res <- DAAG::CVlm(
    data = data,
    form.lm = formula(Y ~ X1 + X3),   
    m = nrow(data),
    plotit = FALSE
)
{% endhighlight %}

Now let's compare the same three models using cross-validations using 5-folds cross-validation:

{% highlight r %}
res <- DAAG::CVlm(
    data = data,
    form.lm = formula(Y ~ X1 + X3), 
    m = 5,
    plotit = FALSE
)
> sqrt(mean(res$Y - res$cvpred)^2)
[1] 0.0193

res <- DAAG::CVlm(
    data = data,
    form.lm = formula(Y ~ X2 + X3),
    m = 5,
    plotit = FALSE
)
> sqrt(mean(res$Y - res$cvpred)^2)
[1] 0.00557

res <- DAAG::CVlm(
    data = data,
    form.lm = formula(Y ~ X2),
    m = 5,
    plotit = FALSE
)
> sqrt(mean(res$Y - res$cvpred)^2)    
[1] 0.000359
{% endhighlight %}

We can see the cross-validation matched with our AIC and BIC results.

In fact it can be shown that AIC is asymptotically equivalent to LOOCV and BIC is equivalent to leave-x-out cross validation where $$x = n(1 - \frac{1}{log(n) - 1})$$. Furthermore, cross-validation statistic can be easily retrieved from the hat matrix for linear regression:

$$\begin{aligned}
\mathbf{H} &= \mathbf{(X^{T}X)^{-1}X^{T}Y}\\
CV &= \frac{1}{n}\sum_{i = 1}^{n}\bigg(\frac{e_{i}}{1 - h_{i}}\bigg)^{2}\\
\end{aligned}$$

Where $$h_{i}$$ is the ith diagonal element of the hat matrix. Please see more info in Hyndman's [post](https://robjhyndman.com/hyndsight/crossvalidation/)

In conclusion, no matter which one you choose for model selection, it is still based on your idiosyncratic data. Getting another set of data will likely result in a different model and you will never get the best model.

## <a name="stepwise"></a>Stepwise Regression

When the number of variables beome very large, it is not feasible to fit each and every model. For example, if there are 100 variables, there is a total of $$2^{100} = 1.27 \times 10^30$$ possible subsets. A more practical way would be to use stepwise regression.

With forward selection, we first fit all k single variable regression $$Y = X_{i}$$ and select the variable that fits the best in terms of a chosen model fit criterion and repeating the process until none improves the model to a statistically significant level.

With backward elimination, we start out with all k variables and eliminate the variable that best fit the chosen model fit criterion. We will go on to repeat on the remaining variables until none improves the model to a statistically significant level.

Backward elimination is preferred in the sense that when deleting a variable,  multicollinearity is considered whereas in forward selection, adding a variable is not.

In R, `leaps::regsubsets` can be used to performed stepwise regression as we shall demostrate below.

Using forward selection:

{% highlight r %}
fits <- leaps::regsubsets(
    Y ~ X1 + X2 + X3,
    data = data,
    method = c("forward")
)
car::subsets(fits, statistic = "bic")   
{% endhighlight %}

![](/assets/img/selection4.png)

Using backward selection:

{% highlight r %}
fits <- leaps::regsubsets(
    Y ~ X1 + X2 + X3,
    data = data,
    method = c("backward")
)
car::subsets(fits, statistic = "bic")   
{% endhighlight %}

![](/assets/img/selection5.png)

In this example, both forward and backward selections agree with the best model.
