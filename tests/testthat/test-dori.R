# -----------------------------------------------------------
# Test A — DORI_b matches example in paper (p. 9)
# -----------------------------------------------------------

test_that("DORI_b matches example in paper", {

  groups <- matrix(c(
    0.5, 0.5,    # gender: women, men
    0.1, 0.9     # race: AA, non-AA
  ), nrow = 1, byrow = TRUE)

  vars <- c(1,1,2,2)

  result <- dori_b(groups, vars)

  # Manual expected: 1 - ((0.25+0.25)+(0.01+0.81))/2 = 0.34
  expect_equal(round(result, 3), 0.340)
})

# -----------------------------------------------------------
# Test B — Only overrepresented category gets weight > 1
# -----------------------------------------------------------

test_that("only the overrepresented category receives weight greater than 1", {

  pr <- c(0.9, 0.1)     # legislature
  ps <- c(0.7, 0.3)     # population
  vars <- c(1,1)

  w <- dori_weights(pr, ps, vars)

  expect_true(w[1] > 1)   # overrepresented category
  expect_equal(w[2], 1)   # underrepresented category stays at 1
})

# -----------------------------------------------------------
# Test C — DORI_w CAN become negative under EXTREME inequality
# -----------------------------------------------------------

test_that("DORI_w can become negative under extreme representational inequality", {

  # Extreme scenario: 99% in legislature, 50% in population
  pr <- c(0.01, 0.99)
  ps <- c(0.50, 0.50)
  vars <- c(1,1)

  groups <- matrix(pr, nrow = 1)
  groups_soc <- matrix(ps, nrow = 1)

  result <- dori_w(groups, groups_soc, vars)

  expect_true(result < 0)
})

# -----------------------------------------------------------
# Test D — No overrepresentation ⇒ all weights = 1
# -----------------------------------------------------------

test_that("weights remain 1 when no group is overrepresented", {

  pr <- c(0.5, 0.5)
  ps <- c(0.5, 0.5)
  vars <- c(1,1)

  w <- dori_weights(pr, ps, vars)

  expect_equal(w, c(1,1))
})

# -----------------------------------------------------------
# Test E — DORI_b = 0 when perfectly homogeneous per variable
# -----------------------------------------------------------

test_that("DORI_b is zero when completely homogeneous on each variable", {

  groups <- matrix(c(
    1, 0,   # gender: 100% one group
    1, 0    # race: 100% one group
  ), nrow = 1, byrow = TRUE)

  vars <- c(1,1,2,2)

  result <- dori_b(groups, vars)

  expect_equal(result, 0)
})

