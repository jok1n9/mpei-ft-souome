fid=fopen('u.data', 'r');
size= [2 Inf];
data= fscanf(fid, '%d %f %*f %*f', size);
fclose(fid);
data= data';
filename = 'u_item.txt';
d = readtable(filename, 'Delimiter', '\t');% reading data from files



prompt= "Insert User ID (1 to 943):";
x= input(prompt);
checknumber(x, 1, 943);%asks and checks id until its valid
y=0;
prompt="\n1 - Your Movies\n2 - Get Suggestions\n3 - Search Title\n4 - Exit Select\n choice:";
while y~=4
    y= input(prompt);
    checknumber(y, 1, 4);
    if y==1
        yourMov(x, data, d);
    elseif y==2
        getSugg(x);
    elseif y==3
        prompt= "\nEnter title:";
        title= input(prompt, 's');
        search(title);
    end
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

function yourMov(id, data, d)
    for i=1: length(data)
        if(data(i, 1)== id)
            disp(d{data(i,2), 1}) ;
        end  
    end  
end
function getSugg(id)
    disp(id);
end
function search(title)
    disp(title);
end

