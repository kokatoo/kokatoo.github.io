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

SS_Group
SS_Within
SS_Total
SS_Group + SS_Within
fscore
1 - pf(fscore, df1 = k - 1, df2 = N - k)

k <- 3
N <- n * k

fscore <- (SS_Group / (k - 1)) / (SS_Within / (N - k))
fscore

x <- seq(0, 8, length = 100)
probs <- df(x, df2 = N - k, df1 = k - 1)
plot(x, probs, type = "l", main = "F Distribution")
abline(v = fscore, col = "red")

df <- data.frame(response = data,
                 treatment = as.factor(c(1, 1, 1, 2, 2, 2, 3, 3, 3)))

fit <- aov(response ~ treatment, data = df)
summary(fit)

mu1 <- 100
mu2 <- 100
mu3 <- 100
sigma <- 5
n <- 3

data1 <- rnorm(n, mean = mu1, sd = sigma)
data2 <- rnorm(n, mean = mu2, sd = sigma)
data3 <- rnorm(n, mean = mu3, sd = sigma)
data <- c(data1, data2, data3)
df <- data.frame(response = data,
                 treatment = as.factor(c(1, 1, 1, 2, 2, 2, 3, 3, 3)))

fit <- aov(response ~ treatment, data = df)
summary(fit)

mu1 <- 100
mu2 <- 105
mu3 <- 110
n <- 10

data1 <- rnorm(n, mean = mu1, sd = 10)
data2 <- rnorm(n, mean = mu2, sd = 10)
data3 <- rnorm(n, mean = mu3, sd = 30)
data <- c(data1, data2, data3)
df <- data.frame(response = data, treatment = as.factor(c(1, 1, 1, 2, 2, 2, 3, 3, 3)))

fit <- aov(response ~ treatment, data = df)
summary(fit)

