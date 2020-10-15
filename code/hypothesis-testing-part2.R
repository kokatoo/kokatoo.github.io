## dependent
corr <- 0.9
cov.mat <-
  matrix(
    c(1, corr,
      corr, 1),
    nrow = 2)

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
  data1 <- rnorm(n * 2, 0, 1)
  data2 <- rnorm(n * 2, 0, 1)
  mu1 <- mean(data1)
  mu2 <- mean(data3)
  diffs <- c(mu1 - mu2, diffs)
}
length(diffs[abs(diffs) > 1.96 * sqrt(2 * 1 / (n * 2))])

## non-identical distribution
set.seed(123)
data1 <- rnorm(1000, 1, 1)
data2 <- rnorm(1000, 3, 1)
data3 <- c(data1, data2)
variance <- var(data3)
diffs <- c()
n <- 8
for(i in 1:100) {
  mu1 <- mean(c(sample(data1, n-1, TRUE), sample(data2, 1, TRUE)))
  #mu1 <- mean(sample(data3, n, TRUE))
  mu2 <- mean(sample(data3, n, TRUE))
  diffs <- c(mu1 - mu2, diffs)
}
length(diffs[abs(diffs) > 1.96 * sqrt(2 * variance / n)])

set.seed(1234)
sigma1 <- 5
sigma2 <- 1
n1 <- 5
n2 <- 25
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
length(diffs)

plot_dists <- function(fun, fun2, mu, sigma) {
  x <- mu + seq(-4, 6, length = 100) * sigma / sqrt(n)
  plot(x, fun(x), ylab = "Probs", type = "l", main = "Null vs Alternate Distribution")
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

pwr::pwr.t.test(
  d = (mu1 - mu0) / sigma,
  sig.level = 0.05,
  type = "one.sample",
  alternative = "greater",
  n = n
)

1 - pt((alpha_pt - mu1) * sqrt(n) / sigma, df = n - 1)

## increase power
mu0 <- 100
mu1 <- 110
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

mu0 <- 100
mu1 <- 108
sigma <- 10
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

mu0 <- 100
mu1 <- 108
sigma <- 15
n <- 50

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
