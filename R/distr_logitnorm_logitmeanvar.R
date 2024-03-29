
# LOGIT-NORMAL DISTRIBUTION / LOGIT-MEAN-VARIANCE PARAMETRIZATION


# Parameters Function ----------------------------------------------------------
distr_logitnorm_logitmeanvar_parameters <- function(n) {
  group_of_par_names <- c("logitvar", "logitvar")
  par_names <- c("logitvar", "logitvar")
  par_support <- c("real", "positive")
  res_parameters <- list(group_of_par_names = group_of_par_names, par_names = par_names, par_support = par_support)
  return(res_parameters)
}
# ------------------------------------------------------------------------------


# Density Function -------------------------------------------------------------
distr_logitnorm_logitmeanvar_density <- function(y, f) {
  t <- nrow(f)
  m <- f[, 1, drop = FALSE]
  s <- f[, 2, drop = FALSE]
  res_density <- be_silent(stats::dnorm(log(y / (1 - y)), mean = m, sd = sqrt(s)))
  return(res_density)
}
# ------------------------------------------------------------------------------


# Log-Likelihood Function ------------------------------------------------------
distr_logitnorm_logitmeanvar_loglik <- function(y, f) {
  t <- nrow(f)
  m <- f[, 1, drop = FALSE]
  s <- f[, 2, drop = FALSE]
  res_loglik <- be_silent(stats::dnorm(log(y / (1 - y)), mean = m, sd = sqrt(s), log = TRUE))
  return(res_loglik)
}
# ------------------------------------------------------------------------------


# Mean Function ----------------------------------------------------------------
distr_logitnorm_logitmeanvar_mean <- function(f) {
  t <- nrow(f)
  m <- f[, 1, drop = FALSE]
  s <- f[, 2, drop = FALSE]
  k <- 1000L
  q <- stats::qnorm((1:(k - 1)) / k, mean = m, sd = sqrt(s))
  res_mean <- 1 / (k - 1) * sum(1 / (1 + exp(-q)))
  return(res_mean)
}
# ------------------------------------------------------------------------------


# Variance Function ------------------------------------------------------------
distr_logitnorm_logitmeanvar_var <- function(f) {
  t <- nrow(f)
  m <- f[, 1, drop = FALSE]
  s <- f[, 2, drop = FALSE]
  k <- 1000L
  q <- stats::qnorm((1:(k - 1)) / k, mean = m, sd = sqrt(s))
  res_var <- 1 / (k - 1) * sum(1 / (1 + exp(-q))^2) - (1 / (k - 1) * sum(1 / (1 + exp(-q))))^2
  res_var <- array(res_var, dim = c(t, 1, 1))
  return(res_var)
}
# ------------------------------------------------------------------------------


# Score Function ---------------------------------------------------------------
distr_logitnorm_logitmeanvar_score <- function(y, f) {
  t <- nrow(f)
  m <- f[, 1, drop = FALSE]
  s <- f[, 2, drop = FALSE]
  res_score <- matrix(0, nrow = t, ncol = 2L)
  res_score[, 1] <- (log(y / (1 - y)) - m) / s
  res_score[, 2] <- (log(y / (1 - y)) - m)^2 / (2 * s^2) - 1 / (2 * s)
  return(res_score)
}
# ------------------------------------------------------------------------------


# Fisher Information Function --------------------------------------------------
distr_logitnorm_logitmeanvar_fisher <- function(f) {
  t <- nrow(f)
  m <- f[, 1, drop = FALSE]
  s <- f[, 2, drop = FALSE]
  res_fisher <- array(0, dim = c(t, 2L, 2L))
  res_fisher[, 1, 1] <- 1 / s
  res_fisher[, 2, 2] <- 1 / (2 * s^2)
  return(res_fisher)
}
# ------------------------------------------------------------------------------


# Random Generation Function ---------------------------------------------------
distr_logitnorm_logitmeanvar_random <- function(t, f) {
  m <- f[1]
  s <- f[2]
  res_random <- be_silent(1 / (1 + exp(-stats::rnorm(t, mean = m, sd = sqrt(s)))))
  res_random <- matrix(res_random, nrow = t, ncol = 1L)
  return(res_random)
}
# ------------------------------------------------------------------------------


# Starting Estimates Function --------------------------------------------------
distr_logitnorm_logitmeanvar_start <- function(y) {
  ly_mean <- mean(log(y / (1 - y)), na.rm = TRUE)
  ly_var <- stats::var(log(y / (1 - y)), na.rm = TRUE)
  m <- ly_mean
  s <- max(ly_var, 1e-6)
  res_start <- c(m, s)
  return(res_start)
}
# ------------------------------------------------------------------------------


