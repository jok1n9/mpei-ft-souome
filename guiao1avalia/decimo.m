N= 1e5;                                    %numero de experiencias
p1=0.002;                                    %probabilidade de estragar peça
p2=0.005;                                     %probabilidade de estragar peca2
pmontagem= 0.01;                            %probabilidade de montagem                                 
j=0;
estraga=0;%varivael2
probsimulacao= zeros(16, 1);
for k=0 : 16
    for f=1: N
        for i=0 :16
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