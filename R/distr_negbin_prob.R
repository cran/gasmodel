
# NEGATIVE BINOMIAL DISTRIBUTION / PROBABILISTIC PARAMETRIZATION


# Parameters Function ----------------------------------------------------------
distr_negbin_prob_parameters <- function(n) {
  group_of_par_names <- c("prob", "size")
  par_names <- c("prob", "size")
  par_support <- c("probability", "positive")
  res_parameters <- list(group_of_par_names = group_of_par_names, par_names = par_names, par_support = par_support)
  return(res_parameters)
}
# ------------------------------------------------------------------------------


# Density Function -------------------------------------------------------------
distr_negbin_prob_density <- function(y, f) {
  t <- nrow(f)
  p <- f[, 1, drop = FALSE]
  r <- f[, 2, drop = FALSE]
  res_density <- be_silent(stats::dnbinom(y, prob = p, size = r))
  return(res_density)
}
# ------------------------------------------------------------------------------


# Log-Likelihood Function -------------------------------------------------------------
distr_negbin_prob_loglik <- function(y, f) {
  t <- nrow(f)
  p <- f[, 1, drop = FALSE]
  r <- f[, 2, drop = FALSE]
  res_loglik <- be_silent(stats::dnbinom(y, prob = p, size = r, log = TRUE))
  return(res_loglik)
}
# ------------------------------------------------------------------------------


# Mean Function ----------------------------------------------------------------
distr_negbin_prob_mean <- function(f) {
  t <- nrow(f)
  p <- f[, 1, drop = FALSE]
  r <- f[, 2, drop = FALSE]
  res_mean <- r * (1 - p) / p
  return(res_mean)
}
# ------------------------------------------------------------------------------


# Variance Function ------------------------------------------------------------
distr_negbin_prob_var <- function(f) {
  t <- nrow(f)
  p <- f[, 1, drop = FALSE]
  r <- f[, 2, drop = FALSE]
  res_var <- r * (1 - p) / p^2
  res_var <- array(res_var, dim = c(t, 1, 1))
  return(res_var)
}
# ------------------------------------------------------------------------------


# Score Function ---------------------------------------------------------------
distr_negbin_prob_score <- function(y, f) {
  t <- nrow(f)
  p <- f[, 1, drop = FALSE]
  r <- f[, 2, drop = FALSE]
  res_score <- matrix(0, nrow = t, ncol = 2L)
  res_score[, 1] <- (r * p + p * y - r) / (p^2 - p)
  res_score[, 2] <- log(p) - digamma(r) + digamma(y + r)
  return(res_score)
}
# ------------------------------------------------------------------------------


# Fisher Information Function --------------------------------------------------
distr_negbin_prob_fisher <- function(f) {
  t <- nrow(f)
  p <- f[, 1, drop = FALSE]
  r <- f[, 2, drop = FALSE]
  res_fisher <- array(0, dim = c(t, 2L, 2L))
  res_fisher[, 1, 1] <- r / (p^2 * (1 - p))
  res_fisher[, 1, 2] <- -1 / p
  res_fisher[, 2, 1] <- res_fisher[, 1, 2]
  res_fisher[, 2, 2] <- (log(p) - digamma(r) + digamma(r * (1 - p) / p + r))^2
  return(res_fisher)
}
# ------------------------------------------------------------------------------


# Random Generation Function ---------------------------------------------------
distr_negbin_prob_random <- function(t, f) {
  p <- f[1]
  r <- f[2]
  res_random <- be_silent(stats::rnbinom(t, prob = p, size = r))
  res_random <- matrix(res_random, nrow = t, ncol = 1L)
  return(res_random)
}
# ------------------------------------------------------------------------------


# Starting Estimates Function --------------------------------------------------
distr_negbin_prob_start <- function(y) {
  y_mean <- mean(y, na.rm = TRUE)
  y_var <- stats::var(y, na.rm = TRUE)
  p <- max(min(y_mean / y_var, 1 - 1e-6), 1e-6)
  r <- max(y_mean^2 / (y_var - y_mean), 1e-6)
  res_start <- c(p, r)
  return(res_start)
}
# ------------------------------------------------------------------------------


