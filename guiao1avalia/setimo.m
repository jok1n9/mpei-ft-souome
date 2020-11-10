N= 1e6;                                    %numero de experiencias
p1=0.002;                                    %probabilidade de estragar peça
p2=0.005;                                     %probabilidade de estragar peca2
pmontagem= 0.01;                            %probabilidade de montagem                                 
j=0;
n=8;
estraga=0;                                  %varivael2
probsimulacao= zeros(n, 1);
for k=0 : n
    for f=1: N
        for i=1 :n
            if (rand <p1)|| (rand<p2)|| (rand <pmontagem)  %se algum dos objetos estiver estragado ou o processo de montagem correr mal entra no ciclo
                estraga= estraga+1;             %adiciona um aos estragados
            end
        end 
        if estraga==k
            j=j+1;                             %número de vezes em que a condição A se verifica
        end
        estraga=0;                              %inicializa o numero de objeto de estragados a 0 para a próxima experiência
    end
    probsimulacao(k+1)= j/N;                         %prob simulação
    j=0;
end
stem(probsimulacao);
prob=0; % 2.b)X>=2 
for i=3: n
    prob = prob+probsimulacao(i);
end 
valoresperado=0; %valor esperado
for i=0: n
    valoresperado= probsimulacao(i+1)*i+valoresperado;
end
variancia=0; %variancia
for i=0: n
    variancia= variancia+ ((i-valoresperado)^2 * probsimulacao(i+1)) ;
end
desviopadrao= variancia^1/2;%desviopadrao