N= 1e5; %n´umero de experiˆencias
p = 0.5; %probabilidade de macho

k = 1; %n´umero de filhos machos
n = 4; %n´umero de filhos
for k= 
lancamentos = rand(n,N) > p;
sucessos= sum(lancamentos)==k;
probSimulacao= (sum(sucessos))/N;