data= load('u.data');
us= data(1:end, 1:2); clear data;

filename = 'u_item.txt';
d = readtable(filename, 'Delimiter', '\t');% reading data from files

movies = unique(us(:,2));
id= unique(us(:,1));
Nid= length(id); 
Set= cell(height(d),1);
 
for n=1:Nid
    ind= find(us(:,1)== id(n));
    Set{n} = [Set{n} us(ind, 2)];
end
min= minHash(id, movies, Set);
min= 
tnew= [d ,min ,Set];
%d.set= Set;
%d.min= min; 
writetable(tnew, "ola.txt");


function [ minh ] = minHash(users, movies, Set)

    % Número primo>10^7
    p=10000019;
    hash=zeros(length(movies),1000);
    for i=1:1000
        % Parâmetros das funções de hash.
        a=randi([2,p-2]);
        c=randi([2,p-1]);
        hash(:,i)=mod(a*movies+c,p);
    end
    
    % Inicializa vetor com zeros
    minh=zeros(100,length(users));
    
    % Calcula minhash
    for i=1:100
        for u=1:length(users)
            minh(i,u)=min(hash(Set{users(u)},i));
        end
    end
end