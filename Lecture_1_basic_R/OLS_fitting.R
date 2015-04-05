# Zhentao Shi. 4/6/2015

# an example to check the OLS fitting

rm(list = ls( ) )
set.seed(111)


# set the parameters
n = 100
b0 = matrix(1, nrow = 2 )

# generate the data
e = rnorm(n)
X = cbind( 1, rnorm(n) ) # you can try this line. See what is the difference.
Y = X %*% b0 + e

# OLS estimation
bhat = solve( t(X) %*% X, t(X)%*% Y ) 


# plot
plot( y = Y, x = X[,2], xlab = "X", ylab = "Y", main = "regression")
abline( a= bhat[1], b = bhat[2])
abline( a = b0[1], b = b0[2], col = "red")
abline( h = 0, lty = 2)
abline( v = 0, lty = 2)




# calculate the t-value
bhat2 = bhat[2] # parameter we want to test
e_hat = Y - X %*% bhat
sigma_hat_square = sum(e_hat^2)/ (n-2)
sig_B = solve( t(X) %*% X  ) * sigma_hat_square
t_value_2 = ( bhat2 - b0[2]) / sqrt( sig_B[2,2] ) 


