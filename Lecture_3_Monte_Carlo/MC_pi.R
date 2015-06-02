n = 2 * 1000000
r = 0.5
Z = matrix( ( runif(n)-0.5 ) , ncol = 2 )

inside = mean(  sqrt( rowSums( Z^2 ) )  <=  r )
pi_hat = inside / r^2

print(pi_hat)