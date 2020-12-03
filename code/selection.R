set.seed(123)
nsim <- 10000
n <- 20

covs <-
  diag(c(5, 5, 0.3)) %*%
  matrix(c(1, 0.5, 0.5,
           0.5, 1, 0.5,
           0.5, 0.5, 1), nrow = 3) %*%
  diag(c(5, 5, 0.3))

means <- c(250, 150, 3)
X <- MASS::mvrnorm(n, means, covs)
X1 <- round(X[, 1], 0)
X2 <- round(X[, 2], 0)
X3 <- round(X[, 3], 0)

head(cbind(X1, X2, X3))

b0 <- -0.5
b1 <- 0.02
b2 <- 0.005
b3 <- 0.02
EY <- b0 + b1 * X1 + b2 * X2 + b3 * X3

x_full <- c(1, 140, 160, 2.7)
x_reduced <- c(1, 140)
sigma <- 0.2

model_full <-
    replicate(
        nsim,
        lm(EY + rnorm(n, 0, sigma) ~ X1 + X2 + X3)$coefficients %*% x_full
    )

model_reduced <-
    replicate(
        nsim,
        lm(EY + rnorm(n, 0, sigma) ~ X1)$coefficients %*% x_reduced
    )

head(model_full)
tail(model_reduced)

actual_mu <- x_full %*% c(b0, b1, b2, b3)
actual_mu

data <- rnorm(nsim, actual_mu, sigma)

err_full <- data - model_full
err_reduced <- data - model_reduced
err_true <- data - actual_mu

head(err_full)
head(err_reduced)
head(err_true)

sqrt(mean(err_full^2))
sqrt(mean(err_reduced^2))
sqrt(mean(err_true^2))

sd(model_full)
sd(model_reduced)

var(model_full)
var(model_reduced)

mean(err_true^2)

mean(model_full) - actual_mu
mean(model_reduced) - actual_mu

par(mfrow = c(2, 1))
hist(model_full, xlim = c(-2, 8), main = "Predicted Y using Full Model")
abline(v = actual_mu, lwd = 2, col = "red")
hist(model_reduced, xlim = c(-2, 8), main = "Predicted Y using Reduced Model")
abline(v = actual_mu, lwd = 2, col = "red")
par(mfrow = c(1, 1))

par(mfrow = c(3, 1))
hist(data - model_full, xlim = c(-6, 6), main = "Full Model Prediction Errors")
hist(data - model_reduced, xlim = c(-6, 6), main = "Reduced Model Prediction Errors")
hist(data - actual_mu, xlim = c(-6, 6), main = "True Model Prediction Errors")
par(mfrow = c(1, 1))

set.seed(123)
Y <- EY + rnorm(n, 0, sigma)

model1 <- lm(Y ~ X1 + X3)
model2 <- lm(Y ~ X2 + X3)
model3 <- lm(Y ~ X2)

-2 * logLik(model1) + 2 * (3 + 1 + 1)
AIC(model1)

-2 * logLik(model2) + 2 * (2 + 1 + 1)
AIC(model2)

-2 * logLik(model3) + 2 * (1 + 1 + 1)
AIC(model3)

-2 * logLik(model1) + log(n) * (2 + 1 + 1)
BIC(model1)

-2 * logLik(model2) + log(n) * (2 + 1 + 1)
BIC(model2)

-2 * logLik(model3) + log(n) * (1 + 1 + 1)
BIC(model3)

data <- data.frame(Y, X1, X2, X3)
fits <- leaps::regsubsets(Y ~ X1 + X2 + X3, data = data, nbest = 2^3)
car::subsets(fits, statistic = "bic")

res <- DAAG::CVlm(
    data = data,
    form.lm = formula(Y ~ X1 + X3),
    m = 5,
    plotit = FALSE
)
sqrt(mean(res$Y - res$cvpred)^2)

res <- DAAG::CVlm(
    data = data,
    form.lm = formula(Y ~ X2 + X3),
    m = 5,
    plotit = FALSE
)
sqrt(mean(res$Y - res$cvpred)^2)

res <- DAAG::CVlm(
    data = data,
    form.lm = formula(Y ~ X2),
    m = 5,
    plotit = FALSE
)
sqrt(mean(res$Y - res$cvpred)^2)

fits <- leaps::regsubsets(
    Y ~ X1 + X2 + X3,
    data = data,
    method = c("backward")
)
car::subsets(fits, statistic = "bic")
