clc;
clear all;

shapes={'cat','centaur','david','dog','gorilla','horse','lioness','michael','seahorse','victoria','wolf'};
numberofshapes=[11,6,15,11,21,19,17,20,6,26,3];
k=1;
for i=1:1:size((shapes),2)
    for j=1:1:numberofshapes(i)
            if i==1 && j==7
                j=8;
                continue
            end
            if i==1 && j==10
                j=11;
                continue
            end
            if i==6 && j==2
                j=3;
                continue
            end
            if i==6 && j==12
                j=13;
                continue
            end
            if i==7 && j==12
                j=13;
                continue
            end
            if i==7 && j==10
                j=11;
                continue
            end
            if i==10 && j==9
                j=10;
                continue
            end
            if i==10 && j==16
                j=17;
                continue
            end
                shapeindexnoise{k}=sprintf('%s',shapes{i});
                 k=k+1;
                shapeindexnoise{k}=sprintf('%s',shapes{i});
                k=k+1;
                shapeindexnoise{k}=sprintf('%s',shapes{i});
                 k=k+1;
                shapeindexnoise{k}=sprintf('%s',shapes{i});
                 k=k+1;
                
    end
end
