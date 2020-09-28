# sistema

units           real   # <- sistema de unidades reales (roteiro pag. 2 )
atom_style      full   # <- define os atributos de cada atomo (roteiro pag. 2) 
boundary        p p p  # <- condições periodica de contorno em 3D 

# campo de força
pair_style lj/cut/coul/long 10  # <- tipo de interação de lennard-jones + coulomb (roteirio pag. 3) 
bond_style     harmonic         # <- ligação harmônica entre pares de atômos
angle_style    harmonic         # <- ligação angular harmônica entre pares de atômos

pair_modify tail yes            # <- aplicar correções na energia e pressão deevido ao truncamento das interações de longo alcançe  
pair_modify mix arithmetic      # <- aplicar as regras de Lorentz para as interações entre diferentes tipos de atômos

kspace_style pppm 0.0001        # <- aplicar o método particle-particle-particle-mesh para descrever as interações de coulomb 
                                #    de forma eficiente como se trata-se de um campo médio

# leer configuração
read_data      prod_nvt_bulk_water.top  # <- leer o arquivo com as informações da topologia do sistema a 300 K e 1 atm
neighbor       2 bin                    # <- distância adicional na construção da lista de vizinhos de verlet 

timestep        0.5             # <- tempo de integração de dt=1fs (depende do sistema de unidades a escolher)

# selecionar informação termodinâmica
thermo_style custom step temp ke pe etotal press vol density # <- selecionar a informação termodinâmica desejada entre outras
thermo 100                                                   # <- imprimir a cada 100 pasos 

# iniciando a dinâmica molecular
fix production_nvt all nvt temp 300 300 50 # <- ensemble NVT a 300 K 
run 100                        # <- tempo de simulação 5 ps
unfix production_nvt

reset_timestep 0                 # <- inciando a contagem temporal desde zero
fix production_nvt all nvt temp 300 300 50 # <- ensemble NVT a 300 K 
compute msd_water all msd com yes   # <- calcular o deslocamento quadratico médio das molêculas de água 
fix msd all ave/time 1 1 10 c_msd_water[4] file bulk_water_msd.dat  # <- salvar o msd a cada 10 pasos 
run 10000                        # <- tempo de simulação 5 ps
unfix production_nvt
uncompute msd_water
unfix msd

fix production_nvt all nvt temp 300 300 50 # <- ensemble NVT a 300 K 
dump positions all custom 100 bulk_water_nvt.lammpstrj id type mol x y z  # <- salvar configurações atômicas a cada 100 pasos 
dump_modify positions sort id    # <- salvar as configurações de forma ordenada, opcional
run 100000
#write_data prod_nvt_bulk_water.top   # <- salvar as informações da topologia do sistema equilibrado no volume médio
