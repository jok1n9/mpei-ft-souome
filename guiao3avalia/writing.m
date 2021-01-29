data= load('u.data');
us= data(1:end, 1:2); clear data;

filename = 'u_item.txt';
d = readtable(filename, 'Delimiter', '\t');% reading data from files


movies1= d(1:end,1);
movies1= table2cell(movies1);
movies1= movies1';

movies = unique(us(:,2));
id= unique(us(:,1));
Nid= length(id); 
Set= cell(height(d),1);
nhash=1000;
for n=1:Nid
    ind= find(us(:,1)== id(n));
    Set{n} = [Set{n} us(ind, 2)];
end
[minh, hash,a, c]= filmesMinHash(movies1, 1000);
min= minHash(id, movies, Set, height(d));



function [minh,hash, a, c]= filmesMinHash(filmes, nhash)
    j=1;

    shinglesl=cell(length(filmes),50);
    shingles=cell(1,1);
    x=0;
    for i=1:length(filmes)
        k=2;
        l=1;
       
        while(l<length(filmes{1,i})-k)
            shingles{i,l}= extractBetween(filmes{1,i},l,l+k);
            %shingleslength{i,l}=j;
            l=l+1;
            j=j+1;
        end
    end 

    p=10000019;
    hash=zeros(length(shingles),nhash);
    a=randi([2,p-2],1,1682);
    c=randi([2,p-1],1,1682);
    

    for j=1:length(shingles)
        hash(j,:)=mod(a(1,1:nhash)*sum(double(lower(shingles{j,1}{1})))+c(1,1:nhash),p);
    end

    minh=Inf(length(filmes),nhash);
    l=1;

    for j=1:length(filmes)
        k=1;
        while k<max(sum(cellfun('length',shinglesl),2)) && not(isempty(shinglesl{j,k}))
            minh(j,:)=min(hash(shinglesl{j,k},:), minh(j,:));
            k=k+1;
            l=l+1;
         end
    end

end
function [ minh ] = minHash(users, movies, Set, size)

    
    p=10000019;
    hash=zeros(length(movies),1000);
    for i=1:1000
        
        a=randi([2,p-2]);
        c=randi([2,p-1]);
        hash(:,i)=mod(a*movies+c,p);
    end
    
    
    minh=zeros(size,length(users));
    
    for i=1:100
        for u=1:length(users)
            minh(i,u)=min(hash(Set{users(u)},i));
        end
    end
end

