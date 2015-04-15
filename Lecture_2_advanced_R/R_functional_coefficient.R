
require(Matrix)
require(plyr)
require(MASS)

n <- 100
k <- 2

### data generating process                 
y <- rnorm(n, mean = 0, sd = 1)  # n by 1
x <- rnorm(n, mean = 0, sd = 1)
y <- matrix(y,n,1)               # assign numbers as matrix
x <- matrix(x,n,1)
x <- cbind(1,x)                  # n by k
z <- rnorm(n,mean = 0, sd = 1)
z <- matrix(z,n,1)

## kernel density function
kfunction <- function(u)  k<- 15*(7*u^4-10*u^2+3)*(abs(u)<=1)/32

## bandwith choice

T <- nrow(y)
d <- 1
sd_z <- sd(z)
h <- d*sd_z*T^(-1/3)


## kernel estimator for functional-coefficient cointegration
skfunction <- function(u)  sk <- kfunction(u)^2
VK <- integrate(skfunction,-Inf,Inf)$value        # third component

# this function estimate the coefficient and the corresponding variance all together
kernel <- function(z.fix){
  weight <- matrix(0, nrow = n, ncol = n)
  diag(weight) <- kfunction( (z - z.fix ) / h ) 
  beta.hat.z <- ginv( t(x) %*% weight %*% x) %*% ( t(x) %*% weight %*% y  ) # est the coefficient
  
  uhat.z <- y - x %*% beta.hat.z
  sigmau.z <- mean( uhat.z^2 )
  fz.z <- 1/(n^2 * h ) * t(x) %*% weight %*% x # est the 
  estcov.z <- diag( sigmau.z * VK * ginv( fz.z  ) )
  
  return( c(beta.hat.z, estcov.z)  )
}

est <- laply(.data = z, .fun = kernel   )
beta1 <- est[ , 1:k]
estcov1 <- est[ , (k+1):(2*k)]
