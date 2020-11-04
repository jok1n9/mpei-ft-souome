N= 1e5; %n´umero de experiˆencias
k = 100; %numero de alvos
n = 10; %n´umero de dardos lançados 
u=0;
p=1;
d= zeros(1, k/n);
e= zeros(1, k/n);
for f=0: 10 :k
    lancamentos=0;
    u=0;
    for i= 1: N
        lancamentos = randi([1,k],f, 1); 
        b= unique(lancamentos);
        c= length(lancamentos)- length(b);
        if c == 0
            u=u+1 ;
        end
    end
    d(p)= u/N;
    e(p)= f;
    p=p+1;
end
plot(e, d);
probSimulacao= u/N;




