using JuMP
using HiGHS

#
model = Model(HiGHS.Optimizer)
 set_silent(model)
 @variable(model, x)
 @variable(model, z)
 @variable(model, y)
 @constraint(model, x + y + z == 4)
 @constraint(model, x - y - z == 0)
 @constraint(model, x + y - z == 2)
 optimize!(model)
 println("  primal solution: x = ",value(x))
 println("  primal solution: y = ",value(y))
 println("  primal solution: z = ",value(z))
