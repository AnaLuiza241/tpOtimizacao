#Sets
set tarefas;
set veiculos;
set arcos;

#Parâmetros
param R{veiculos}; #período de locação para veículo k  
param P{veiculos}; #valor reembolsado do veículo k por unidade de tempo não utilizado
param C{veiculos}; #custo de operação do veículo k por unidade de tempo
param d{i in tarefas, j in tarefas}; #tempo de viagem ocioso entre a tarefa i e a tarefa j
param T{tarefas}; #tempo de entrega da tarefa; período de tempo desde o início do planejamento
param pi{tarefas}; #duração da tarefa i 
param e; #tempo máximo permitido de ociosidade entre duas tarefas consecutivas

#Variáveis de decisão
var Y{ij in arcos, k in veiculos}, binary; # se o arco(i,j) é percorrido pelo veículo k,
var ts{k in veiculos}; # horário de início do passeio para o veículo k
var tf{k in veiculos}; #horário de término do passeio para o veículo k

#Função Objetivo
minimize z: (sum{k in veiculos, ij in arcos} Y[ij, k]*R[k]*C[k]*(1 - P[k]) ) + ( sum{k in veiculos} (tf[k] - ts[k])*C[k]*P[k] );

#Restrições

r1{t in tarefas}: sum{k in veiculos, ij in arcos} Y[ij, k] = 1;

r2{j in tarefas, k in veiculos}: sum{ ij in arcos} Y[ij,k] - sum{ji in arcos} Y[ji,k] = 0;

r3{k in veiculos}: sum{ij in arcos} Y[ij,k] <= 1;

r4{j in tarefas, k in veiculos}: sum{ij in arcos} Y[ij,k] - sum{ji in arcos}Y[ji,k] = 0;

# r5{ij in arcos, k in veiculos}: ts >= Ti - pi - M(1 - Y[ij,k]);

# r6{ij in arcos, k in veiculos}: ts <= Ti - pi + M(1 - Y[ij,k]);

# r7{ij in arcos, k in veiculos}: tf >= Ti - M(1 - Y[ij,k]);

# r8{ij in arcos, k in veiculos}: tf <= Ti - M(1 + Y[ij,k]);

# r9{ji in arcos, k in veiculos}: Ti <= Tj + dji + M(1 - Y[ji,k]) + e;

# r10{ji in arcos, k in veiculos}: Ti >= Tj + dji - M(1 - Y[ji,k]);

# r11{k in veiculos}: tf - ts <= Rk * sum{ij in arcos} Y[ij,k];

# r12{ij in arcos, k in veiculos}: Y[ij,k] binary;

# r13{k in veiculos}: ts, tf >= 0;


solve;

data;
set tarefas := 1 2 3 4 5 6 7 8 9 10;

param T :=
1	329
2	369
3	460
4	478
5	528
6	550
7	578
8	658
9	723
10	784;

set veiculos := 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 
				18 19 20 21 22 23 24 25 26 27 28 29 30;

param R :=
1 360
2 360
3 360
4 360
5 360
6 360
7 360
8 720
9 720
10 720
11 720
12 720
13 720
14 720
15 360
16 360
17 360
18 360
19 360
20 360
21 720
22 720
23 720
24 720
25 720
26 720
27 720
28 720
29 720
30 720;

param C := 
1 3.47
2 3.47
3 3.47
4 3.47
5 3.47
6 3.47
7 3.47
8 2.19
9 2.19
10 2.19
11 2.19
12 2.19
13 2.19
14 2.19
15 3.47
16 3.47
17 3.47
18 3.47
19 3.47
20 3.47
21 2.19
22 2.19
23 2.19
24 2.19
25 2.19
26 2.19
27 2.19
28 2.19
29 2.19
30 2.19;

param P :=
1 0.25
2 0.25
3 0.25
4 0.25
5 0.25
6 0.25
7 0.25
8 0.20
9 0.20
10 0.20
11 0.20
12 0.20
13 0.20
14 0.20
15 0.25
16 0.25
17 0.25
18 0.25
19 0.25
20 0.25
21 0.20
22 0.20
23 0.20
24 0.20
25 0.20
26 0.20
27 0.20
28 0.20
29 0.20
30 0.20;


set arcos := 25 26 27 49 39 38 18 810;