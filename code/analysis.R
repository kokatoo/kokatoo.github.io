set.seed(123)
x1 <- rnorm(100)
x2 <- x1 + rnorm(100, 0, 0.1)
plot(x1, x2)
abline(h = 0, col = "red")
abline(v = 0, col = "blue")
abline(v = 1, col = "blue")
segments(-3, -3, 3, 3)
z <- x1 + x2 + rnorm(100, 0, 0.5)
fit <- lm(z ~ x1 + x2)

summary(fit)

f <- function(x, y) {
    fit$coefficients["(Intercept)"] + x * fit$coefficients["x1"] + y * fit$coefficients["x2"]
}

rgl::plot3d(
    f,
    xlim = c(-3, 3),
    ylim = c(-3, 3),
    xlab = "x1",
    ylab = "x2",
    zlab = "z",
    alpha = 0.5
)
rgl::plot3d(x1, x2, z, type = "p", add = TRUE, col = "blue")

rgl::planes3d(0, 1, 0, 0, col = "red", alpha = 0.6)
rgl::planes3d(1, 0, 0, 0, col = "blue", alpha = 0.6)
rgl::planes3d(1, 0, 0, -1, col = "green", alpha = 0.6)

rgl::open3d()

names(summary(lm(x1 ~ x2)))

1 / sqrt(1 - summary(lm(x1 ~ x2))$r.squared)
1 / sqrt(1 - summary(lm(x2 ~ x1))$r.squared)

0.49515 / (1 / sqrt(1 - summary(lm(x2 ~ x1))$r.squared))

