set.seed(123)

x1 <- rnorm(100, 0, 1)
x2 <- rnorm(100, 0, 1)
y <- x1 + x1^2 + x2 + x2^2

x1_seq <- seq(-3, 3, length = 100)
x2_seq <- seq(-3, 3, length = 100)

fit <- lm(y ~ x1 + I(x1^2) + x2 + I(x2^2))
f <- function(x1, x2) {
  fit$coefficients["(Intercept)"] +
    x1 * fit$coefficients["x1"] +
    x1^2 * fit$coefficients["I(x1^2)"] +
    x2 * fit$coefficients["x2"] +
    x2^2 * fit$coefficients["I(x2^2)"]
}
rgl::plot3d(
    f,
    xlim = c(-3, 3),
    ylim = c(-3, 3),
    zlim = c(-20, 20),
    xlab = "x1",
    ylab = "x2",
    zlab = "z",
    alpha = 0.5
)

x1 <- seq(-3, 3, length = 100)
x2 <- seq(-3, 3, length = 100)

f <- function(x1, x2) {
  x1 + x2 + x1 * x2
}

rgl::plot3d(
    f,
    xlim = c(-3, 3),
    ylim = c(-3, 3),
    zlim = c(-20, 20),
    xlab = "x1",
    ylab = "x2",
    zlab = "z",
    alpha = 0.5
)

f <- function(x1, x2) {
    x1 + x1^2 - x2 - x2^2
}
rgl::surface3d(x1, x2, outer(x1, x2, f), col = "red", alpha = 0.6)

f <- function(x1, x2) {
    -x1 - x1^2 - x2 - x2^2
}
rgl::surface3d(x1, x2, outer(x1, x2, f), col = "blue", alpha = 0.6)


set.seed(123)
x <- rnorm(100, 2, 0.5)
y <- 5 * x - 0.1 * x^2 + rnorm(100, 0, 1)

fit_inclusion <- lm(y ~ x + I(x^2))
fit_exclusion <- lm(y ~ I(x^2))

f_inclusion <- function(x) {
    fit_inclusion$coefficients["(Intercept)"] +
      x * fit_inclusion$coefficients["x"] +
      x^2 * fit_inclusion$coefficients["I(x^2)"]
}
f_exclusion <- function(x) {
    fit_exclusion$coefficients["(Intercept)"] +
      x^2 * fit_exclusion$coefficients["I(x^2)"]
}

plot(x, y)
x_seq <- seq(-1, 5, 0.1)
lines(x_seq, f_inclusion(x_seq), col = "red")
lines(x_seq, f_exclusion(x_seq), col = "blue")

summary(fit_inclusion)
summary(fit_exclusion)
