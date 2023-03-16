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


solve;

