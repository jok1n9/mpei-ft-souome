
prompt= "Insert User ID (1 to 943):";
x= input(prompt);
while(x <1 || x >943)
        fprintf("\nOut of bounds\n");
        prompt= "Try again:";
        
        x= input(prompt);
end

prompt="\n1 - Your Movies\n2 - Get Suggestions\n3 - Search Title\n4 - Exit Select\n choice:";
y= input(prompt);
while y~=4
    while(y <1 || y >4)
        fprintf("\nOut of bounds\n");
        prompt= "Try again:";
        
        y= input(prompt);
    end
    if y==1
        array= Set{x};
        for n=1: length(array)
            disp(d{array(n), 1});
            
        end
    elseif y==2
        prompt= "1- Action, 2- Adventure, 3- Animation, 4- Children’s\n5- Comedy, 6- Crime, 7- Documentary, 8- Drama\n9- Fantasy, 10- Film-Noir, 11- Horror, 12- Musical\n13- Mystery, 14- Romance, 15- Sci-Fi, 16- Thriller\n17- War, 18- Western\nSelect choice:";
        k= input(prompt);
        % add t as minhash
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
    elseif y==3
        prompt= "\nEnter title:";
        title= input(prompt, 's');
        search(title);
    end
    y= input(prompt);
end    
disp("end");