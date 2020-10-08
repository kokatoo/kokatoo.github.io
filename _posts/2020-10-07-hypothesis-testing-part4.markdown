---
layout: post
title: "Hypothesis Testing (Part 4) Two-way ANOVA"
date: 2020-10-07 03:30:06 +0800
img : interaction1.png
categories:
---

Today we will continue with part 4 of the Hypothesis Testing series on Factorial ANOVA. If you haven't checked out part 3 please check it out [here]({% post_url 2020-10-06-hypothesis-testing-part3 %})

## Part 4: Two-way ANOVA (Factorial Design)

Let's introduce another independent variable into our analysis. One common variable in treatment analysis is gender.

We will simulate score marks for three different exams and determine whether are there any differences in the scores among the 3 exams and across gender.

### Two-way ANOVA with no interaction

In our first example, we will simulate the following mean scores for each exams and they are the same across gender. Also for each exam, there will be `n = 2` males and `n = 2` females giving a total of 4 participants per exam.

{% highlight r %}
mu1 <- 100
mu2 <- 110
mu3 <- 130

sigma <- 5
n <- 2

data1 <- rnorm(n, mean = mu1, sd = sigma)
data2 <- rnorm(n, mean = mu2, sd = sigma)
data3 <- rnorm(n, mean = mu3, sd = sigma)
data <- c(data1, data2, data3)

df <- data.frame(
  response = data,
  treatment = as.factor(c(1, 1, 2, 2, 3, 3)),
  gender = as.factor("female")
)

data1 <- rnorm(n, mean = mu1, sd = sigma)
data2 <- rnorm(n, mean = mu2, sd = sigma)
data3 <- rnorm(n, mean = mu3, sd = sigma)
data <- c(data1, data2, data3)

df <- rbind(
  df,
  data.frame(
    response = data,
    treatment = as.factor(c(1, 1, 2, 2, 3, 3)),    
    gender = as.factor("male")
  )
)
{% endhighlight %}

Next we will compute the sum of squares of treatment and gender with assumption of no interaction. The equations are shown below with `a and b` equal to the number of levels of each independent variables.

{% highlight r %}
a <- length(levels(df$treatment))   
b <- length(levels(df$gender))
{% endhighlight %}

$$SS_{Treatment} = b * \sum_{i = 1}^{a}({\bar{X}_{i.}} - \bar{X})^{2}$$

$$SS_{Gender} = a * \sum_{j = 1}^{b}(\bar{X}_{.j} - \bar{X})^{2}$$

$$SS_{Error} = \sum_{i = 1}^{a}\sum_{j = 1}^{b}(X_{ij} - \bar{X}_{i.j} - \bar{X_{.j}} + \bar{X})^{2}$$

{% highlight r %}
SS_Treatment <- b * n *
  sum((mean(df$response[df$treatment == 1]) - xbar)^2 +
      (mean(df$response[df$treatment == 2]) - xbar)^2 +
      (mean(df$response[df$treatment == 3]) - xbar)^2)

SS_Gender <- a * n *
  sum((mean(df$response[df$gender == "female"]) - xbar)^2 +
      (mean(df$response[df$gender == "male"]) - xbar)^2)

SS_Error <-
  sum((df$response[df$treatment == 1 & df$gender == "male"] -
       mean(df$response[df$treatment == 1]) -
       mean(df$response[df$gender == "male"]) + xbar)^2) +
  sum((df$response[df$treatment == 2 & df$gender == "male"] -
       mean(df$response[df$treatment == 2]) -
       mean(df$response[df$gender == "male"]) + xbar)^2) +
  sum((df$response[df$treatment == 3 & df$gender == "male"] -
       mean(df$response[df$treatment == 3]) -
       mean(df$response[df$gender == "male"]) + xbar)^2) +
  sum((df$response[df$treatment == 1 & df$gender == "female"] -       
       mean(df$response[df$treatment == 1]) -
       mean(df$response[df$gender == "female"]) + xbar)^2) +
  sum((df$response[df$treatment == 2 & df$gender == "female"] -
       mean(df$response[df$treatment == 2]) -
       mean(df$response[df$gender == "female"]) + xbar)^2) +
  sum((df$response[df$treatment == 3 & df$gender == "female"] -
       mean(df$response[df$treatment == 3]) -
       mean(df$response[df$gender == "female"]) + xbar)^2)

