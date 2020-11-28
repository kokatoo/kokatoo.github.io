set.seed(123)
group1 <- rnorm(10, 3, 0.1)
group2 <- rnorm(10, 3.5, 0.5)

data <-
    data.frame(
        group = c(
            rep(0, length(group1)),
            rep(1, length(group2))
        ),
        data = c(group1, group2)
    )

plot(data$group, data$data, xlab = "Group", ylab = "Y")
fit <- lm(data$data ~ data$group)
abline(fit)

summary(fit)
confint(fit)

t.test(group2, group1, var.equal = TRUE)

mean(group1)
fit$coefficients["(Intercept)"]

mean(group2)
fit$coefficients["(Intercept)"] + fit$coefficients["data$group"]


set.seed(123)
group1 <- rnorm(10, 3, 0.1)
group2 <- rnorm(10, 3.5, 0.5)
group3 <- rnorm(10, 4, 0.3)

data <-
    data.frame(
        group = factor(c(
            rep(1, length(group1)),
            rep(2, length(group2)),
            rep(3, length(group3))
        )),
        data = c(group1, group2, group3)
    )
fit <- lm(data$data ~ data$group)

summary(fit)

mean(group1)
fit$coefficients["(Intercept)"]

mean(group2)
fit$coefficients["(Intercept)"] + fit$coefficients["data$group2"]

mean(group3)
fit$coefficients["(Intercept)"] + fit$coefficients["data$group3"]

summary(aov(data$data ~ data$group))

TukeyHSD(aov(data$data ~ data$group))

summary(fit)

pairwise.t.test(data$data, data$group, p.adj = "none")

aov(data$data ~ data$group)

set.seed(123)
x1 <- rnorm(10, 3, 0.1)
x2 <- rnorm(10, 3, 0.1)
x <- c(x1, x2)
data <-
    data.frame(
        group = c(
            rep(0, length(x1)),
            rep(1, length(x2))
        ),
        x = x,
        y = c(2 * x1 + rnorm(10, 0, 0.2), -2 * x2 + 11 + rnorm(10, 0, 0.2))
    )


plot(
    data$x[1:10], data$y[1:10],
    xlab = "X",
    ylab = "Y",
    col = "red",
    ylim = c(4.5, 6.5),
    xlim = c(2.8, 3.2)
)
points(data$x[11:20], data$y[11:20], col = "blue")

plot(data$x, data$y)

fit <- lm(y ~ x + group, data = data)
abline(
    fit$coefficients["(Intercept)"],
    fit$coefficients["x"],
    col = "red"
)
abline(
    fit$coefficients["(Intercept)"] + fit$coefficients["group"],
    fit$coefficients["x"],
    col = "blue"
)

fit <- lm(y ~ x + group + x * group, data = data)
abline(
    fit$coefficients["(Intercept)"],
    fit$coefficients["x"],
    col = "red"
)
abline(
    fit$coefficients["(Intercept)"] + fit$coefficients["group"],
    fit$coefficients["x"] + fit$coefficients["x:group"],
    col = "blue"
)

summary(lm(y ~ x + group, data = data))
summary(lm(y ~ x + group + x * group, data = data))

anova(
    lm(y ~ x + group, data = data),
    lm(y ~ x + group + x * group, data = data)
)

set.seed(123)
male_classA <- rnorm(10, 3, 0.1)
male_classB <- rnorm(10, 3.5, 0.1)
male_classC <- rnorm(10, 3.5, 0.2)
female_classA <- rnorm(10, 3.5, 0.1)
female_classB <- rnorm(10, 4, 0.2)
female_classC <- rnorm(10, 4.5, 0.2)

data <-
    data.frame(
        sex = factor(c(
            rep("M", 30),
            rep("F", 30)
        )),
        class = factor(c(
            rep("A", 10), rep("B", 10), rep("C", 10),
            rep("A", 10), rep("B", 10), rep("C", 10)
        )),
        y = c(
            male_classA, male_classB, male_classC,
            female_classA, female_classB, female_classC
        )
    )

fit <- lm(y ~ sex + class + sex * class, data = data)
summary(fit)

interaction.plot(
    data$class,
    data$sex,
    predict(fit, data[c("sex", "class")]),
    pch = c(16, 18),
    ylab = "Y",
    xlab = "Class",
    trace.label = "Sex",
    main = "Interaction between Class and Sex"
)

fit <- lm(y ~ sex + class, data = data)
summary(fit)

interaction.plot(
    data$class,
    data$sex,
    predict(fit, data[c("sex", "class")]),
    pch = c(16, 18),
    ylab = "Y",
    xlab = "Class",
    trace.label = "Sex",
    main = "Interaction between Class and Sex"
)

anova(
    lm(y ~ sex + class, data = data),
    lm(y ~ sex + class + sex * class, data = data)
)

anova(
    lm(y ~ 1, data = data),
    lm(y ~ class, data = data),
    lm(y ~ sex + class, data = data),
    lm(y ~ sex + class + sex * class, data = data)
)

anova(
    lm(y ~ 1, data = data),
    lm(y ~ sex, data = data),
    lm(y ~ sex + class, data = data),
    lm(y ~ sex + class + sex * class, data = data)
)


set.seed(123)
x1 <- seq(10, 20, 0.5)
y1 <- x1 + rnorm(length(x1), 0, 2)
x2 <- seq(21, 30, 0.5)
y2 <- 0.5 * x2 + rnorm(length(x2), 0, 2)
x <- c(x1, x2)
y <- c(y1, y2)
plot(x, y)

indicator <- ifelse(x < 20, 0, 1)
fit <- lm(y ~ x + indicator + x * indicator)
summary(fit)

abline(
    fit$coefficients["(Intercept)"],
    fit$coefficients["x"],
    col = "red"
)

abline(
    fit$coefficients["(Intercept)"] + fit$coefficients["indicator"],
    fit$coefficients["x"] + fit$coefficients["x:indicator"],
    col = "blue"
)

set.seed(123)
x1 <- seq(10, 20, 0.5)
y1 <- 0.1 * x1 + rnorm(length(x1), 0, 1)
x2 <- seq(21, 30, 0.2)
y2 <- x2 + rnorm(length(x2), 0, 2) - 18
x <- c(x1, x2)
y <- c(y1, y2)
plot(x, y)

indicator <- ifelse(x < 20, 0, 1)
x2 <- x * indicator - 20 * indicator
fit <- lm(y ~ x + x2)

abline(
    fit$coefficients["(Intercept)"],
    fit$coefficients["x"],
    col = "red"
)

abline(
    fit$coefficients["(Intercept)"] +  fit$coefficients["x2"] * -20,
    fit$coefficients["x"] + fit$coefficients["x2"],
    col = "blue"
)
