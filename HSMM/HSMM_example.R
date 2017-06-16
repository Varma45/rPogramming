library(hsmm)
library(ggplot2)
# Simulation of sequences of observations and hidden states from a 
# 3-state HSMM with a logarithmic runlength distribution and a 
# conditional Gaussian distributions.

### Setting up the parameter values:
# Initial probabilities of the semi-Markov chain:
pipar  <- rep(1/3, 3)
# Transition probabilites:
# (Note: For two states, the matrix degenerates, taking 0 for the 
# diagonal and 1 for the off-diagonal elements.)
tpmpar <- matrix(c(0, 0.5, 0.5,
                   0.7, 0, 0.3,
                   0.8, 0.2, 0), 3, byrow = TRUE)

# Runlength distibution:
rdpar  <- list(p = c(0.98, 0.98, 0.99))

# Observation distribution:
odpar  <- list(mean = c(-1.5, 0, 1.5), var = c(0.5, 0.6, 0.8))

# Invoking the simulation:
sim    <- hsmm.sim(n = 2000, od = "norm", rd = "log", 
                   pi.par = pipar, tpm.par = tpmpar, 
                   rd.par = rdpar, od.par = odpar, seed = 3539)



# Executing the EM algorithm:
fit    <- hsmm(sim$obs, od = "norm", rd = "log", 
               pi.par = pipar, tpm.par = tpmpar, 
               od.par = odpar, rd.par = rdpar)

# The log-likelihood:
fit$logl

# Ehe estimated parameters:
fit$para

# Computation of the smoothing probabilities:
fit.sm <- hsmm.smooth(sim$obs, od = "norm", rd = "log", 
                      pi.par = pipar, tpm.par = tpmpar, 
                      od.par = odpar, rd.par = rdpar)


# Executing the Viterbi algorithm:
fit.vi <- hsmm.viterbi(sim$obs, od = "norm", rd = "log", 
                       pi.par = pipar, tpm.par = tpmpar, 
                       od.par = odpar, rd.par = rdpar)



#plots :
qplot(x=c(1:2000),y=sim$obs,geom = "line",xlab = "Index",ylab = "Simulated observations")
qplot(x=c(1:2000),y=sim$path,geom = "line",xlab = "Index",ylab = "Simulated States")
