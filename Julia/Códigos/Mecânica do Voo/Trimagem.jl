using JuMP
using Ipopt

# Condições de voo
v   = 100;         # velocidade [m/s]
rho = 1.225;       # densidade do alpha [kg/m^3] 
q   = 0.5*rho*v^2; # pressão dinâmica [kg/(m*s^2)]

# Comprimento da Aeronave
cmp  = 2.0;          # comprimento da aeronave [m]

# Asas
bw         = 1.6;           # envergadura [m]
cw         = 0.5;           # corda [m]
xew        = cw*(0.48/100); # localização do eixo elastico [m]
xcaw       = (1/4)*cw;      # centro de pressão/centro aerodinâmico da asa [m]
sw         = bw*cw;         # area da asa [m^2]
cl_alpha_w = 2*pi;          # coeficiente de sustentação da asa (Aerofólio fino)

# Estabilizador Horizontal
bh         = 0.6;              # envergadura [m]
ch         = 0.4;              # corda [m]
xeh         = ch*(0.48/100);   # localização do eixo elastico [m]
xcah       = (1/4)*ch;         # centro aerodinâmico relativo ao bordo de ataque do estabilizador horizontal [m]
xcah_xcaw  = cmp-ch+xcah-xcaw; # centro aerodinâmico relativo ao centro de gravidade [m]
sh         = bh*ch;            # area do estabilizador horizontal [m^2]
cl_alpha_h = cl_alpha_w;       # coeficiente de sustentação do Estabilizador Horizontal

# Profundor
bp          = 0.6;            # envergadura [m]
cep         = 0.1;            # corda [m]
xep         = cep*(0.48/100); # localização do eixo elastico [m]
xcaep       = (1/4)*cep;      # centro aerodinâmico [m]
sp          = bp*cep;         # area do profundor [m^2]
cl_delta_e  = cl_alpha_w;     # coeficiente de sustentação da asa

# Efetividade do Profundor
ae = cl_delta_e*(sh/sw);      # Segundo Bibliografia     

# Forças (Condição de voo reto e nivelado)
W   = 300; # peso da aeronave [N]
L   = W;   # sustentação da aeronave [N]

# Equações
model = Model(Ipopt.Optimizer)
 set_silent(model)
 @variable(model, alpha)
 @variable(model, delta_e)
 @variable(model, Lw)
 @variable(model, Lh)
 @variable(model, x_NP)
 @variable(model, x_cg)
 @NLconstraint(model, cl_alpha_w*alpha*q*sw - Lw == 0) # Sustenação produzida pela asa
 @NLconstraint(model, cl_alpha_h*alpha*q*sh + cl_delta_e*sh*q*delta_e - Lh == 0) # Sustentação produzida pela empenagem horizontal
 @NLconstraint(model, Lw + Lh - 300 == 0) # Somatório de forças em Y
 @NLconstraint(model, Lw*(x_cg-xcaw)-Lh*(cmp-ch+xcah-xcaw-(x_cg-xcaw)) == 0) # Somatório de momentos no CG
 @NLconstraint(model, (x_NP/cw)-(x_cg/cw) - 0.1 == 0) # Margem Estática
 @NLconstraint(model, -(x_NP/cw) + (xcaw/cw) + (((cmp-ch+xcah-xcaw-(x_cg-xcaw))*sh)/(cw*sw)) * (cl_alpha_h)/(cl_alpha_w + (sh/sw)*cl_alpha_h) == 0) # Equação da posição do ponto neutro relativo ao centro aerodinamico segundo bibliografia
 optimize!(model)

# Forças
lw = value(Lw);
lh = value(Lh);
lt = lw + lh - 300;
println("O valor de Sustentação da asa é:", lw,"\n");
println("O valor de Sustentação da Empenagem Horizontal é: ",lh,"\n")
println("O valor de Sustentação resultante é: ",lt,"\n")

# Equação de Momento
mw  = value(Lw)*(value(x_cg)-xcaw);                  # momento produzido pela força de sustentação na asa [Nm]
mp  = value(Lh)*(cmp-ch+xcah-xcaw-(value(x_cg)-xcaw));  # momento produzido pela força de sustentação na asa [Nm]
mt  = mw - mp;
println("O valor de Momento de Sustentação da asa é: ",mw,"\n")
println("O valor da Momento de Sustentação da Empenagem Horizontal é: ",mp,"\n")
println("O valor de Momento Resultante no Centro de Gravidade é ", mt," que é aproximadamente 0. \n")

# Angulos
ALPHA   = rad2deg(value(alpha));
DELTA_E = rad2deg(value(delta_e));
println("O valor do angulo de ataque:",ALPHA,"\n")
println("O valor do angulo do profundor é:",DELTA_E,"\n")

# Posições
println("A localização do Centro de Gravidade é:",value(x_cg),"\n")
println("A localização do Ponto Neutro é:",value(x_NP));
