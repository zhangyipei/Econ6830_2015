library(mcmc)

# this example generate a standrad normally distributed sample
# by MH algorithm
h = function(x){ y = -x^2 / 2 } # the log, unnormalized function
out = metrop( obj = h, initial = 0, nbatch = 10000, nspac = 10  )
summary(out)
plot(density(out$batch))
