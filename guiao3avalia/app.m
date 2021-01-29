%%lê os dados
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
minhash= d{:,userend+1:end-2};
a= d{1:1000, end-1};
c= d{1:1000, end};
minhash= minhash';


%%começa a app
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
        while(k <1 || x >18)               %espera por um input dentro do número de utilizadores
            fprintf("\nOut of bounds\n");
            prompt= "Try again:";
        
            k= input(prompt);
        end
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
        prompt= "\nSearch title :";
        title= input(prompt, 's');
        [s] = searchfilmes(title, minhash, a , c);
        if (~isempty(s(1,:)))
            disp("\nFilmes com nome mais parecido: ");
            for j=1:length(s(1,:))
                disp(movies1(1,s(1,j)));
            end
        else
            disp("Filme não encontrado");
        end
    end
    prompt="\n1 - Your Movies\n2 - Get Suggestions\n3 - Search Title\n4 - Exit Select\n choice:";
    y= input(prompt);
end    
disp("end");

function [ notw] = searchfilmes( t, minh, a , c)
 
    threshold=0.8;
    
    [minh2]=filmeSingleMinHash(t, a, c);
    sim=minHashSingleDist(minh, minh2 );
    
    notw=zeros(2,length(find(sim>=threshold)));
    for i=1:length(find(sim>=0.2))
        m=find(sim==max(sim));
        notw(1,i)=m(1,1);
        notw(2,i)=max(sim);
        sim(notw(1,i))=0;
    end
end


function [ minh] = filmeSingleMinHash( str,a,c )
    shinglesname=cell(1,1);
    k=2;
    l=1;
    while(l<length(str)-k)
            shinglesname{l,1}= extractBetween(str,l,l+k);
            l=l+1;
    end
    k=1000;
    hash=zeros(length(shinglesname),k);
    p=10000019;
    for j=1:length(shinglesname)
        hash(j,:)=mod(a(1,:)*sum(double(lower(shinglesname{j,1}{:})))+c(1,:),p);
    end
    minh=Inf(k,1);
    for i=1:k
        for j=1:length(shinglesname)
            minh(i,1)=min(hash(j,i), minh(i,1));
        end
    end
    
end

function [ sim ] = minHashSingleDist( minh, minh2 )
    for i=1:length(minh(1,:))
        sim(1,i)=sum(minh(:,i)==minh2(:,1))/length(minh(:,1)); 
    end

end
