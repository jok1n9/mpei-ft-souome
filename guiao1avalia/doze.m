N= 1e5;                                    %numero de experiencias
p1=0.002;                                    %probabilidade de estragar peça
p2=0.005;                                     %probabilidade de estragar peca2
pmontagem= 0.001;                            %probabilidade de montagem                                 
j=0;
g=0;
n=20;
random=randperm(20, 20);
estraga=0;
caixa= zeros(20, 1);
probsimulacao= zeros(20, 1);
for m=1: 20
    for f=1: N
        for i=1 :n
            if (rand <p1)|| (rand<p2)|| (rand <pmontagem)  %se algum dos objetos estiver estragado ou o processo de montagem correr mal entra no ciclo
                estraga= estraga +1;
                caixa(random(i))=1;
            end
        end
        for i=1: m
            if caixa(i)== 1                 
                j=j+1;
                break;
            end
        end
        if estraga==0
            g=g+1;
        end
        estraga=0;                              %inicializa o numero de objeto de estragados a 0 para a próxima experiência
        caixa= zeros(20, 1);
    end
    probsimulacao(m)= g/(N-j);
    g=0;
    j=0;
end