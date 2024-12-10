# A tiny tutorial to exploring Bayesian statistics


# What proportion p of a planet's surface is water?
<<<<<<< HEAD
# Toss a globe 12 times, what do you find?
water <- 7
=======
# Toss a globe 9 times, what do you find?
water <- 5
>>>>>>> e9ed7c218b5f16ad1e5e2dd79299ac6bf25301d5
land <- 4
total_toss <- water + land


# dbinom will give us the probability
# of seeing W waters for any hypothesized p
<<<<<<< HEAD
dbinom(water, size = total_toss, prob = 0.63)
=======
dbinom(water, size = total_toss, prob = 0.2)
>>>>>>> e9ed7c218b5f16ad1e5e2dd79299ac6bf25301d5

# Let's say we have no idea how much water on earth there is,
# so we'd like to
# simulate a range of possibilities
# ranging from p = 0 (all land) to p = 1 (all water)

p_grid <- data.frame(ps = seq(from = 0, to = 1,
                              length.out = 100))
p_grid$likelihoods <- dbinom(water, size = total_toss,
                             prob = p_grid$ps)
head(p_grid)

plot(likelihoods ~ ps, data = p_grid, pch = 19)

# lets update the data
# Let's call sampling A our
# "preliminary data"
# aka our prior

p_grid$prior <- p_grid$likelihoods

# Now we toss the globe 14 more times
water2 <- 7
land2 <- 4
total_toss2 <- water2 + land2


p_grid$new_likelihoods <-
  dbinom(water2, size = total_toss2, prob = p_grid$ps)

p_grid$unstandardized_posterior <- p_grid$prior * p_grid$new_likelihoods
p_grid$posterior <- (p_grid$prior * p_grid$new_likelihoods)/
                    sum(p_grid$unstandardized_posterior)

plot(posterior ~ ps, data = p_grid, pch = 19)


# A small Monte Carlo simulation from McElreath

n_samples <- 1000
p <- rep( NA , n_samples )
p[1] <- 0.5 # start assuming the proportion of water = 0.5
W <- 6 # Observed data: in 9 tosses we got 6 waters
L <- 3 # Observed data: in 9 tosses we got 3 lands

# run a MCMC

for ( i in 2:n_samples ) {
  p_new <- rnorm( 1 , mean = p[i-1] , sd = 0.1 )
  if ( p_new < 0 ) p_new <- abs( p_new )
  if ( p_new > 1 ) p_new <- 2 - p_new
  q0 <- dbinom( W , W+L , p[i-1] )
  q1 <- dbinom( W , W+L , p_new )
  p[i] <- ifelse( runif(1) < q1/q0 , p_new , p[i-1] )
}

hist(p)

# let's break up this loop and see what it says
# The first iteration of the loop is i = 2

# pick a new P from a random distribution, centered on our original p, with sd = 0.1
# Notice that the indicies are referring to step 2, or step 2-1 e.g. p[i-1]
p_new <- rnorm( 1 , p[1] , 0.1 )
if ( p_new < 0 ) p_new <- abs( p_new ) # quick check to make sure p ends up > 0
if ( p_new > 1 ) p_new <- 2 - p_new # quick check to make sure p ends up < 1

# Calculate the likelihood of data given previous p
q0 <- dbinom( W , W+L , p[1] )

# Calculate the likelihood of data given current p
q1 <- dbinom( W , W+L , p_new )

# inspect your q0 and q1. Is the old p or p_new a better fit for the data?
q0
q1

# This is the Markov Chain business:
# We create some probability of either keeping p_old or changing to p_new
p[2] <- ifelse( runif(1) < q1/q0 , p_new , p[i-1] )

# Break this up: If q1 has a higher likelihood, q1/q0 will be > 1.
# Runif will return a number between 0 and 1. If q1 is better,
# that ratio will be greater than runif(1), and so we should keep p_new,
# otherwise, keep p_old.
#



