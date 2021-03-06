% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_ebb_prop_test.R
\name{add_ebb_prop_test}
\alias{add_ebb_prop_test}
\title{Add columns representing a per-observation proportion test}
\usage{
add_ebb_prop_test(tbl, threshold, alternative = c("greater", "less"),
  sort = FALSE, approx = FALSE)
}
\arguments{
\item{tbl}{A table that includes .alpha1 and .beta1 parameters for each
observation, typically returned from \code{\link{add_ebb_estimate}} or
from \code{augment}.}

\item{threshold}{The proportion to which each observation is compared.}

\item{alternative}{Alternative hypothesis. For example, if the alternative
is "greater", the PEP will be the posterior probability that the true
value is lower than the threshold.}

\item{sort}{Optionally, whether to sort the table in order of ascending
posterior error probability.}

\item{approx}{Whether to use a normal approximation to the beta. Used
only when comparing to another beta.}
}
\description{
Run on the result of \code{\link{add_ebb_estimate}}, or of \code{augment}
on an ebb_prior object from \code{ebb_fit_prior}. This adds columns with the
posterior error probability (PEP) and the qvalue.
}
\examples{

library(dplyr)
set.seed(2017)

obs <- 1000
dat <- data_frame(prob = rbeta(obs, 10, 40),
                  total = round(rlnorm(obs, 6, 2)) + 1,
                  x = rbinom(obs, total, prob))

eb <- add_ebb_estimate(dat, x, total)

add_ebb_prop_test(eb, .25)
add_ebb_prop_test(eb, .25, sort = TRUE)
add_ebb_prop_test(eb, .3, sort = TRUE)
add_ebb_prop_test(eb, .4, sort = TRUE)

# comparing the actual p to the posterior probability
# that p is under .25
library(ggplot2)

ggplot(add_ebb_prop_test(eb, .25), aes(prob, .pep, color = log10(total))) +
  geom_point() +
  geom_vline(xintercept = .25, color = "red", lty = 2)

}

