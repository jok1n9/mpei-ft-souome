N= 1e6;                                    %numero de experiencias
p1=0.002;                                    %probabilidade de estragar peça
p2=0.005;                                     %probabilidade de estragar peca2
pmontagem= 0.01;                             %probabilidade de montagem
n=8;                                        %numero de brinquedos na caixa
j=0;                                        %variavel
estraga=0;                                  %varivael2
for f=1: N
    for i=1 :n
        if (rand <p1)|| (rand <p2)|| (rand <pmontagem)  %se algum dos objetos estiver estragado ou o processo de montagem correr mal entra no ciclo
            estraga= estraga+1;             %adiciona um aos estragados
        end
    end 
    if estraga>=1
        j=j+1;                              %número de vezes em que a condição A se verifica
    end
    estraga=0;                              %inicializa o numero de objeto de estragados a 0 para a próxima experiência
end
probsimulacao= j/N;                         %prob simulação