+ SS_Treatment
+ SS_Gender
+ SS_Error
+ 
> [1] 2746.404
> [1] 0.7474466
> [1] 113.5051
{% endhighlight %}

Let's compare the result with `aov()` in R:

{% highlight r %}
fit <- aov(response ~ treatment + gender, data = df)
> fit
Call:
   aov(formula = response ~ treatment + gender, data = df)     

Terms:
                treatment    gender Residuals
Sum of Squares  2746.4043    0.7474  113.5051
Deg. of Freedom         2         1         8

Residual standard error: 3.766715
Estimated effects may be unbalanced
{% endhighlight %}

We can see the calculation match R's `aov()`. Let's see the summary:

{% highlight r %}
> summary(fit)
            Df Sum Sq Mean Sq F value   Pr(>F)    
treatment    2 2746.4  1373.2  96.785 2.48e-06 ***     
gender       1    0.7     0.7   0.053    0.824    
Residuals    8  113.5    14.2                
---
{% endhighlight %}

We can see only the `treatment` is significant which is what we expected. To calculate the F value manually, we find the mean square for each main effects and divide by the mean square error.

$$MS_{Treatment} = \frac{SS_{Treatment}}{a - 1}$$

$$MS_{Gender} = \frac{SS_{Gender}}{b - 1}$$

$$MS_{Error} = \frac{SS_{Error}}{(a - 1)(b - 1)}$$

Now let's try making `Gender` significant by giving the female gender a higher score with the following distribution for males:

{% highlight r %}
mu1 <- 100
mu2 <- 110  
mu3 <- 130
{% endhighlight %}

And the following for females:

{% highlight r %}
mu1 <- 110
mu2 <- 120  
mu3 <- 135
{% endhighlight %}

For this example, we will use a different way to calculate sum of squares. As you probably know variance can be calculated using expectation:

$$\begin{aligned}
Var(X) &= \mathbb{E}[(X - \mathbb{E}[X])^{2}]\\
&= \mathbb{E}[(X - \mathbb{E}[X])^{2}]\\
&= \mathbb{E}[X^{2} - 2X\mathbb{E}[X] + \mathbb{E}[X]^{2}]\\
&= \mathbb{E}[X^{2}] - 2\mathbb{E}[X]\mathbb{E}[X] + \mathbb{E}[X]^{2}\\
&= \mathbb{E}[X^{2}] - \mathbb{E}[X]^{2}\\
\end{aligned}$$

Note that the 3rd `.` is the number of samples per cell. In this example, `n = 2`.

$$SS_{Treatment} = \frac{1}{(bn)}\sum_{i = 1}^{a}X_{i..}^{2} - \frac{\sum_{}^{}X_{...}^{2}}{N}$$

$$SS_{Gender} = \frac{1}{(an)}\sum_{i = 1}^{b}X_{.j.}^{2} - \frac{\sum_{}^{}X_{...}^{2}}{N}$$

$$SS_{Total} = \sum_{i = 1}^{a}\sum_{j = 1}^{b}X_{ij.}^{2} - \frac{\sum_{}^{}X_{...}^{2}}{N}$$

$$SS_{Error} = SS_{Total} - SS_{Treatment} - SS_{Gender}$$

{% highlight r %}
N <- a * b * n
SS_Treatment <-
  (1 / (b * n)) *
  sum(
    sum(df$response[df$treatment == 1])^2,
    sum(df$response[df$treatment == 2])^2,
    sum(df$response[df$treatment == 3])^2
  ) - sum(df$response)^2 / N

