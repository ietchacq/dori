dori_weights <- function(pr, ps, vars) {

  weights <- rep(1, length(pr))  # default weight = 1

  for (v in unique(vars)) {

    idx <- which(vars == v)
    gap <- pr[idx] - ps[idx]

    # identify overrepresented category
    k_over <- idx[which.max(gap)]

    # if no positive overrepresentation → leave all weights = 1
    if (gap[which.max(gap)] <= 0) next

    # complementary category (binary variable ⇒ single value)
    k_other <- setdiff(idx, k_over)

    weights[k_over] <- 1 + (
      (pr[k_over] - ps[k_over]) -
        (pr[k_other] - ps[k_other])
    )
  }

  return(weights)
}
