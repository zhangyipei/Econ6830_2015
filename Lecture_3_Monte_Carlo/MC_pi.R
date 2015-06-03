n = 2 * 10000000
r = 0.5
Z = matrix( ( runif(n)-0.5 ) , ncol = 2 )

inside = mean(  sqrt( rowSums( Z^2 ) )  <=  r )
pi_hat = inside * 4

print(pi_hat)
