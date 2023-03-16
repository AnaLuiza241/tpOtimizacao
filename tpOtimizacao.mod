#Sets
set tarefas;
set veiculos;
set arcos;

#Par�metros
param R{veiculos}; #per�odo de loca��o para ve�culo k  
param P{veiculos}; #valor reembolsado do ve�culo k por unidade de tempo n�o utilizado
param C{veiculos}; #custo de opera��o do ve�culo k por unidade de tempo
param d{i in tarefas, j in tarefas}; #tempo de viagem ocioso entre a tarefa i e a tarefa j
param T{tarefas}; #tempo de entrega da tarefa; per�odo de tempo desde o in�cio do planejamento
param pi{tarefas}; #dura��o da tarefa i 
param e; #tempo m�ximo permitido de ociosidade entre duas tarefas consecutivas

#Vari�veis de decis�o
var Y{ij in arcos, k in veiculos}, binary; # se o arco(i,j) � percorrido pelo ve�culo k,
var ts{k in veiculos}; # hor�rio de in�cio do passeio para o ve�culo k
var tf{k in veiculos}; #hor�rio de t�rmino do passeio para o ve�culo k

#Fun��o Objetivo
minimize z: (sum{k in veiculos, ij in arcos} Y[ij, k]*R[k]*C[k]*(1 - P[k]) ) + ( sum{k in veiculos} (tf[k] - ts[k])*C[k]*P[k] );

#Restri��es

r1{t in tarefas}: sum{k in veiculos, ij in arcos} Y[ij, k] = 1;


solve;

