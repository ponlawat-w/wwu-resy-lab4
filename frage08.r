# Set Up Initial Variables

Source1 <- data.frame(X = 736.5, Y = -712);
Source2 <- data.frame(X = 846.9, Y = -297.5);
Source3 <- data.frame(X = 443, Y = -854.5);

Target1 <- data.frame(X = 3405609.4, Y = 5758870);
Target2 <- data.frame(X = 3406123.7, Y = 5760798);
Target3 <- data.frame(X = 3404257.5, Y = 5758203.7);

# Matrix Calculation Notes

## Formular
### X[T] = a[0] + a[1]*X[S] + a[2]*Y[S]
### Y[T] = b[0] + b[1]*X[S] + b[2]*Y[S]

## ↓

## Rearragement by Factor
###         a[0] b[0]   a[1]  b[1]  a[2]  b[2]
### X[T] =    1     0   X[S]     0  Y[S]     0
### Y[T] =    0     1      0  X[S]     0  Y[S]

## ↓

## To Matrix
### Sp = t (S: Source, p: parameters, t: target)
### ↓
### ┌ 1, 0, X[S][1],       0, Y[S][1],       0 ┐┌a[0]┐   ┌X[T][1]┐
### │ 1, 0, X[S][2],       0, Y[S][2],       0 ││b[0]│ = │X[T][2]│
### │ 1, 0, X[S][3],       0, Y[S][3],       0 ││a[1]│   │X[T][3]│
### │ 0, 1,       0, X[S][1],       0, Y[S][1] ││b[1]│   │Y[T][1]│
### │ 0, 1,       0, X[S][2],       0, Y[S][2] ││a[2]│   │Y[T][2]│
### └ 0, 1,       0, X[S][3],       0, Y[S][3] ┘└b[2]┘   └Y[T][3]┘

S <- matrix(c(
  1, 1, 1, 0, 0, 0,
  0, 0, 0, 1, 1, 1,
  Source1$X, Source2$X, Source3$X, 0, 0, 0,
  0, 0, 0, Source1$X, Source2$X, Source3$X,
  Source1$Y, Source2$Y, Source3$Y, 0, 0, 0,
  0, 0, 0, Source1$Y, Source2$Y, Source3$Y
), 6); # Source matrix

t <- c(
  Target1$X,
  Target2$X,
  Target3$X,
  Target1$Y,
  Target2$Y,
  Target3$Y
); # Target vector

p <- solve(S, t); # Solve equations

# Answer
p;
# [1] 3.402234e+06 5.762169e+06 4.598353e+00 1.360743e-02
# [5] 1.602370e-02 4.647763e+00

a0 <- p[1]; # 3.402234e+06
b0 <- p[2]; # 5.762169e+06
a1 <- p[3]; # 4.598353e+00
b1 <- p[4]; # 1.360743e-02
a2 <- p[5]; # 1.602370e-02
b2 <- p[6]; # 4.647763e+00

# Create transform function from equation and parameter to test back
transform8 <- function(source, a0, b0, a1, b1, a2, b2) {
  return(data.frame(
    X = a0 + (a1 * source$X) + (a2 * source$Y),
    Y = b0 + (b1 * source$X) + (b2 * source$Y)
  ));
}

# Test with given data
TestTarget1 <- transform8(Source1, a0, b0, a1, b1, a2, b2);
TestTarget2 <- transform8(Source2, a0, b0, a1, b1, a2, b2);
TestTarget3 <- transform8(Source3, a0, b0, a1, b1, a2, b2);

print(Target1); print(TestTarget1); # <- Indifferent
print(Target2); print(TestTarget2); # <- Indifferent
print(Target3); print(TestTarget3); # <- Indifferent