SS_Gender <-
  (1 / (a * n)) *
  sum(
    sum(df$response[df$gender == "male"])^2,
    sum(df$response[df$gender == "female"])^2
  ) - sum(df$response)^2 / N

SS_Total <- sum(df$response^2) - sum(df$response)^2 / N      
SS_Error <- SS_Total - SS_Treatment - SS_Gender

+ SS_Treatment
+ SS_Gender
+ SS_Error
+ 
> [1] 1188.548
> [1] 254.4206
> [1] 243.1734
{% endhighlight %}

Let's check it with `aov()` in R:

{% highlight r %}
fit <- aov(response ~ treatment + gender, data = df)
> summary(fit)
            Df Sum Sq Mean Sq F value   Pr(>F)    
treatment    2 1188.5   594.3   19.55 0.000832 ***
gender       1  254.4   254.4    8.37 0.020103 *  
Residuals    8  243.2    30.4                           
---
{% endhighlight %}

We can see now that `Gender` is significant.

So far we have assumed there is no interaction between the 2 independent variables. In fact, the sum of squares for interaction is included in the sum of squares for error. It's time to partition that out.

$$\begin{aligned}
SS_{Treatment, Gender} &= \sum_{i = 1}^{a}\sum_{j = 1}^{b}\frac{X_{ij.}^{2}}{n} - \frac{\sum_{}^{}X_{...}^{2}}{N} - SS_{Treatment} - SS_{Gender}
\end{aligned}$$

For the interaction example, we will the following distribution for males:

{% highlight r %}
mu1 <- 100
mu2 <- 110  
mu3 <- 130
{% endhighlight %}

And the following for females:

{% highlight r %}
mu1 <- 135
mu2 <- 120  
mu3 <- 110
{% endhighlight %}

Calculating sum of squares for interaction:

{% highlight r %}
SS_Interaction <-
  sum(sum(df$response[df$treatment == 1 & df$gender == "male"])^2 / n,
      sum(df$response[df$treatment == 2 & df$gender == "male"])^2 / n,
      sum(df$response[df$treatment == 3 & df$gender == "male"])^2 / n,
      sum(df$response[df$treatment == 1 & df$gender == "female"])^2 / n,
      sum(df$response[df$treatment == 2 & df$gender == "female"])^2 / n,
      sum(df$response[df$treatment == 3 & df$gender == "female"])^2 / n) -     
  sum(df$response)^2 / N - SS_Treatment - SS_Gender
> SS_Interaction
[1] 1984.545
{% endhighlight %}

Let's check with `aov()` in R:

{% highlight r %}
fit <- aov(response ~ treatment * gender, data = df)
> summary(fit)

                 Df Sum Sq Mean Sq F value   Pr(>F)    
treatment         2   85.6    42.8   4.701  0.05912 .  
gender            1  192.2   192.2  21.102  0.00372 ** 
treatment:gender  2 1984.5   992.3 108.940 1.92e-05 ***
Residuals         6   54.7     9.1                         
---
{% endhighlight %}

We can see the sum of squares match and the interaction effect is significant. We can also plot the `interaction.plot` to have a better picture:

{% highlight r %}
interaction.plot(
  df$treatment,
  df$gender,
  df$response,
  type = "b", col = c("red", "blue"),
  pch = c(16, 18),
  ylab = "Response",
  xlab = "Treatment",
  trace.label = "Gender",
  main = "Interaction between Treatment and Gender"
)
{% endhighlight %}

![](/assets/img/interaction1.png)

With higher-order factorial designs, variation among groups are broken down into main effects for each independent variables, two-way interaction between each pair of independent variables, three-way among each trio, and etc. Similar to two-way factorial design, error sum o fsquares is the snum of squared differences within each cell.

In Part 5, we will explore Random and Mixed Models . Stay tuned!
