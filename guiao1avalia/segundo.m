N= 1e4;                                    %numero de experiencias
p1=0.002;                                    %probabilidade de estragar peça
p2=0.005;                                     %probabilidade de estragar peca2
pmontagem= 0.01;                             %probabilidade de montagem
n=8;                                        %numero de brinquedos na caixa
j=0;    %variavel
l=0;
estraga=0;                                  %varivael2
for f=1: N
    peca1= rand(n);                         %8 numeros entre 0 e 1
    peca2= rand(n);                         %8 numeros entre 0 e 1 
    pmontagem1= rand(n);                    %8 numeros entre 0 e 1
    for i=0 :n
        if (peca1(i+1)<p1)|| (peca2(i+1)<p2)|| (pmontagem1(i+1)<pmontagem)  %se algum dos objetos estiver estragado ou o processo de montagem correr mal entra no ciclo
            estraga= estraga+1;             %adiciona um aos estragados
        end
    end 
    if estraga>=1                           
        j=j+1;                              %número de vezes em que a condição A se verifica
        l=l+estraga;                        %número total de brinquedos estragados de todas as vezes que a condição A se veerifica
    end
    estraga=0;                              %inicializa o numero de objeto de estragados a 0 para a próxima experiência
end
probsimulacao= l/j;                         %prob simulação