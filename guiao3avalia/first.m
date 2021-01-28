data= load('u.data');
us= data(1:end, 1:2); clear data;

filename = 'u_item.txt';
d = readtable(filename, 'Delimiter', '\t');% reading data from files

movies = unique(us(:,2));
id= unique(us(:,1));
Nid= length(id); 
Set= cell(Nid,1);

for n=1:Nid
    ind= find(us(:,1)== id(n));
    Set{n} = [Set{n} us(ind, 2)];
end 



prompt= "Insert User ID (1 to 943):";
x= input(prompt);
checknumber(x, 1, 943);%asks and checks id until its valid
y=0;
prompt="\n1 - Your Movies\n2 - Get Suggestions\n3 - Search Title\n4 - Exit Select\n choice:";
y= input(prompt);
while y~=4
    checknumber(y, 1, 4);
    if y==1
        array= Set{x};
        for n=1: length(array)
            disp(d{array(n), 1});
            
        end
    elseif y==2
        getSugg(x, id,movies , Set, d);
    elseif y==3
        prompt= "\nEnter title:";
        title= input(prompt, 's');
        search(title);
    end
    y= input(prompt);
end    
disp("end");

function checknumber( id, min, max )
    if(id <min || id >max)
        fprintf("\nOut of bounds\n");
        prompt= "Try again:";
        
        id= input(prompt);
        checknumber(id, 1, 943);
        return;
    end
    fprintf("\nNumber %d is valid\n", id);
    
end


function getSugg(id, users, movies, Set, d)
    prompt= "1- Action, 2- Adventure, 3- Animation, 4- Children’s\n5- Comedy, 6- Crime, 7- Documentary, 8- Drama\n9- Fantasy, 10- Film-Noir, 11- Horror, 12- Musical\n13- Mystery, 14- Romance, 15- Sci-Fi, 16- Thriller\n17- War, 18- Western\nSelect choice:";
    k= input(prompt);
    t=minHash(users, movies, Set);
    sim=zeros(length(t(1,:)));
    for j=1:length(t(1,:))
       sim(j)=sum(t(:,id)==t(:,j))/length(t(:,1));    
    end
    [M,I] = max(sim);
    array= Set{I};
    w= table2array(d(:,k+2));
    for n=1: length(array)
        if(w(array(n))== 1)
            disp(d{array(n),1});
        end
    end
end

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

function search(title)
    disp(title);
end