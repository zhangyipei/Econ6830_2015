load("big150.Rdata")
library(ggplot2)
library(reshape2)


big150_1 = big150[, c("typb",  "b1", "b1_c")]
big150_1 = melt(big150_1, id.vars = "typb", measure.vars = c("b1", "b1_c"))
names(big150_1)[2] = "estimator"

p1 = ggplot(big150_1) 
p1 = p1 + geom_area(stat = "density", alpha = .25, 
                    aes(x = value, fill = estimator),  position = "identity")
p1 = p1 + facet_grid( typb ~ .) 
p1 = p1 + geom_vline(xintercept = 0)
p1 = p1 + theme_bw()
p1 = p1 + theme(strip.text = element_text( size = 16), 
                axis.text = element_text( size = 16))
print(p1)
