N= 1e5; %n´umero de experiˆencias
p = 1; %probabilidade de macho

k = 1; %n´umero de filhos machos
n = 2; %n´umero de filhos
lancamentos = rand(n,N) > p;
sucessos= sum(lancamentos)==k;


probSimulacao= sum(sucessos)/N;

proteorica= 1/3;