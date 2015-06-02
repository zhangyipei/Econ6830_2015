# Lecture 3

Zhentao Shi

6/3/2015

Monte Carlo simulation has been widely used for

* check the finite-sample performance of asymptotic theory
* generate non-standard distribution (MCMC)
* approximate integrals with no analytical expression (SMM)

### A Teaser

example: estimate pi

```
n = 2 * 1000000
r = 0.5
Z = matrix( ( runif(n)-0.5 ) , ncol = 2 )

inside = mean(  sqrt( rowSums( Z^2 ) )  <=  r )
pi_hat = inside / r^2

print(pi_hat)
```

### Finite Sample Performance

Example: check the significance test of the OLS estimator.

Question: Is the asymptotic theory valid when X follows a Cauchy distribution?

```
# steps
# 1. given sample size, get OLS b_hat and its t_value
# 2. wrap the t_value so that we can replicate for many many times
# 3. give sample size, report the size under two distributions
# 4. wrap it over different sample sizes.
# 5. add comments and documentation

rm(list = ls( ) )
library(plyr)
# set.seed(999)


# set the parameters

Rep = 2000
b0 = matrix(1, nrow = 2 )
df = 1

# the workhorse functions

MonteCarlo = function(X, n, type = "Normal", df = df){
  # a function gives the t-value under the null
  if (type == "Normal"){
    e = rnorm(n)
  } else if (type == "T"){
    e = rt(n, df )
  }
  
  X = cbind( 1, rcauchy(n) )
  Y = X %*% b0 + e
  rm(e)
  
  bhat = solve( t(X) %*% X, t(X)%*% Y )
  bhat2 = bhat[2] # parameter we want to test
  
  e_hat = Y - X %*% bhat
  sigma_hat_square = sum(e_hat^2)/ (n-2)
  sig_B = solve( t(X) %*% X  ) * sigma_hat_square
  t_value_2 = ( bhat2 - b0[2]) / sqrt( sig_B[2,2] ) 
  
  return( c(bhat2, t_value_2) )
}

# report the empirical test size
report = function(n){
  # collect the test size from the two distributions
  # this function contains some repeated code, but is OK for such a smply one
  TEST_SIZE = rep(0,3)
  
  Res = ldply( .data = 1:Rep, .fun = function(i) MonteCarlo(X, n, "Normal")  )
  names(Res) = c("bhat2", "t_value")
  TEST_SIZE[1] = mean( abs(Res$t_value) > qt(.975, n-2) )  
  TEST_SIZE[2] = mean( abs(Res$t_value) > qnorm(.975) ) 
  
  Res = ldply( .data = 1:Rep, .fun = function(i) MonteCarlo(X, n, "T", df)  )
  names(Res) = c("bhat2", "t_value")
  TEST_SIZE[3] = mean( abs(Res$t_value) > qnorm(.975) )
  
  return(TEST_SIZE)
}


pts0 = Sys.time()
# run the calculation of the empirical sizes for different sample sizes
NN = c(5, 10, 200, 2000)
RES = ldply(.data = NN, .fun = report, .progress = "text" )
names(RES) = c("exact", "normal.asym", "t.asym")
RES$n = NN
RES = RES[, c(4,1:3)] # beautify the results
print(RES)
print( Sys.time() - pts0 )
```

### Markov Chain Monte Carlo

Chernozhukov and Hong (2003): An MCMC approach to classical estimation

##### Metropolis-Hasting algorithm

[Metropolis-Hasting algorithm](http://en.wikipedia.org/wiki/Metropolis%E2%80%93Hastings_algorithm) is a simulation method that generates a random sample of desirable density f(x) over its sample space.

To implement Metropolis-Hasting algorithm in R, I recommend `install.packages("mcmc")`.

Example: use Metropolis-Hasting algorithm to generate a sample of normally distributed observations. 
```
library(mcmc)
h = function(x){ y = -x^2 / 2 } # the log, unnormalized function
out = metrop( obj = h, initial = 0, nbatch = 10000, nspac = 10  )
summary(out)
plot(density(out$batch))
```

##### Laplace-type estimator

If we know the distribution of an extremum estimator, then *asymptotically* the point estimator equals its mean under the quadratic loss function, and equals its median under the absolute-value loss function.

The *Laplace-type estimator* transforms the value of the criterion function of an extremum estimator into a probability weight. In a minimization problem, the smaller is the value of the criterion function, the larger it weighs.

### Simulated Method of Moments

Pakes and Pollard (1989): Simulation and the asymptotics of optimization estimators




