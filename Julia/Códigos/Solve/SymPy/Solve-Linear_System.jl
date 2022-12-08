# Inicializando SymPY
using SymPy

# Definindo Variaveis como simbolos
@vars x y z

# linsolve resolve qualquer sistema de expressões linear em termos das variáveis
system = [x + y - 4, x - y + 0]
eq = x + y - 4
vars   = (x,y)
sol    = linsolve(system,vars) 
display(sol)


