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
