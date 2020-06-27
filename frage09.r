sim.a0 <- 3.402185e+06
sim.b0 <- 5.762183e+06
sim.a <- 4.651859e+00
sim.b <- 1.772570e-03

aff.a0 <- 3.402234e+06
aff.b0 <- 5.762169e+06
aff.a1 <- 4.598353e+00
aff.b1 <- 1.360743e-02
aff.a2 <- 1.602370e-02
aff.b2 <- 4.647763e+00

transform7 <- function(source, a0, b0, a, b) {
  return(data.frame(
    X = a0 + (a * source$X) + (b * source$Y),
    Y = b0 - (b * source$X) + (a * source$Y)
  ));
};

transform8 <- function(source, a0, b0, a1, b1, a2, b2) {
  return(data.frame(
    X = a0 + (a1 * source$X) + (a2 * source$Y),
    Y = b0 + (b1 * source$X) + (b2 * source$Y)
  ));
};

source <- data.frame(X = 456.8, Y = -278.5);

target.sim <- transform7(source, sim.a0, sim.b0, sim.a, sim.b);
target.aff <- transform8(source, aff.a0, aff.b0, aff.a1, aff.b1, aff.a2, aff.b2);

target.sim;
target.aff;
# Similarity: 3404309, 5760887
# Affine:     3404330, 5760881
