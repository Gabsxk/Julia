#Limpando workspace
# Alt+R

# Inicializar biblioteca de plots
using Plots

# Explanation of push

# Insert single element by the end in a 1d column vector
# Insert more elements will make x bigger
x = [1,2,3]
x₄ = 4
x = push!(x,x₄)
display(x')

# Insert in a Plot require two element x and y, and both rewrite the frist element
# Introduce two other elements will add in x and y, one element in y
p = plot(1)
x = 5
y = 4
display(push!(p,1,x,y))


# Insert in a Plot3d using three element is the same as introducing x, y and z values
# Introduce one more element will add in y, two in x and y, three in x, y and z
p = plot3d(1)
x = 1
y = 2
z = 3
display(push!(p,1,x,y,z))

