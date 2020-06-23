# Set Up Variables

Source1 <- data.frame(X = 736.5, Y = -712);
Source2 <- data.frame(X = 846.9, Y = -297.5);

Target1 <- data.frame(X = 3405609.4, Y = 5758870);
Target2 <- data.frame(X = 3406123.7, Y = 5760798);

# Matrix Calculation Notes

## Formular 4.20, 4.21
### X[T] = a[0] + a*X[S] + b*Y[S]
### Y[T] = b[0] - b*X[S] + a*Y[S]

## ↓

## Rearrangement by Factor
###         a[0]    b[0]    a       b
### X[T] =    1       0     X[S]   Y[S]
### Y[T] =    0       1     Y[S]  -X[S]

## ↓

## To Matrix
### Sp = t (S: source, p: parameters, t: target)
###   ↓
### ┌ 1, 0, X[S][1],  Y[S][1] ┐┌a[0]┐   ┌X[T][1]┐
### │ 1, 0, X[S][2],  Y[S][2] ││b[0]│ = │X[T][2]│
### │ 0, 1, Y[S][1], -X[S][1] ││ a  │   │Y[T][1]│
### └ 0, 1, Y[S][2], -X[S][2] ┘└ b  ┘   └Y[T][2]┘

S <- matrix(c(
  1, 1, 0, 0,
  0, 0, 1, 1,
  Source1$X, Source2$X, Source1$Y, Source2$Y,
  Source1$Y, Source2$Y, -Source1$X, -Source2$X
), 4); # Source matrix

t <- c(Target1$X, Target2$X, Target1$Y, Target2$Y); # Target vector

p <- solve(S, t); # Solve equations

# Answer
p;
# [1] 3.402185e+06 5.762183e+06 4.651859e+00 1.772570e-03

a0 <- p[1]; # 3.402185e+06
b0 <- p[2]; # 5.762183e+06
a <- p[3];  # 4.651859e+00
b <- p[4];  # 1.772570e-03

# Create transform function from equation and parameter to test back
transform7 <- function(source, a0, b0, a, b) {
  return(data.frame(
    X = a0 + (a * source$X) + (b * source$Y),
    Y = b0 - (b * source$X) + (a * source$Y)
  ));
};

# Test with given data
TestTarget1 <- transform7(Source1, a0, b0, a, b);
TestTarget2 <- transform7(Source2, a0, b0, a, b);

print(Target1); print(TestTarget1); ## <- Identical
print(Target2); print(TestTarget2); ## <- Identical
