x <- seq(-1, 1, 0.1)
y <- x^2
plot(x, y, type = "l", ylim = c(-0.2, 1))
secant <- function(x1, x2, fn) {
  t <- seq(1, 0, -0.05)
  y <- t * fn(x1) + (1 - t) * fn(x2)
  x <- seq(x1, x2, length = length(t))
  points(x, y, type = "l", col = "red")
}
fn <- function(x) {
  x * x
}
fn_prime <- function(x) {
    2 * x
}
secant(-0.5, 1, fn)
c <- 0.5
points(x, fn(c) + fn_prime(c) * (x - c), type = "l", col = "blue")
legend(
  "bottomright",
  c("secant", "tangent"),
  col = c("red", "blue"),
  cex = 0.8,
  lty = 1
)


x <- seq(0.1, 10, 0.1)
y <- log(x) + rnorm(length(x), 0, 0.6)
fit <- lm(y ~ x)
plot(x, y)
abline(fit, col = "red")

fit <- lm(y ~ log(x))
plot(log(x), y)
abline(fit, col = "red")

predict(fit, data.frame(x = 1))

plot(x, y)

b0 <- fit$coefficients[1]
b1 <- fit$coefficients[2]
y_hat <- b0 + b1 * log(x)
points(x, y_hat, type = "l", col = "red")

predict(fit, data.frame(x = 1))


cols <- viridis::viridis(6)

plot(x,
    log(x) + 1,
    type = "l",
    ylim = c(-4, 4),
    ylab = "E(Y | X = x)",
    col = cols[1],
    main = "b0 + b1 * ln(x)")
points(x,
    0.1 * log(x) + 1,
    type = "l",
    col = cols[2]
)
points(x,
    -1 * log(x) + 1,
    type = "l",
    col = cols[3]
)
points(x,
    -0.1 * log(x) + 1,
    type = "l",
    col = cols[4]
)
legend(
    x = 8,
    y = -1.5,
    c("b0 = 1.0, b1 = 1.0", "b0 = 1.0, b1 = 0.1", "b0 = 1.0, b1 = -1.0", "b0 = 1.0, b1 = -0.1"),
    col = cols,
    cex = 0.8,
    lty = 1
)

x <- seq(0.1, 10, 0.1)
x_inv <- x^-1
y <- x_inv + rnorm(length(x), 0, 0.6)
fit <- lm(y ~ x)
plot(x, y)
abline(fit, col = "red")

x_inv <- x^-1
fit <- lm(y ~ x_inv)
plot(x_inv, y)
abline(fit, col = "red")

plot(x, y)
points(x, fit$fitted.values, type = "l", col = "red")

plot(x,
    1 + x^-1,
    type = "l",
    ylim = c(-1, 3),
    ylab = "E(Y | X = x)",
    col = cols[1],
    main = "b0 + b1 * x^-1"
)
points(x,
    1 + 0.1 * x^-1,
    type = "l",
    col = cols[2]
)
points(x,
    1 + -1 * x^-1,
    type = "l",
    col = cols[3]
)
points(x,
    1 + -0.1 * x^-1,
    type = "l",
    col = cols[4]
)
legend(
    x = 8,
    y = 0,
    c("b0 = 1.0, b1 = 1.0", "b0 = 1.0, b1 = 0.1", "b0 = 1.0, b1 = -1.0", "b0 = 1.0, b1 = -0.1"),
    col = cols,
    cex = 0.8,
    lty = 1
)


set.seed(123)
x <- seq(0.1, 3, 0.1)
y <- exp(x + rnorm(length(x), 0, 0.6))
fit <- lm(y ~ x)
plot(x, y)
abline(fit, col = "red")

fit <- lm(log(y) ~ x)
plot(x, log(y))
abline(fit, col = "red")

plot(x, y)
points(x, exp(fit$fitted.values), type = "l", col = "red")

set.seed(123)
x <- seq(-3, 3, 0.1)
y <- exp(x + rnorm(length(x), 0, 0.6))

plot(x,
    exp(x + 1),
    type = "l",
    ylab = "Median(Y | X = x)",
    ylim = c(0, 10),
    xlim = c(-3, 3),
    col = cols[1],
    main = "exp(b0 + b1 * x)"
)
points(x,
    exp(0.1 * x + 1),
    type = "l",
    col = cols[2]
)
points(x,
    exp(-1 * x + 1),
    type = "l",
    col = cols[3]
)
points(x,
    exp(-0.1 * x + 1),
    type = "l",
    col = cols[4]
    )
legend(
    "topright",
    c("b0 = 1.0, b1 = 1.0", "b0 = 1.0, b1 = 0.1", "b0 = 1.0, b1 = -1.0", "b0 = 1.0, b1 = -0.1"),
    col = cols,
    cex = 0.8,
    lty = 1
)

x <- seq(0, 3, 0.01)
plot(x, dlnorm(x, meanlog = 0, sdlog = 0.25), col = "red", type = "l", ylab = "PDF")
points(x, dlnorm(x, meanlog = 0, sdlog = 0.50), col = "blue", type = "l")
points(x, dlnorm(x, meanlog = 0, sdlog = 1.00), col = "green", type = "l")
legend("topright",
    c("sigma = 0.25, mean = 0", "sigma = 0.5, mean = 0", "sigma = 1, mean = 0"),
    col = c("red", "blue", "green"),
    cex = 0.8,
    lty = 1
)

set.seed(123)
x <- seq(1, 5, 0.1)
y <- 1 / (x + rnorm(length(x), 0, 0.5))
fit <- lm(y ~ x)
plot(x, y)
abline(fit, col = "red")

fit <- lm(1 / y ~ x)
plot(x, 1 / y)
abline(fit, col = "red")

plot(x, y)
points(x, 1 / fit$fitted.values, type = "l", col = "red")

plot(x,
    1 / x + 1,
    type = "l",
    ylim = c(-2, 3),
    ylab = "E(Y | X = x)",
    col = cols[1],
    main = "1/(b0 + b1 * x)"
)
points(x,
    1 / (0.1 * x + 1),
    type = "l",
    col = cols[2]
)
points(x,
    1 / (-1 * x + 1),
    type = "l",
    col = cols[3]
)
points(x,
    1 / (-0.1 * x + 1),
    type = "l",
    col = cols[4]
)
legend(
    "topright",
    c("b0 = 1.0, b1 = 1.0", "b0 = 1.0, b1 = 0.1", "b0 = 1.0, b1 = -1.0", "b0 = 1.0, b1 = -0.1"),
    col = cols,
    cex = 0.8,
    lty = 1
)

fit <- lm(y ~ x)
MASS::boxcox(fit)


set.seed(123)
x <- seq(0, 30, 0.1)
y <- exp(log(x) + rnorm(length(x), 0, 0.6))
fit <- lm(y ~ x)
plot(x, y)
abline(fit, col = "red")

fit <- lm(log(y) ~ log(x))
plot(log(x), log(y))
abline(fit, col = "red")

plot(x, y)
points(x, fit$fitted.values, type = "l", col = "red")

