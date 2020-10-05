gen_data <- function(fun, mu, sigma, n) {
  sapply(
    1:100,
    function(i) {
      fun(n, mean = mu, sd = sigma)
    }
  )
}

gen_beta_data <- function(shape1, shape2, n) {
  sapply(
    1:100,
    function(i) {
      rbeta(n, shape1, shape2)
    }
  )
}

plot_dist <- function(fun, mu, sigma) {
  x <- mu + seq(-4, 4, length = 100) * sigma
  probs <- fun(x, mean = mu, sd = sigma)
  plot(x, probs, type = "l", main = "Population Distribution")
}

plot_sampling_dist <- function(data) {
  means <- apply(data, 2, mean)
  x <- seq(min(means), max(means), length = 100)
  x <- seq(0, 1, length = 100)
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

calc_t_score <- function(sample, mu) {
  sample_mu <- mean(sample)
  sample_se <- (sd(sample) / sqrt(n))
  (sample_mu - mu) / sample_se
}

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
}

mu <- 100
sigma <- 15
n <- 25

data <- gen_data(rnorm, mu, sigma, n)
plot_dist(dnorm, mu, sigma)
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

data <- gen_data(rnorm, mu, sigma, n)
plot_tdist(n, "")
abline(v = qt(0.95, df = n - 1), lwd = 3)
sleep(3)
for (i in seq_len(ncol(data))) {
  sample <- data[, i]
  tscore <- calc_t_score(sample, mu)
  Sys.sleep(0.1)
  if (tscore > qt(0.95, df = n - 1)) {
    abline(v = tscore, col = "blue")
  }
  else {
    abline(v = tscore, col = "red")
  }
}


mu <- 105
sigma <- 15
n <- 25
sample <- rnorm(n, mean = mu, sd = sigma)
tscore <- calc_t_score(sample, 100)
plot_tdist(tscore)


par(mfrow = c(1, 2))
x <- seq(0, 1, length = 20)
probs <- dbeta(x, 5, 1)
plot(x, probs, type = "l", main = "Population Distribution")
plot_sampling_dist(gen_beta_data(5, 1, n))
