using JuMP
using HiGHS


model = Model(HiGHS.Optimizer)
 @variable(model, x)
 @variable(model, z)
 @variable(model, y)
 @constraint(model, c1, x + y + z == 4)
 @constraint(model, c2, x - y - z == 0)
 @constraint(model, c3, x + y - z == 2)
 print(model)
 optimize!(model)
 value(x)
 value(y)
 shadow_price(c1)
 shadow_price(c2)
