#Limpando workspace
# Alt+R

# Inicializar biblioteca de plots
using LaTeXStrings
using Plots

#Tema dos Plots
theme(:dark)

#Primeiro Plot - Usar display ao final para impressão
x = 10 .^ range(0, 4, length=100)
y = @. 1/(1+x)

plot(x, y, label=L"\frac{1}{1+x}")
plot!(xscale=:log10, yscale=:log10, minorgrid=true)
xlims!(1e+0, 1e+4)
ylims!(1e-5, 1e+0)
title!(L"Log-log plot of $\frac{1}{1+x}$")
xlabel!(L"x")
display(ylabel!(L"y"))


#Segundo Plot - Usar display ao final para impressao
x = range(0, 10, length=100)
y = sin.(x)
y_noisy = @. sin(x) + 0.1*randn()

plot(x, y, label="sin(x)", lc=:black, lw=2)
scatter!(x, y_noisy, label="data", mc=:red, ms=2, ma=0.5)
plot!(legend=:bottomleft)
title!("Sine with noise")
xlabel!("x")
ylabel!("y")
