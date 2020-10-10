df <- data.frame(
  response
  = c(
    46, 56, 55, 47,
    54, 55, 51, 56,
    48, 56, 50, 58,
    46, 60, 51, 59,
    51, 53, 53, 55
  ),
  machine =
    as.factor(
      c(
        1, 2, 3, 4,
        1, 2, 3, 4,
        1, 2, 3, 4,
        1, 2, 3, 4,
        1, 2, 3, 4
      )
    ),
  operator =
    as.factor(
      c(
        1, 1, 1, 1,
        2, 2, 2, 2,
        3, 3, 3, 3,
        4, 4, 4, 4,
        5, 5, 5, 5
      )
    )
)

fit <- aov(response ~ machine * operator, data = df)
summary(fit)

summary(aov(response ~ machine + operator, data = df))
summary(aov(response ~ machine * operator, data = df))
df

mu1 <- 100
mu2 <- 110
mu3 <- 130

sigma <- 5
n <- 2

data1 <- rnorm(n, mean = mu1, sd = sigma)
data2 <- rnorm(n, mean = mu2, sd = sigma)
data3 <- rnorm(n, mean = mu3, sd = sigma)
data <- c(data1, data2, data3)

df <- data.frame(
  response = data,
  treatment = as.factor(c(1, 1, 2, 2, 3, 3)),
  gender = as.factor("female")
)

mu1 <- 135
mu2 <- 120
mu3 <- 110

sigma <- 5
n <- 2

data1 <- rnorm(n, mean = mu1, sd = sigma)
data2 <- rnorm(n, mean = mu2, sd = sigma)
data3 <- rnorm(n, mean = mu3, sd = sigma)
data <- c(data1, data2, data3)

df <- rbind(
  df,
  data.frame(
    response = data,
    treatment = as.factor(c(1, 1, 2, 2, 3, 3)),
    gender = as.factor("male")
  )
)

aov(response ~ treatment + gender, data = df)

xbar <- mean(df$response)

a <- length(levels(df$treatment))
b <- length(levels(df$gender))

SS_Treatment <- b * n *
  sum((mean(df$response[df$treatment == 1]) - xbar)^2 +
      (mean(df$response[df$treatment == 2]) - xbar)^2 +
      (mean(df$response[df$treatment == 3]) - xbar)^2)

SS_Gender <- a * n *
  sum((mean(df$response[df$gender == "female"]) - xbar)^2 +
      (mean(df$response[df$gender == "male"]) - xbar)^2)

SS_Error <-
  sum((df$response[df$treatment == 1 & df$gender == "male"] -
       mean(df$response[df$treatment == 1]) -
       mean(df$response[df$gender == "male"]) + xbar)^2) +
  sum((df$response[df$treatment == 2 & df$gender == "male"] -
       mean(df$response[df$treatment == 2]) -
       mean(df$response[df$gender == "male"]) + xbar)^2) +
  sum((df$response[df$treatment == 3 & df$gender == "male"] -
       mean(df$response[df$treatment == 3]) -
       mean(df$response[df$gender == "male"]) + xbar)^2) +
  sum((df$response[df$treatment == 1 & df$gender == "female"] -
       mean(df$response[df$treatment == 1]) -
       mean(df$response[df$gender == "female"]) + xbar)^2) +
  sum((df$response[df$treatment == 2 & df$gender == "female"] -
       mean(df$response[df$treatment == 2]) -
       mean(df$response[df$gender == "female"]) + xbar)^2) +
  sum((df$response[df$treatment == 3 & df$gender == "female"] -
       mean(df$response[df$treatment == 3]) -
       mean(df$response[df$gender == "female"]) + xbar)^2)

SS_Treatment
SS_Gender
SS_Error

aov(response ~ treatment + gender, data = df)

fit <- aov(response ~ treatment + gender, data = df)
fit

summary(fit)

N <- a * b * n
SS_Treatment <-
  (1 / (b * n)) *
  sum(
    sum(df$response[df$treatment == 1])^2,
    sum(df$response[df$treatment == 2])^2,
    sum(df$response[df$treatment == 3])^2
  ) - sum(df$response)^2 / N

SS_Gender <-
  (1 / (a * n)) *
  sum(
    sum(df$response[df$gender == "male"])^2,
    sum(df$response[df$gender == "female"])^2
  ) - sum(df$response)^2 / N

SS_Total <- sum(df$response^2) - sum(df$response)^2 / N
SS_Error <- SS_Total - SS_Treatment - SS_Gender

SS_Treatment
SS_Gender
SS_Error

aov(response ~ treatment + gender, data = df)

fit <- aov(response ~ treatment + gender, data = df)
fit

## With interaction
fit <- aov(response ~ treatment * gender, data = df)
summary(fit)

sum(df$response[df$treatment == 1 & df$gender == "male"])^2 / n

SS_Interaction <-
  sum(sum(df$response[df$treatment == 1 & df$gender == "male"])^2 / n,
      sum(df$response[df$treatment == 2 & df$gender == "male"])^2 / n,
      sum(df$response[df$treatment == 3 & df$gender == "male"])^2 / n,
      sum(df$response[df$treatment == 1 & df$gender == "female"])^2 / n,
      sum(df$response[df$treatment == 2 & df$gender == "female"])^2 / n,
      sum(df$response[df$treatment == 3 & df$gender == "female"])^2 / n) -
  sum(df$response)^2 / N - SS_Treatment - SS_Gender
SS_Interaction

SS_Treatment <-
  (1 / (b * n)) *
  sum(
    sum(df$response[df$treatment == 1])^2,
    sum(df$response[df$treatment == 2])^2,
    sum(df$response[df$treatment == 3])^2
  ) - sum(df$response)^2 / N

SS_Gender <-
  (1 / (a * n)) *
  sum(
    sum(df$response[df$gender == "male"])^2,
    sum(df$response[df$gender == "female"])^2
  ) - sum(df$response)^2 / N

sum(df$response^2) - sum(df$response)^2 / N - SS_Treatment - SS_Gender

SS_Treatment
SS_Gender

fit <- aov(response ~ treatment * gender, data = df)
summary(fit)

interaction.plot(
  df$treatment,
  df$gender,
  df$response,
  type = "b", col = c("red", "blue"),
  pch = c(16, 18),
  ylab = "Response",
  xlab = "Treatment",
  trace.label = "Gender",
  main = "Interaction between Treatment and Gender"
)
