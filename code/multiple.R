set.seed(123)
temp <- rnorm(100, 30, 5)
icecream <- 100 + 0.5 * temp + rnorm(100, 0, 3)
drowning <- 0 + 1 * temp + rnorm(100, 0, 5)

fit <- lm(icecream ~ temp)
plot(temp, icecream)
abline(fit, col = "red")
summary(fit)

fit <- lm(drowning ~ temp)
plot(temp, drowning)
abline(fit, col = "red")
summary(fit)

fit <- lm(drowning ~ icecream)
plot(icecream, drowning)
abline(fit, col = "red")
summary(fit)

fit <- lm(drowning ~ icecream + temp)
summary(fit)
fit$coefficients

plot(temp, icecream)

f <- function(x, y) {
  fit$coefficients["(Intercept)"] + x * fit$coefficients["temp"] + y * fit$coefficients["icecream"]
}

f2 <- function(x, y) {
  rep(30, length(x))
}


fit$coefficients

rgl::plot3d(
    f,
    xlim = c(15, 45),
    ylim = c(105, 125),
    xlab = "Temperature",
    ylab = "Icecream",
    zlab = "Drowning",
    alpha = 0.5
)
rgl::plot3d(temp, icecream, drowning, type = "p", add = TRUE, col = "blue")

rgl::planes3d(1, 0, 0, -30, col = "red", alpha = 0.6)

rgl::plot3d(temp, icecream, drowning,
    type = "p", col = "blue",
    xlim = c(15, 45),
    ylim = c(105, 125),
    xlab = "Temperature",
    ylab = "Icecream",
    zlab = "Drowning"
)

coefs  <- coef(fit)

rgl::open3d()

rgl::writeWebGL("~/Downloads/temp", width = 700)

rgl::rglwidget(elementId = "temp")
