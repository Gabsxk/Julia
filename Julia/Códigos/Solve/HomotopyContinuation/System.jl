# load the package
using HomotopyContinuation
# declare variables x and y
@var x y
# define the polynomials
f₁ = (x^4 + y^4 - 1) * (x^2 + y^2 - 2) + x^5 * y
f₂ = x^2+2x*y^2 - 2y^2 - 1/2
F = System([f₁, f₂])
result = solve(F)
real_solutions(result)
