d= readtable("ola.txt");
moviesrating= d{:,2:20};
movies= d{:,1};
Nid=943;
minend= 20+Nid+1;

min= d{1:100, 21:minend};
Set= cell(Nid,1); 
for n=1: Nid
    
    Set{n}=[d{n,minend+1:end}];
    
    
end
