#' Weighted DORI (fully automatic, user-friendly)
#'
#' @param groups matrix of legislature proportions (one row per unit)
#' @param groups_soc matrix of population proportions (one row per unit)
#' @param vars variable assignment, e.g. c(1,1,2,2)
#'
#' @return numeric vector of DORI_w values
#' @export
dori_w <- function(groups, groups_soc, vars) {

  groups      <- as.matrix(groups)
  groups_soc  <- as.matrix(groups_soc)

  n <- nrow(groups)
  out <- numeric(n)

  for (i in seq_len(n)) {

    pr <- groups[i, ]
    ps <- groups_soc[i, ]

    # compute weights for this row
    w <- dori_weights(pr, ps, vars)

    # compute weighted DORI just like manual code
    sq           <- pr^2
    weighted_sq  <- sq * w

    sums_by_var <- tapply(seq_along(weighted_sq), vars, function(idx) {
      sum(weighted_sq[idx])
    })

    V <- length(unique(vars))

    out[i] <- 1 - (sum(unlist(sums_by_var)) / V)
  }

  return(out)
}
