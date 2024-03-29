% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/main_distr.R
\name{distr_fisher}
\alias{distr_fisher}
\title{Compute Fisher Information}
\usage{
distr_fisher(f, distr, param = NULL, par_link = NULL, trans = NULL)
}
\arguments{
\item{f}{Parameters. For the same parameters for all observations, a numeric vector. For individual parameters for each observation, a numeric matrix with rows corresponding to observations.}

\item{distr}{A distribution.}

\item{param}{A parametrization of the distribution.}

\item{par_link}{An optional logical vector indicating whether the logarithmic/logistic link should be applied to restricted parameters in order to obtain unrestricted values. Defaults to keeping the original link for all parameters.}

\item{trans}{An optional transformation of the Fisher information. The supported transformations are the inverse of the Fisher information (\code{trans = "inv"}) and the inverse square root of the Fisher information (\code{trans = "inv_sqrt"}).}
}
\value{
The (transformed) Fisher information.
}
\description{
A function computing Fisher information, its inverse, or its inverse square root for a given distribution.
}
\examples{
# Fisher information for the negative binomial distribution
distr_fisher(f = c(13.50, 0.03), distr = "negbin")

}
\seealso{
\code{\link[gasmodel:distr]{distr()}}
}
