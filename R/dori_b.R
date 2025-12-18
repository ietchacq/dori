#' Balanced DORI (vectorized over rows)
#'
#' @param groups matrix with rows = units, columns = categories
#' @param vars vector assigning each column to a variable (e.g., c(1,1,2,2))
#' @return numeric vector of DORI_b values
#' @export
dori_b <- function(groups, vars) {

  groups <- as.matrix(groups)
  n <- nrow(groups)
  out <- numeric(n)

  for (i in seq_len(n)) {

    pr <- groups[i, ]
    sq <- pr^2

    # sum within each identity variable
    sums_by_var <- tapply(seq_along(sq), vars, function(idx) {
      sum(sq[idx])
    })

    V <- length(unique(vars))

    out[i] <- 1 - (sum(unlist(sums_by_var)) / V)
  }

  return(out)
}
