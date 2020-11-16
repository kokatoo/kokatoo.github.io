set.seed(123)
x1 <- rnorm(100)
x2 <- x1 + rnorm(100, 0, 1)
plot(x1, x2)
abline(h = 0)
abline(v = 0)
abline(v = 1)
segments(-3, -3, 3, 3)

z <- x1 + x2 + rnorm(100, 0, 0.5)
fit <- lm(z ~ x1 + x2)

f <- function(x, y) {
    fit$coefficients["(Intercept)"] + x * fit$coefficients["x1"] + y * fit$coefficients["x2"]
}

rgl::plot3d(x1, x2, z,
    type = "p", col = "blue",
    xlab = "x1",
    ylab = "x2",
    zlab = "z"
)
