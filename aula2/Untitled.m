N= 1e5; %n´umero de experiˆencias
p = 0.5; %probabilidade de macho

k = 1; %n´umero de filhos machos
h = 2; %numero de filhos machos
n = 2; %n´umero de filhos
lancamentos = rand(n,N) > p;
sucessos= sum(lancamentos)==k;

sucessos2= sum(lancamentos)==h;
probSimulacao= (sum(sucessos)+sum(sucessos2))/N;

Pmf= 1/4;
Pfm= Pmf;
Pmm= 1/4;
probteorica= Pmf+ Pfm+ Pmm; 