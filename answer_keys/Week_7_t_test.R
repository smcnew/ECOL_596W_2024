# t-test
library(dplyr)
lizards <- read.csv("datasets/HornedLizards.csv")
head(lizards)

living <- lizards$squamosalHornLength[lizards$Survival=="living"]
dead <- lizards %>% filter(Survival == "killed") %>% pull(squamosalHornLength)
living <- na.omit(living)
dead <- na.omit(dead)

# Pooled sample variance
# s2p = df1*(s1)^2 + df2*(s2)^2/ df1 + df2
# s2p = df1*(var1) + df2*(var2)/ df1 + df2
df1 <- length(living) - 1
df2 <- length(dead) -1
var1 <- var(living)
var2 <- var(dead)

s2p <- (df1*var1 + df2*var2)/(df1 + df2)

# Standard error of the two means
# SE = sqrt(s2p(1/n1 + 1 /n2))

n1 <- length(living)
n2 <- length (dead)
SE <- sqrt(s2p* (1/n1 + 1/n2))
#t = (mean1 - mean2)/SE

t <- (mean(living) - mean(dead))/SE
# overall dfs

#pt(t, df, lower.tail = FALSE) Gives us the probability of a value as or more extreme
length(living) +  length(dead) -2
pt(t, df = 182, lower.tail = FALSE)

boxplot(squamosalHornLength ~ Survival, data = lizards)

t.test(living, dead, var.equal = TRUE, alternative = "greater")
t
