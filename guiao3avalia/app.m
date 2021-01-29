d= readtable("ola.txt");% lê a tabela previamente escrita
moviesgenre= d{:,2:20};% retira 
movies= d{:,1};         % nomes dos filmes
Nid=943;                %quantidade de utilizadores
minend= 20+Nid;         %começo da minhash na tabela
userend= 1700;
t= d{1:100, 21:1700}; %minhash
Set= cell(Nid,1);       %cell com utilizadores e respetivos filmes
for n=1: Nid
    
    Set{n}=[d{n,minend+1:userend}];
    
    
end
minhash= d{:,userend+1:end};
minhash= minhash';
prompt= "Insert User ID (1 to 943):";
x= input(prompt);
while(x <1 || x >943)               %espera por um input dentro do número de utilizadores
        fprintf("\nOut of bounds\n");
        prompt= "Try again:";
        
        x= input(prompt);
end

prompt="\n1 - Your Movies\n2 - Get Suggestions\n3 - Search Title\n4 - Exit Select\n choice:";
y= input(prompt);
while y~=4          %enquanto o input 4 não aparecer não acaba
    while(y <1 || y >4)%rejeita qualquer input não desejado
        fprintf("\nOut of bounds\n");
        prompt= "Try again:";
        
        y= input(prompt);
    end
    if y==1     %lista os filmes do utilizador
        array= Set{x};
        array = array(~isnan(array))';
        for n=1: length(array)
            disp(d{array(n), 1});
            
        end
    elseif y==2 %dá sugestões do utilizador mais parecido sobre o tema inputed
        prompt= "1- Action, 2- Adventure, 3- Animation, 4- Children’s\n5- Comedy, 6- Crime, 7- Documentary, 8- Drama\n9- Fantasy, 10- Film-Noir, 11- Horror, 12- Musical\n13- Mystery, 14- Romance, 15- Sci-Fi, 16- Thriller\n17- War, 18- Western\nSelect choice:";
        k= input(prompt);

        sim=zeros( 1,length(t(1,:)));
        for i=1:length(t(1,:))
            sim(1,i)=sum(t(:,k)==t(:,i))/length(t(:,1));    
        end
        sim(k)=0;
        [M,I] = max(sim);
        array= Set{I};
        array = array(~isnan(array))';
        
        for n=1: length(array)
            if(moviesgenre(array(n), k+1)== 1)
                disp(d{array(n),1});
            end
        end
    elseif y==3 %search engine de acordo com o input
        prompt= "\nEnter title:";
        title= input(prompt, 's');
        s = searchMusic(title, minhash);
        if (~isempty(s(1,:)))
            fprintf('\nMúsicas com nome mais parecido: ');
            for i=1:length(s(1,:))
               fprintf('\nÍndice: %d; Nome: %s',s(1,i),pathToName(musics{s(1,i)}));
            end
        else
            fprintf('\nNão foram encontradas músicas com nome similar.');
        end
    end
    prompt="\n1 - Your Movies\n2 - Get Suggestions\n3 - Search Title\n4 - Exit Select\n choice:";
    y= input(prompt);
end    
disp("end");
% Diogo Ferreira e Fábio Cunha, 2015
function [ most ] = searchMusic( t, minh)
    % Recebe uma string com o nome da música a pesquisar e a table de
    % minHash e retorna array com os índices das músicas mais parecidas e o seu valor.
    nhash=1000;
    p=10000019;
	% NOTA: Threshold deve ser aumentado para set's +-maiores do que 2000!
    threshold=0.2;
    a=randi([2,p-2],1,nhash);
    c=randi([2,p-1],1,nhash);
    
    sim=minHashSingleDist(minh, musicSingleMinHash(t, a, c));
    most=zeros(2,length(find(sim>=threshold)));
    for i=1:length(find(sim>=0.2))
        m=find(sim==max(sim));
        most(1,i)=m(1,1);
        most(2,i)=max(sim);
        sim(most(1,i))=0;
    end
    
    
end
% Diogo Ferreira e Fábio Cunha, 2015
function [ minh ] = musicSingleMinHash( str,a,c )
    
    % Função que calcula minHash apenas para uma String, de acordo com os
    % valores para geração de hash recebidos.
    
    % Separa string de entrada em Shingles
    shingles=strsplit(str,{' ','-','.','','(',')'});
    j=1;
    shinglesname=cell(1,1);
    % Cada shingle é colocado na cell shinglesname.
    % Shinglesname é criado como uma cell 1x1, pois não se sabe à partida qual vai ser o seu
    % tamanho. Como é do tipo cell, não se pode fazer operações
    % vetoriais, pelo que trabalhar com for's pode ficar bastante lento neste caso.
    for k=1:length(shingles(1,:))
        if not(isequal(shingles(1,k),cellstr('mp3')) || isempty(shingles{1,k}))
            shinglesname{j,1}=shingles{1,k};
            j=j+1;
        end
    end
    
    % Calcula as hash para os shingles.
    k=1000;
    hash=zeros(length(shinglesname),k);
    % Número primo>10^7
    p=10000019;
    for j=1:length(shinglesname)
        hash(j,:)=mod(a(1,:)*sum(double(lower(shinglesname{j,1})))+c(1,:),p);
    end
    
    % Cria minHash Table.
    minh=Inf(k,1);
    
    for i=1:k
        for j=1:length(shinglesname)
            minh(i,1)=min(hash(j,i), minh(i,1));
        end
    end
    
end
% Diogo Ferreira e Fábio Cunha, 2015
function [ sim ] = minHashSingleDist( minh, minh2 )
    
    % Calcula distância baseada no minHash de um set e no minHash de uma
    % string.
    sim=zeros(length(minh(1,:)),1);
    for i=1:length(minh(1,:))
        sim(i,1)=sum(minh(:,i)==minh2(:,1))/length(minh(:,1));
    end

end
