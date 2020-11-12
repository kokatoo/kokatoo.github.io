x <- seq(-1, 20, 0.1)
y <- exp(0.1 + 0.1 * x + rnorm(length(x), 0, 0.2))

plot(x, y)
fit  <- lm(y ~ x)
abline(fit)

fit_actual <- lm(log(y) ~ x)
points(x, exp(fit_actual$fitted.values), type = "l", col = "red")

lines(spline(x, predict(loess(y ~ x, span = 0.75, family = "gaussian"))))

names(fit)
names(summary(fit))

plot(
    x,
    predict(fit) + rnorm(length(x), 0, summary(fit)$sigma^2),
    ylab = "y",
    main = "Data generated from linear fit"
)

plot(
    x,
    exp(predict(fit_actual) + rnorm(length(x), 0, summary(fit_actual)$sigma)),
    ylab = "y",
    main = "Data generated from exponential fit"
)

mux <- 180
muy <- 180
sx <- 8
sy <- 8
r <- 0.4

x <- seq(150, 200, length = 50)
y <- x
cov_mat <-
  matrix(
    c(sx^2, r * sx * sy,
      r * sx * sy, sy^2),
    nrow = 2
)
pxy <- function(x, y) {
    zx <- (x - mux) / sx
    zy <- (y - muy) / sy
    volume <- 2 * pi * sx * sy * sqrt(1 - r^2)
    kernel <- exp(-.5 * (zx^2 + zy^2 - 2 * r * zx * zy) / (1 - r^2))
    kernel / volume
}
density <- outer(x, y, pxy)
data <- MASS::mvrnorm(n = 10000, mu, cov_mat)
plot(data,
    pch = ".", xlab = "Parent's Height (cm)",
    ylab = "Child's Height (cm)"
)
contour(
  x = x,
  y = y,
  z = density,
  nlevels = 5,
  lwd = 1.6,
  add = TRUE,
  drawlabels = FALSE
)

persp(
    x,
    y,
    density,
    theta = 10, phi = 20, r = 50, d = 0.5, expand = 0.5,
    ticktype = "detailed",
    xlab = "\nX=Parent's Height (cm)", ylab = "\nY=Child's Height (cm)",
    zlab = "\n\np(x,y)", cex.axis = 0.7, cex.lab = 0.7
)

x <- 160:200
y <- x
y_rho <- (muy - r * mux) + r * x
plot(x, y,
    type = "l",
    xlab = "Parent's Height",
    ylab = "Child's Height"
)
points(x, y_rho, type = "l", lty = 2)
abline(h = 180, lty = 3)
arrows(200, 200, 200, 190.5)
arrows(160, 160.5, 160, 168)

muy <- 170
x <- 150:190
y <- x
y_rho <- (muy - r * mux) + r * x
plot(x, y,
     type = "l",
     xlab = "Parent's Height",
     ylab = "Child's Height"
)
points(x, y_rho, type = "l", lty = 2)
abline(h = 170, lty = 3)
arrows(190, 190, 190, 180.5)
arrows(150, 150.5, 150, 155)

muy <- 190
x <- 170:210
y <- x
y_rho <- (muy - r * mux) + r * x
plot(x, y,
    type = "l",
    xlab = "Parent's Height",
    ylab = "Child's Height"
)
points(x, y_rho, type = "l", lty = 2)
abline(h = 190, lty = 3)
arrows(210, 210, 210, 205)
arrows(170, 170.5, 170, 178)

