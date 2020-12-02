n=4;
m=[0   0.3 0   0.3 0; %r
   0.3 0   0.3 0.1 0; %o
   0   0.2 0   0.2 0; %m
   0.7 0   0.7 0   0; %a
   0   1/2 0   0.4 0]; %.

%cria uma matriz de transição
basedados= ['r','o','m','a',' '];%cria caracteres na mesma posição que na matriz

a=cell(10e5, 1);%aloca espaço para 10e5 palavras em cell
for i=1: 10e5   %ciclo cria e aloca 10e5 palavras no cell criado anterior
    a{i}=basedados(crawl(m,randi(4),5)) ;
end
pD= length(unique(a));  %número de palavras não repetidas
Mpu= unique(a);         
[uc, ~, idc] = unique(a);
counts= accumarray(idc, ones(size(idc)));

M= cell(pD, 2);
for i=1:pD
    M(i,1)=Mpu(i);  %aloca as palavras não repetidas
    M(i,2)= num2cell(counts(i)/10e5); %aloca a probabilidade de se repetirem no array original
end
f=cell(5,2);%5 palavras mais usadas e probabilidade
M=sortrows(M,2); % ordena as probabilidades
for i=1: 5 
    f(i,1)= M(pD-i+1,1); %guarda aas primeiras 5 palavras
    f(i,2)= M(pD-i+1,2); %guarda as primeiras 5 probabilidades
end


fid=fopen('wordlist-preao-20201103.txt');
data=textscan(fid,'%s');
fclose(fid);
g= data{1}(1:end);%abrir e ler o ficheiro para uma célula

a=0;
h=intersect(g, Mpu);%interseta g com as palavras geradas
for i=1: length(Mpu)    
    if ismember(M(i,1), h)==1%se existir uma palavra em M
        a=a+cell2mat(M(i,2)); %somamos a probabilidade dessa palavra
    end
end





















function state = crawl(H, first, last)
% the sequence of states will be saved in the vector "state"
% initially, the vector contains only the initial state:
    state = [first];
    
% keep moving from state to state until state "last" is reached:
    while (1)
        a=nextState(H, state(end));
        if a== last%stops the atribution of the last state to the word 
            break;
        end
        state(end+1) = a;
    end
end


function state = crawl2(H, first, last, n)%add n

    state = [first];
    d=1;
    while (1)
        a=nextState(H, state(end));
        if (a== last || n==d)%stops the atribution of the last state to the word 
            break;
        end
        state(end+1) = a;
        d=d+1;
    end
end

function state = nextState(H, currentState)
% find the probabilities of reaching all states starting at the current one:
probVector = H(:,currentState); % probVector is a row vector
n = length(probVector); %n is the number of states
% generate the next state randomly according to probabilities probVector:
state = discrete_rnd(1:n, probVector);
end
% Generate randomly the next state.
% Inputs:
% states = vector with state values
% probVector = probability vector
function state = discrete_rnd(states, probVector)
    U=rand();
    i = 1 + sum(U > cumsum(probVector));
    state= states(i);
end