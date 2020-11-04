x=[1:6];
px= 1/6* ones(1,6);
stem(x, px);%massa de probabilidade
fx= cumsum(px);
stairs([0 ,x, 7 ], [0, fx, 1.2]);%distribuição acumulada
